--[[
Copyright © 2022, catalyst-ffxi
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
    * Neither the name of Debuffed nor the
    names of its contributors may be used to endorse or promote products
    derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL catalyst-ffxi BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

_addon.name='Setlist'
_addon.author='catalyst-ffxi'
_addon.version='0.9'
_addon.commands={'setlist', 'sl'}

resources = require('resources')
files = require('files')
texts = require('texts')
config = require('config')
require('logger')

local songs = {}
local queue = L{}

local state = {
  interrupts = 0,
  set_name = nil,
  running = false,
  run_next = 0
}

local settings = config.load({
  sp = false,
  nitro = false,
  roller = true,
  song_duration = 4,
  max_interrupt = 3,
  display = {
    x = 1800,
    y = 800,
    visible = true
  }
})

local help_text = [[
Setlist commands:
//sl [set_name] -- play the specified set
//sl stop -- stop playing
//sl start [set_name] -- play the specified set continuously
//sl switch [set_name] -- switch playing to a different set
//sl next [n] -- set the next play value to n seconds from now
//sl duration [n] -- set your base song duration in minutes (*without* NITRO)
//sl sp -- toggle use of SP abilities
//sl nitro -- toggle use of NITRO
//sl roller -- toggle integration with roller
//sl visible -- show or hide the display
//sl save -- save current settings
]]

local display_template = [[
Setlist
-------
\cs(${color})Running:\cr ${running|false}
  \cs(${color})NITRO:\cr ${nitro|No}
     \cs(${color})SP:\cr ${sp|No}
    \cs(${color})Set:\cr ${set_name|n/a}
   \cs(${color})Next:\cr ${next_sing|n/a}
  \cs(${color})Queue:\cr ${queue|none}
]]

local display = texts.new(
  display_template,
  {
    pos = { x = settings.display.x, y = settings.display.y },
    bg = { alpha = 50 },
    text = {
      size = 10,
      font = 'Consolas',
      stroke = {
          width = 1,
          alpha = 200
      }
    },
    padding = 4,
    flags = {
      draggable = true,
      right = false,
      bottom = false,
      bold = true 
    }
  }
)

if settings.display.visible then
  display:show()
end

function update_display()
  display.color = '100,200,200'
  display.nitro = settings.nitro and 'Yes' or 'No'
  display.sp = settings.sp and 'Yes' or 'No'
  display.running = state.running and 'Yes' or 'No'
  display.set_name = state.set_name

  if state.running and state.run_next > 0 then
    display.next_sing = math.ceil(state.run_next - os.clock())
  else
    display.next_sing = nil
  end

  if #queue > 0 then
    display.queue = queue:concat('\n      => ')
  else
    display.queue = nil
  end
end

function save()
  local pos_x, pos_y = display:pos()
  settings.display.x = pos_x
  settings.display.y = pos_y
  settings:save()
end

windower.register_event('load', function()
  local file = files.new('songs.lua')

  if file:exists() then
    songs = require('songs')
  else
    notice('Creating songs file...')
    file:write('return {}')
  end

  update_display:loop(1)
  do_songs:loop(3)
end)

windower.register_event('login', function()
  player = windower.ffxi.get_player()
end)

windower.register_event('addon command', function(...)
  cmd = {...}
  command = cmd[1]
  if command == 'help' then
    local chat = windower.log
    log(help_text)
  elseif command == 'start' then
    if cmd[2] == nil then
      error('You must pass a set name to this command')
    elseif songs[cmd[2]] == nil then
      error('Set '.. cmd[2] ..' not found')
    elseif songs[cmd[2]] then
      state.set_name = cmd[2]
      state.running = true
      state.run_next = 0
      if cmd[3] ~= nil then
        local int = tonumber(cmd[3])
        if int > 0 then
          state.run_next = os.clock() + int
        end
      end
      log('Starting continuous sing with set: ' .. state.set_name)
    end
  elseif command == 'stop' then
    stop()
  elseif command == 'visible' then
    settings.display.visible = not settings.display.visible
    save()
    if settings.display.visible then
      display:show()
    else
      display:hide()
    end
  elseif command == 'sp' then
    settings.sp = not settings.sp
    local verb = settings.sp and 'Start' or 'Stop'
    log(verb .. ' using SP abilities')
    save()
  elseif command == 'nitro' then
    settings.nitro = not settings.nitro
    local verb = settings.nitro and 'Start' or 'Stop'
    log(verb .. ' using NITRO')
    save()
  elseif command == 'roller' then
    settings.roller = not settings.roller
    local verb = settings.roller and 'Start' or 'Stop'
    log(verb .. ' using roller')
    save()
  elseif command == 'duration' then
    local duration = tonumber(cmd[2])
    if duration ~= nil and duration > 0 then
      settings.song_duration = duration
      log('Setting base song duration to ' .. duration .. ' minutes')
      save()
    else
      error('The "duration" command requires a positive integer')
    end
  elseif command == 'next' then
    local next = tonumber(cmd[2])
    if next ~= nil and next > 0 then
      state.run_next = os.clock() + next
      log('Set next run to ' .. next .. ' seconds from now')
    else
      error('The "next" command requires a positive integer')
    end
  elseif command == 'switch' then
    if cmd[2] == nil then
      error('You must pass a set name to this command')
    elseif songs[cmd[2]] == nil then
      error('Set '.. cmd[2] ..' not found')
    elseif songs[cmd[2]] then
      state.set_name = cmd[2]
      log('Switching active song set to: ' .. state.set_name)
    end
  elseif command == 'save' then
    save()
  else
    play_set(command)
  end
end)

windower.register_event('zone change', function(new_zone, old_zone)
  stop()
end)

windower.register_event('job change', function()
  stop()
end)

windower.register_event('status change', function(new_status_id , old_status_id)
  if new_status_id == 2 then -- player is KO
    stop()
  elseif new_status_id == 33 then -- player rested
    queue:clear()
  end
end)

function stop()
  if state.running or #queue > 0 then
    log('Stopping')
  end
  state.running = false
  state.set_name = nil
  queue:clear()
end

-- Play a set
--
function play_set(set_name)
  queue:clear()
  state.interrups = 0

  set = songs[set_name]
  if set then
    for key, val in ipairs(set) do
      if resources.spells:with('name', val) == nil then
        error('Song ' .. val .. ' does not exist. Check your spelling.')
        queue:clear()
        return
      end
      queue:append(val)
    end
  else
    error("Set ".. set_name .." not found")
  end

  play_next_song()
end

-- Plays the next queued song
--
function play_next_song()
  if #queue > 0 then
    local song = queue[1]
    local target = "<me>"

    log('Playing '..song)
    windower.chat.input('/ma "' .. song .. '" ' .. target)
  elseif state.running and settings.roller and windower.ffxi.get_player().sub_job == 'COR' then
    windower.send_command('roller start')
  end
end

-- React to a completed song
--
windower.register_event('action', function(action)
  if action.actor_id ~= windower.ffxi.get_player().id then return end

  if #queue > 0 then

    local current_song_id =  resources.spells:with('name', queue[1]).id

    if action.category == 4 and action.param == current_song_id then
      -- Queue up the next song
      queue:remove(1)
      coroutine.schedule(play_next_song, 3)

    elseif action.category == 8 and action.param == 28787
      and action.targets[1].actions[1].param == current_song_id then

      -- Song was interrupted, retry
      state.interrups = state.interrups + 1

      if state.interrups >= settings.max_interrupt then
        log('Interrupted too many times')
        queue:clear()
      else
        log('Interupted and retrying')      
        coroutine.schedule(play_next_song, 3)
      end
    end
  elseif state.running and (state.run_next - os.clock() < 3) and action.category > 1 then
    state.run_next = state.run_next + 3
  end
end)

function do_songs()
  if state.running == false or state.run_next > os.clock() or in_exp_zone() == false then
    return
  end

  if windower.ffxi.get_player().status == 2 then
    return -- player is dead
  end
  
  local night = get_ability_recast('Nightingale')
  local trob = get_ability_recast('Troubadour')
  local clarion = get_ability_recast('Clarion Call')
  local soul = get_ability_recast('Soul Voice')
  local marcato = get_ability_recast('Marcato')
  local wait = settings.song_duration * 60

  local commands = L{}

  if settings.roller and windower.ffxi.get_player().sub_job == 'COR' then
    commands:append('roller stop')
  end

  if settings.nitro and night == 0 and trob == 0 then
    if settings.sp and clarion == 0 and soul == 0 then
      log('Singing ' .. state.set_name .. ' with SV/Clarion')
      commands:append('input /ja "Soul Voice" <me>')
      commands:append('input /ja "Clarion Call" <me>')
    elseif marcato == 0 then
      log('Singing ' .. state.set_name .. ' with Marcato')
      commands:append('input /ja "Marcato" <me>')
    end
    commands:append('input /ja "Nightingale" <me>')
    commands:append('input /ja "Troubadour" <me>')
    wait = wait * 2
  else
    log('Singing ' .. state.set_name)
  end

  commands:append('sl ' .. state.set_name)

  local command_string = commands:concat('; wait 1.3;')
  windower.send_command(command_string)

  log('Sing again in ' .. wait .. ' seconds')
  state.run_next = os.clock() + wait
end

function get_ability_recast(name)
  local recasts = windower.ffxi.get_ability_recasts()
  local ability = resources.job_abilities:with('name', name)

  return recasts[ability.recast_id]
end

local zone_whitelist = S{
  "Phanauet Channel",
  "Carpenters' Landing",
  "Manaclipper",
  "Bibiki Bay",
  "Uleguerand Range",
  "Bearclaw Pinnacle",
  "Attohwa Chasm",
  "Boneyard Gully",
  "Pso'Xja",
  "The Shrouded Maw",
  "Oldton Movalpolos",
  "Newton Movalpolos",
  "Mine Shaft #2716",
  "Hall of Transference",
  "Abyssea - Konschtat",
  "Promyvion - Holla",
  "Spire of Holla",
  "Promyvion - Dem",
  "Spire of Dem",
  "Promyvion - Mea",
  "Spire of Mea",
  "Promyvion - Vahzl",
  "Spire of Vahzl",
  "Lufaise Meadows",
  "Misareaux Coast",
  "Phomiuna Aqueducts",
  "Sacrarium",
  "Riverne - Site #B01",
  "Riverne - Site #A01",
  "Monarch Linn",
  "Sealion's Den",
  "Al'Taieu",
  "Grand Palace of Hu'Xzoi",
  "The Garden of Ru'Hmet",
  "Empyreal Paradox",
  "Temenos",
  "Apollyon",
  "Dynamis - Valkurm",
  "Dynamis - Buburimu",
  "Dynamis - Qufim",
  "Dynamis - Tavnazia",
  "Diorama Abdhaljs-Ghelsba",
  "Abdhaljs Isle-Purgonorgo",
  "Abyssea - Tahrongi",
  "Open sea route to Al Zahbi",
  "Open sea route to Mhaura",
  "Al Zahbi",
  "Aht Urhgan Whitegate",
  "Wajaom Woodlands",
  "Bhaflau Thickets",
  "Nashmau",
  "Arrapago Reef",
  "Ilrusi Atoll",
  "Periqia",
  "Talacca Cove",
  "Silver Sea route to Nashmau",
  "Silver Sea route to Al Zahbi",
  "The Ashu Talif",
  "Mount Zhayolm",
  "Halvung",
  "Lebros Cavern",
  "Navukgo Execution Chamber",
  "Mamook",
  "Mamool Ja Training Grounds",
  "Jade Sepulcher",
  "Aydeewa Subterrane",
  "Leujaoam Sanctum",
  "The Colosseum",
  "Alzadaal Undersea Ruins",
  "Zhayolm Remnants",
  "Arrapago Remnants",
  "Bhaflau Remnants",
  "Silver Sea Remnants",
  "Nyzul Isle",
  "Hazhalm Testing Grounds",
  "Caedarva Mire",
  "East Ronfaure [S]",
  "Jugner Forest [S]",
  "Vunkerl Inlet [S]",
  "Batallia Downs [S]",
  "La Vaule [S]",
  "Everbloom Hollow",
  "North Gustaberg [S]",
  "Grauberg [S]",
  "Pashhow Marshlands [S]",
  "Rolanberry Fields [S]",
  "Beadeaux [S]",
  "Ruhotz Silvermines",
  "West Sarutabaruta [S]",
  "Fort Karugo-Narugo [S]",
  "Meriphataud Mountains [S]",
  "Sauromugue Champaign [S]",
  "Castle Oztroja [S]",
  "West Ronfaure",
  "East Ronfaure",
  "La Theine Plateau",
  "Valkurm Dunes",
  "Jugner Forest",
  "Batallia Downs",
  "North Gustaberg",
  "South Gustaberg",
  "Konschtat Highlands",
  "Pashhow Marshlands",
  "Rolanberry Fields",
  "Beaucedine Glacier",
  "Xarcabard",
  "Cape Teriggan",
  "Eastern Altepa Desert",
  "West Sarutabaruta",
  "East Sarutabaruta",
  "Tahrongi Canyon",
  "Buburimu Peninsula",
  "Meriphataud Mountains",
  "Sauromugue Champaign",
  "The Sanctuary of Zi'Tah",
  "Ro'Maeve",
  "Yuhtunga Jungle",
  "Yhoator Jungle",
  "Western Altepa Desert",
  "Qufim Island",
  "Behemoth's Dominion",
  "Valley of Sorrows",
  "Ghoyu's Reverie",
  "Mordion Gaol",
  "Abyssea - La Theine",
  "Outer Ra'Kaznar [U2]",
  "Dynamis - Beaucedine",
  "Dynamis - Xarcabard",
  "Beaucedine Glacier [S]",
  "Xarcabard [S]",
  "Castle Zvahl Baileys [S]",
  "Horlais Peak",
  "Ghelsba Outpost",
  "Fort Ghelsba",
  "Yughott Grotto",
  "Palborough Mines",
  "Waughroon Shrine",
  "Giddeus",
  "Balga's Dais",
  "Beadeaux",
  "Qulun Dome",
  "Davoi",
  "Monastic Cavern",
  "Castle Oztroja",
  "Altar Room",
  "The Boyahda Tree",
  "Dragon's Aery",
  "Castle Zvahl Keep [S]",
  "Throne Room [S]",
  "Middle Delkfutt's Tower",
  "Upper Delkfutt's Tower",
  "Temple of Uggalepih",
  "Den of Rancor",
  "Castle Zvahl Baileys",
  "Castle Zvahl Keep",
  "Sacrificial Chamber",
  "Garlaige Citadel [S]",
  "Throne Room",
  "Ranguemont Pass",
  "Bostaunieux Oubliette",
  "Chamber of Oracles",
  "Toraimarai Canal",
  "Full Moon Fountain",
  "Crawlers' Nest [S]",
  "Zeruhn Mines",
  "Korroloka Tunnel",
  "Kuftal Tunnel",
  "The Eldieme Necropolis [S]",
  "Sea Serpent Grotto",
  "Ve'Lugannon Palace",
  "The Shrine of Ru'Avitau",
  "Stellar Fulcrum",
  "La'Loff Amphitheater",
  "The Celestial Nexus",
  "Walk of Echoes",
  "Maquette Abdhaljs-LegionA",
  "Lower Delkfutt's Tower",
  "Dynamis - San d'Oria",
  "Dynamis - Bastok",
  "Dynamis - Windurst",
  "Dynamis - Jeuno",
  "Outer Ra'Kaznar [U3]",
  "King Ranperre's Tomb",
  "Dangruf Wadi",
  "Inner Horutoto Ruins",
  "Ordelle's Caves",
  "Outer Horutoto Ruins",
  "The Eldieme Necropolis",
  "Gusgen Mines",
  "Crawlers' Nest",
  "Maze of Shakhrami",
  "Garlaige Citadel",
  "Cloister of Gales",
  "Cloister of Storms",
  "Cloister of Frost",
  "Fei'Yin",
  "Ifrit's Cauldron",
  "Qu'Bia Arena",
  "Cloister of Flames",
  "Quicksand Caves",
  "Cloister of Tremors",
  "Cloister of Tides",
  "Gustav Tunnel",
  "Labyrinth of Onzozo",
  "Abyssea - Attohwa",
  "Abyssea - Misareaux",
  "Abyssea - Vunkerl",
  "Abyssea - Altepa",
  "Ship bound for Selbina",
  "Ship bound for Mhaura",
  "Provenance",
  "Ship bound for Selbina",
  "Ship bound for Mhaura",
  "Throne Room [V]",
  "Hall of the Gods",
  "Abyssea - Uleguerand",
  "Abyssea - Grauberg",
  "Abyssea - Empyreal Paradox",
  "Western Adoulin",
  "Eastern Adoulin",
  "Rala Waterways",
  "Rala Waterways [U]",
  "Yahse Hunting Grounds",
  "Ceizak Battlegrounds",
  "Foret de Hennetiel",
  "Yorcia Weald",
  "Yorcia Weald [U]",
  "Morimar Basalt Fields",
  "Marjami Ravine",
  "Kamihr Drifts",
  "Sih Gates",
  "Moh Gates",
  "Cirdas Caverns",
  "Cirdas Caverns [U]",
  "Dho Gates",
  "Woh Gates",
  "Outer Ra'Kaznar",
  "Outer Ra'Kaznar [U1]",
  "Ra'Kaznar Inner Court",
  "Ra'Kaznar Turris",
  "Gwora - Corridor",
  "Walk of Echoes [P2]",
  "Mount Kamihr",
  "Silver Knife",
  "Celennia Memorial Library",
  "Feretory",
  "Maquette Abdhaljs-LegionB",
  "Escha - Zi'Tah",
  "Escha - Ru'Aun",
  "Desuetia - Empyreal Paradox",
  "Reisenjima",
  "Reisenjima Henge",
  "Reisenjima Sanctorium",
  "Dynamis - San d'Oria [D]",
  "Dynamis - Bastok [D]",
  "Dynamis - Windurst [D]",
  "Dynamis - Jeuno [D]",
  "Walk of Echoes [P1]",
  "Gwora - Throne Room",
}

function in_exp_zone()
  -- return true
  return zone_whitelist:contains(resources.zones[windower.ffxi.get_info().zone].english)
end
