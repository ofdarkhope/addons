_addon.commands = {'farmbuddy', 'fb'}
_addon.name = 'FarmBuddy'
_addon.author = 'Xurion of Bismarck'
_addon.version = '1.0.0'

file  = require('files')
require('logger')
texts = require('texts')
res = require('resources')

local FarmBuddy = {
    farm_data = {},
    status = 'running'
}

xpos = 1700
ypos = 420

-- MV Boli

textbox = texts.new("FarmBuddy-ng: "..FarmBuddy.status)
texts.visible(textbox, true)
texts.pos(textbox, xpos, ypos)
texts.bg_alpha(textbox, 75)
texts.pad(textbox, 5)
texts.size(textbox, 10)
texts.font(textbox, 'Arial')
texts.color(textbox, 255, 255, 255)
texts.bold(textbox, true)
texts.stroke_alpha(textbox, 255)
texts.stroke_color(textbox, 255, 255, 255)
texts.alpha(textbox, 255)

local storages_path = 'data/'
local player_name   = windower.ffxi.get_player().name
local farm_data_storage  = file.new(storages_path..'\\'..player_name..'_farm_data.lua')
    
if not farm_data_storage:exists() then
	farm_data_storage:create()
end

function round(num, idp)
    local mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

function getExistingDataKey(mob_name)
    for key, existing_kill_data in pairs(FarmBuddy.farm_data) do
        if existing_kill_data.name == mob_name then
            return key
        end
    end

    return false
end

function updateHUD()
	local report = {}
	for _, monster_data in ipairs(FarmBuddy.farm_data) do
		report[#report+1] = tostring(monster_data.name..': '..monster_data.kills)
	end
	texts.text(textbox, "FarmBuddy-ng:\n"..table.concat(report, "\n"))
end

function save()
	if FarmBuddy.farm_data[1] == nil then
		farm_data_storage:write('')
	end
	for _, monster_data in ipairs(FarmBuddy.farm_data) do
		if monster_data.kills > 1 then
			kill_plural = 's'
		else
			kill_plural = ''
		end
		if monster_data == FarmBuddy.farm_data[1] then
			farm_data_storage:write(monster_data.name .. ': ' .. monster_data.kills .. ' kill' .. kill_plural .. '\n')
		else
			farm_data_storage:append(monster_data.name .. ': ' .. monster_data.kills .. ' kill' .. kill_plural .. '\n')
		end
		
		for drop_name, drop_amount in pairs(monster_data.drops) do
			farm_data_storage:append(' > ' .. drop_name:gsub('[%p%c]', '') .. ': ' .. drop_amount .. '/' .. monster_data.kills .. ' (' .. round(drop_amount / monster_data.kills * 100, 1) .. '%)' .. '\n')
		end
	end
end

function data_load()
	local curr_mob
	for line in io.lines(windower.addon_path..'\\'..storages_path..'\\'..player_name..'_farm_data.lua') do
		if string.find(line, '^%s') then
			local item_name = line:match('>%s(.+):')
			local item_amount = line:match(':%s(%d+)/')
			local key
			key = getExistingDataKey(curr_mob)
			FarmBuddy.farm_data[key].drops[item_name] = item_amount
		else
			local mob_name = line:match('(.+):')
			local mob_kills = line:match(':%s(%d+)')
			table.insert(FarmBuddy.farm_data, {
				name = mob_name,
				kills = tonumber(mob_kills),
				drops = {}
			})
			curr_mob = mob_name
		end
	end
	updateHUD()
	windower.add_to_chat(7, 'File load success')
end

if farm_data_storage:exists() then
	local file = io.input(windower.addon_path..'\\'..storages_path..'\\'..player_name..'_farm_data.lua')
	local e = io.read("*all")
	if e ~= '' then
		data_load()
	end
end

FarmBuddy.handle_incoming_message = function (_, text)

    if text == '' or FarmBuddy.status == 'paused' then
        return false
    end

    local kill_confirmation_regex = player_name..' defeats the (.*)%.'
    local killed_mob_name = string.match(text, kill_confirmation_regex)
    local key

    if killed_mob_name then
		local report = {}
        key = getExistingDataKey(killed_mob_name)
        if key == false then
            table.insert(FarmBuddy.farm_data, {
                name = killed_mob_name,
                kills = 1,
                drops = {}
            })
        else
            FarmBuddy.farm_data[key].kills = FarmBuddy.farm_data[key].kills + 1
        end
		updateHUD()
		save()
    end

    local drop_confirmation_regex = 'You find an? (.*) on the (.*)%.'
    local drop_name, drop_mob_name = string.match(text, drop_confirmation_regex)
    if drop_name and drop_mob_name then
        key = getExistingDataKey(drop_mob_name)
        if key == false then
            FarmBuddy.farm_data[key].drops[drop_name] = 0
        else
            if FarmBuddy.farm_data[key].drops[drop_name] then
                FarmBuddy.farm_data[key].drops[drop_name] = FarmBuddy.farm_data[key].drops[drop_name] + 1
            else
                FarmBuddy.farm_data[key].drops[drop_name] = 1
            end
        end
		save()
    end
end

FarmBuddy.handle_addon_command = function (command)

    local action, kill_plural

    if command ~= nil then
        action = command:lower()
    end

    if action == 'report' then
        for _, monster_data in ipairs(FarmBuddy.farm_data) do
            if monster_data.kills > 1 then
                kill_plural = 's'
            else
                kill_plural = ''
            end
            FarmBuddy.send_text_to_game(monster_data.name .. ': ' .. monster_data.kills .. ' kill' .. kill_plural)
            for drop_name, drop_amount in pairs(monster_data.drops) do
                FarmBuddy.send_text_to_game(' > ' .. drop_name .. ': ' .. drop_amount .. '/' .. monster_data.kills .. ' (' .. round(drop_amount / monster_data.kills * 100, 1) .. '%)')
            end
        end
    end

    if action == 'reset' then
        FarmBuddy.farm_data = {}
		texts.text(textbox, "FarmBuddy-ng: "..FarmBuddy.status.."\n".."Go farm something, will ya?!")
		save()
    end

    if action == 'pause' then
        FarmBuddy.pause()
    end

    if action == 'resume' then
        FarmBuddy.resume()
    end

    if action == 'status' then
        FarmBuddy.send_text_to_game(FarmBuddy.status)
    end
	
	if action == 'load' then
		data_load()
	end
end

FarmBuddy.pause = function ()
    FarmBuddy.status = 'paused'
end

FarmBuddy.resume = function ()
    FarmBuddy.status = 'running'
end

FarmBuddy.send_text_to_game = function (text)
    windower.add_to_chat(7, text)
end

windower.register_event('incoming text', FarmBuddy.handle_incoming_message)
windower.register_event('addon command', FarmBuddy.handle_addon_command)

return FarmBuddy
