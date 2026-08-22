--[[

Important Information:
----------------------
I obtained permission from Pikko on 5/20/25 to use PikkoPots as the name of this add-on. She no longer plays the game
and wasn't involved in the creation or maintenance of this script. I utilized her naming conventions for certain
attributes of data being collected. Pikko was an inspiration to me when I first started playing and it's my
opinion that her hard work and dedication to validating and making available her data made many of our lives easier
in-game.

So if you're reading this Pikko, thanks again for fueling my fire crystal addiction!

For any questions or issues, please reach out to
ofdarkhope@gmail.com.

Change History:
---------------
1.00 - Script creation and name confirmation

--]]

-- Add-on Information
_addon.name    = 'PikkoPots'
_addon.author  = 'ofdarkhope'
_addon.version = '1.00'

-- Requires
require('logger')
require('texts')
require('tables')
require('maths')
require('pack')
packets = require('packets')
res = require('resources')
file  = require('files')

-- Check the storage file to be used and if it doesn't exist, make it!
storages_path = 'data/'
player_name   = windower.ffxi.get_player().name
gardening_data_storage  = ""
gardening_data_file = storages_path..'\\'..player_name..'_gardening_data.lua'

-- Used for ensuring character has a data file for their gardening log
function update()
	player_name   = windower.ffxi.get_player().name
	gardening_data_storage  = file.new(storages_path..'\\'..player_name..'gardening_data.lua')
	gardening_data_file = storages_path..'\\'..player_name..'gardening_data.lua'

	if not gardening_data_storage:exists() then
		gardening_data_storage:create()
	end
end

-- Variables for exporting to file
flowerpot_name = ''
flowerpot_id = ''
flowerpot_safe_index = ''
seed_name = ''
seed_id = ''
examine_seed = ''

-- Table for abbreviated days of the week in-game
days = {
	[0] = 'F',
	[1] = 'E',
	[2] = 'Wa',
	[3] = 'Wi',
	[4] = 'I',
	[5] = 'Lt',
	[6] = 'Li',
	[7] = 'D'
}

-- Table for abbreviated moon phases in-game
phases = {
	[0] = 'New',
	[1] = 'WaxCresc',
	[2] = 'WaxCresc',
	[3] = 'FirstQt',
	[4] = 'WaxGib',
	[5] = 'WaxGib',
	[6] = 'Full',
	[7] = 'WanGib',
	[8] = 'WanGib',
	[9] = 'LastQt',
	[10] = 'WanCresc',
	[11] = 'WanCresc',
}

-- Function for constructing the day/moon_phase/moon_percentage/earth_date information in a format similar to what Pikko used on Pikko's Pots
function get_dminfo()
	local info = windower.ffxi.get_info()
	day = days[info['day']]
	phase = phases[info['moon_phase']]
	return day .. '-' .. phase .. '-' .. info['moon'] .. '%' .. '-' .. os.date('%Y-%m-%d')
end

-- Function to account for double packets coming in when examining a Plant
-- Reads the log file in and grabs the last entry that's inserted after the '256' packet makes a log, then appends the relevant crystal usage information
-- and saves the entire file back to the user's filesystem. This way we don't get duplicate entries
function crystal_fed_log(crystal_log)
	local file_name = io.input(windower.addon_path..'\\'..gardening_data_file)
	local file_table = {}
	
	for line in file_name:lines() do
		table.insert(file_table, line)
	end
	io.close(file_name)
	
	-- Grab the last line
	last_line = file_table[#file_table]
	-- Append the related crystal information
	last_line = last_line..crystal_log
	-- Remove any duplicated new line characters -- these will be added back during the file write below
	last_line = string.gsub(last_line, "\n", "")
	-- Update our temp table with the information
	file_table[#file_table] = last_line
	
	-- Now write that entry back to the file the correct way!
	file_name = io.open(windower.addon_path..'\\'..gardening_data_file, 'w')
	for index, value in ipairs(file_table) do
		file_name:write(value..'\n')
	end
	io.close(file_name)
	
end

-- Used for obtaining information about incoming chunks for gardening (if any)
windower.register_event('incoming chunk', function(id, original, modified, injected, blocked)

	-- Examining
	if id == 0x029 then
		update()
		local message = packets.parse('incoming', original)
		-- Action message associated with examining a flowerpot
		if message['Message'] == 256 then
			examine_seed = res.items[message['Param 1']].english
			gardening_data_storage:append('Examine: ' .. flowerpot_safe_index .. '_' .. flowerpot_name .. '; ' .. examine_seed .. ';' .. get_dminfo() .. '\n')
		-- Action message when no crystal was used.
		elseif message['Message'] == 257 then
			crystal_log = get_dminfo() .. '; No Crystal Used;' '\n'
			crystal_fed_log(crystal_log)
		-- Action message when one crystal was used.
		elseif message['Message'] == 258 then
			crystal_log = ';Crystal Used: ' .. res.items[message['Param 1']].english .. ';\n'
			crystal_fed_log(crystal_log)
		-- Action message when two crystals were used.
		elseif message['Message'] == 259 then
			crystal_log = ';First Crystal: ' .. res.items[message['Param 1']].english .. ';' .. 'Second Crystal: ' .. res.items[message['Param 2']].english .. ';\n'
			crystal_fed_log(crystal_log)
		-- Action message when first crystal wasn't used, but second crystal was.
		elseif message['Message'] == 260 then
			crystal_log = ';First Crystal: None; ' .. 'Second Crystal: ' .. res.items[message['Param 2']].english .. ';\n'
			crystal_fed_log(crystal_log)
		-- Action message when first crystal was used, but second wasn't.
		elseif message['Message'] == 261 then
			crystal_log = ';First Crystal: ' .. res.items[message['Param 1']].english .. ';' .. 'Second Crystal: None;\n' 
			crystal_fed_log(crystal_log)
		-- Action message when neither crystal was used.
		elseif message['Message'] == 262 then
			crystal_log = ';First Crystal: None; ' .. 'Second Crystal: None;\n'
			crystal_fed_log(crystal_log)
		end
		
	end

end)

-- Used for obtaining information about outgoing chunks for gardening
windower.register_event('outgoing chunk', function(id, original, modified, injected, blocked)

	-- Planting & Feeding (crystals)
	if id == 0x0FC then
		update()
		local message = packets.parse('outgoing', original)
		flowerpot_name = res.items[message['Flowerpot Item']].english
		flowerpot_id = message['Flowerpot Item']
		flowerpot_safe_index = message['Flowerpot Safe Index']
		seed_name = res.items[message['Seed Item']].english
		seed_id = message['Seed Item']
		seed_safe_index = message['Seed Safe Index']
		
		if string.find(seed_name, "Crystal") ~= nil then
			gardening_data_storage:append('Feed: ' .. flowerpot_safe_index .. '_' .. flowerpot_name .. '; ' .. seed_safe_index .. '_' .. seed_name .. ';' .. get_dminfo() .. '\n')
		else
			gardening_data_storage:append('Plant: ' .. flowerpot_safe_index .. '_' .. flowerpot_name .. '; ' .. seed_safe_index .. '_' .. seed_name .. ';' .. get_dminfo() .. '\n')
		end
	-- Examining
	elseif id == 0x0FD then
		update()
		local message = packets.parse('outgoing', original)
		flowerpot_name = res.items[message['Flowerpot Item ID']].english
		flowerpot_id = message['Flowerpot Item ID']
		flowerpot_safe_index = message['Flowerpot Safe Slot']
	-- Harvesting/Uprooting
	elseif id == 0x0FE then
		update()
		local message = packets.parse('outgoing', original)
		flowerpot_name = res.items[message['Flowerpot Item']].english
		flowerpot_id = message['Flowerpot Item']
		flowerpot_safe_index = message['Flowerpot Safe Index']
	end

end)

-- Used for obtaining information about the harvests from gardening
windower.register_event('incoming text', function(original, modified, original_mode, modified_mode)

	local harvest_regex = 'Your moogle picked (.*) (.*)% from the plant.'
	local yield, harvest_item = string.match(original, harvest_regex)
	-- Weird characters come through, so this removes those to clean up the logs
	if harvest_item then
		yield = yield:gsub('[%c%p]', '')
		harvest_item = harvest_item:gsub('[%c%p]', '')
	end
	
	-- Write those results to the file
	if harvest_item then
		gardening_data_storage:append('Harvest: ' .. flowerpot_safe_index .. '_' .. flowerpot_name .. '; ' .. yield .. ' ' .. harvest_item .. '; ' .. get_dminfo() .. '\n')
	end
end)
