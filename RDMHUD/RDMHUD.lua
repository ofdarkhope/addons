--[[
RDMHUD - A Red Mage heads-up display for Windower4

INSTALL:
  1. Create a folder named "RDMHUD" inside your Windower4/addons/ directory.
  2. Put this file in it as: Windower4/addons/RDMHUD/RDMHUD.lua
  3. In-game (or in a Lua console), type: //lua load rdmhud
  4. To auto-load every session, add "lua load rdmhud" to your init.txt.

COMMANDS:
  //rdmhud lock          - lock the HUD position (ignores drag)
  //rdmhud unlock        - unlock it so you can drag it around
  //rdmhud reload        - reload the addon
  //rdmhud scale <n>     - set text scale, e.g. //rdmhud scale 1.2

CUSTOMIZATION:
  Edit the TRACKED_ABILITIES, TRACKED_SPELLS, and TRACKED_BUFFS tables below
  to add/remove anything you want watched. Names must match the in-game
  English names exactly (case-insensitive matching is done for you).

NOTE ON ACCURACY:
  Job ability / spell recast countdowns come straight from the game client
  via windower.ffxi.get_ability_recasts() / get_spell_recasts(), so those
  numbers are exact. Buff *durations* are NOT reliably exposed by the API
  (that requires parsing combat/action packets, like the "Timers" addon
  does) so buffs are shown as simple ON/OFF indicators rather than
  countdowns. If your Windower version's recast array indexing differs
  slightly, look at the "-- ADJUST HERE" comment in get_ability_recast().
--]]

_addon.name = 'RDMHUD'
_addon.author = 'Claude'
_addon.version = '1.0.0'
_addon.commands = {'rdmhud'}

require('logger')
require('strings')
local texts = require('texts')
local res = require('resources')

----------------------------------------------------------------------
-- CONFIG - tweak freely
----------------------------------------------------------------------

local config = {
    pos_x   = 200,
    pos_y   = 400,
    locked  = false,
    scale   = 1.0,
    font    = 'Consolas',
    bg_alpha = 180,
}

-- Buffs to show as ON/OFF indicators (matched against res.buffs names).
local TRACKED_BUFFS = {
    'Haste',
    'Refresh',
    'Phalanx',
    'Stoneskin',
    'Regen',
    'Composure',
	'Minuet',
	'March',
	'Ballad',
}

color_red = "\\cs(255,54,60)"
color_green = "\\cs(0,192,0)"

----------------------------------------------------------------------
-- INTERNAL STATE
----------------------------------------------------------------------

-- Build lookup tables from resources so we're not scanning res.* every frame.

local buff_lookup = {}      -- name -> id
for id, buff in pairs(res.buffs) do
	-- SDW added specific numbers for buffs we don't want included in the table as there are duplicates.
	-- should probably just remove duplicates from the final table.
    if buff and buff.en and buff.en ~= '' and buff.id ~= 580 and buff.id ~= 541 and buff.id ~= 539 then
        buff_lookup[buff.en:lower()] = id
    end
end

-- Resolve our tracked lists into the actual resource data once at load time.

local resolved_buffs = {}
for _, name in ipairs(TRACKED_BUFFS) do
    local id = buff_lookup[name:lower()]
    if id then
        table.insert(resolved_buffs, {name = name, id = id})
    else
        log('RDMHUD: could not find buff "'..name..'" in resources - skipping.')
    end
end

----------------------------------------------------------------------
-- TEXT BOX
----------------------------------------------------------------------

local hud = texts.new('', {
    pos = {x = config.pos_x, y = config.pos_y},
    text = {font = config.font, size = 10 * config.scale},
    flags = {draggable = true},
    bg = {visible = true, alpha = config.bg_alpha},
    padding = 6,
})
hud:show()

----------------------------------------------------------------------
-- HELPERS
----------------------------------------------------------------------

-- Player job abilities recasts: windower.ffxi.get_ability_recasts()
-- returns a table of recast times (in seconds) indexed by recast_id + 1.
-- ADJUST HERE: if these numbers look wrong for your version of Windower,
-- try changing "recast_id + 1" to just "recast_id".

local function has_buff(buffs_active, buff_id)
    for _, id in ipairs(buffs_active) do
        if id == buff_id then return true end
    end
    return false
end

----------------------------------------------------------------------
-- MAIN RENDER LOOP
----------------------------------------------------------------------

local function build_hud_text()
    local player = windower.ffxi.get_player()
    if not player then
        return 'RDMHUD: waiting for character...'
    end

    local lines = {}

    --table.insert(lines, string.format('[%s] Lv.%d  MP: %d/%d  TP: %d',
    --    player.name or '?', player.main_job_level or 0,
    --    player.vitals and player.vitals.mp or 0,
    --    player.vitals and player.vitals.max_mp or 0,
    --    player.vitals and player.vitals.tp or 0))

    --table.insert(lines, '------------------------------')
    table.insert(lines, 'Buffs:')
    local buffs_active = player.buffs or {}
    local buff_line_parts = {}
    for _, entry in ipairs(resolved_buffs) do
        local on = has_buff(buffs_active, entry.id)
        table.insert(buff_line_parts, (on and color_green or color_red)..entry.name.."\\cr")
    end
    -- Wrap buff indicators into rows of ~4 so the box doesn't get too wide.
    local per_row = 1
    for i = 1, #buff_line_parts, per_row do
        local row = {}
        for j = i, math.min(i + per_row - 1, #buff_line_parts) do
            table.insert(row, buff_line_parts[j])
        end
        table.insert(lines, ' '..table.concat(row, '  '))
    end

    return table.concat(lines, '\n')
end

windower.register_event('prerender', function()
    hud:text(build_hud_text())
end)

local function getBuffsTEST()
	local player = windower.ffxi.get_player()
	return player.buffs
end

----------------------------------------------------------------------
-- COMMANDS
----------------------------------------------------------------------

windower.register_event('addon command', function(cmd, ...)
    cmd = (cmd or ''):lower()
    local args = {...}

    if cmd == 'lock' then
        hud:draggable(false)
        log('RDMHUD: locked.')
	-- For testing purposes, remove getbuffs
	elseif cmd == 'getbuffs' then
		for _, entry in ipairs(resolved_buffs) do
			windower.add_to_chat(123, entry.name..' '..entry.id)
		end
    elseif cmd == 'unlock' then
        hud:draggable(true)
        log('RDMHUD: unlocked - drag to reposition.')
    elseif cmd == 'reload' then
        windower.send_command('lua reload rdmhud')
    elseif cmd == 'scale' then
        local n = tonumber(args[1])
        if n and n > 0 then
            hud:size(10 * n)
            log(': scale set to '..n)
        else
            log(': usage - //rdmhud scale <number>')
        end
    else
        log(': commands: lock, unlock, reload, scale <n>')
    end
end)

log('locked and loaded. Type //rdmhud for commands.')
