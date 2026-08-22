--[[
	TODO:
	(1) - Implement decision file duplication removal (i.e., items should be limited to one line and one decision [could always just add additional decisions in the decision string anyhow -- 'AH or NPC')
	(2) - General code refactoring, reorganization, and comments.
	(3) - Consider implementing ability to create file per character vs one file for all characters.
]]--

_addon.commands = {'ia'}
_addon.name = 'InventoryAnalyzer'
_addon.author = 'Ofdarkhope of Asura'
_addon.version = '1.0.0'

file  = require('files')
require('logger')
texts = require('texts')
res = require('resources')
require('chat')
require('strings')

-- Constants for color coding strings
-- Most (not all) colors generally obtained from:  https://smilebasic.com/en/e-manual/manual28/

color_teal = "\\cs(1,249,198)"				-- Item matches the intended bag
color_palered = "\\cs(193,90,99)"			-- Item does NOT match the intended bag (i.e., it needs to move)	
color_pink = "\\cs(255,96,208)"				-- Default for items that have no decision, i.e., "None"	
color_red = "\\cs(255,54,60)"				-- Item to be dropped

color_yellow = "\\cs(255,224,32)"			-- Decisions that begin with '->' 	; Items to transfer to other char

color_green = "\\cs(0,192,0)"				-- Decisions that begin with '$AH' 	; Items to sell on AH
color_orange = "\\cs(255,165,0)"			-- Decisions that begin with '$VD' 	; Items to sell to a vendor
color_purple = "\\cs(160,32,255)"			-- Decisions that begin with '$BZ' 	; Items to sell in a bazaar 

color_lightblue = "\\cs(80,208,255)"		-- Decisions that begin with '^CR' 	; Items to store for crafting purposes
color_blue = "\\cs(0,32,255)"				-- Decisions that begin with '^UP' 	; Items used to upgrade armor/weapons
color_palepink = "\\cs(255,208,160)"		-- Decisions that begin with '^CO' 	; Items you want to collect (i.e., not sell or move)
color_yellowgreen = "\\cs(96,255,128)"		-- Decisions that being with '^ST' 	; Items you need to store with an NPC or storage slip
color_brown = "\\cs(160,128,96)"			-- Decisions that begin with '^QU'  ; Items used for quests

color_grey = "\\cs(128,128,128)"			-- Item doesn't match anything

xpos = 2000
ypos = 70

leg_xpos = 1500
leg_ypos = 70

textbox = texts.new("~~~  InventoryAnalyzer  ~~~\n")
texts.visible(textbox, true)
visible = true
texts.pos(textbox, xpos, ypos)
texts.bg_alpha(textbox, 125)
texts.pad(textbox, 5)
texts.size(textbox, 11)
texts.font(textbox, 'Arial')
texts.color(textbox, 255, 255, 255)
texts.bold(textbox, true)
texts.stroke_alpha(textbox, 255)
texts.stroke_color(textbox, 255, 255, 255)
texts.alpha(textbox, 255)

leg_str = "~~~  Legend  ~~~\n"..
		  color_teal.."Item is where it needs to be\n".."\\cr"..
		  color_palered.."Item is NOT where it needs to be\n".."\\cr"..
		  color_grey.."Decision doesn't match any of the inv. codes\n".."\\cr"..
		  color_pink.."'None' - Item needs a decision\n".."\\cr"..
		  color_yellow.."'->' - Item needs to be transfered\n".."\\cr"..
		  color_green.."'$AH' - Item to be sold on AH\n".."\\cr"..
		  color_orange.."'$VD' - Item to be sold to an NPC/Vendor\n".."\\cr"..
		  color_purple.."'$BZ' - Item to be sold in a bazaar\n".."\\cr"..
		  color_lightblue.."'^CR' - Item to be used for crafting\n".."\\cr"..
		  color_blue.."'^UP' - Item to be used for item/weapon upgrades\n".."\\cr"..
		  color_palepink.."'^CO' - Item to be collected/accumulated\n".."\\cr"..
		  color_yellowgreen.."'^ST' - Item to be stored with NPC or storage slip\n".."\\cr"..
		  color_brown.."'^QU' - Item to be used for a quest or NM pop\n".."\\cr"..
		  color_red.."'^DR' - Item to be dropped".."\\cr"

legend = texts.new(leg_str)
texts.visible(legend, true)
leg_visible = true
texts.pos(legend, leg_xpos, leg_ypos)
texts.bg_alpha(legend, 125)
texts.pad(legend, 5)
texts.size(legend, 11)
texts.font(legend, 'Arial')
texts.color(legend, 255, 255, 255)
texts.bold(legend, true)
texts.stroke_alpha(legend, 255)
texts.stroke_color(legend, 255, 255, 255)
texts.alpha(legend, 255)

-- Check the storage file to be used and if it doesn't exist, make it!
storages_path = 'data/'
inventory_decisions  = ""
inventory_decisions_file = storages_path..'\\inventory_decisions.lua'

-- Used for ensuring character has a data file for their gardening log
function update()
	inventory_decisions_storage  = file.new(storages_path..'\\inventory_decisions.lua')
	inventory_decisions_file = storages_path..'\\inventory_decisions.lua'

	if not inventory_decisions_storage:exists() then
		inventory_decisions_storage:create()
	end
end

-- Borrowed from findall
storages_order_tokens  = L{'temporary', 'inventory', 'wardrobe', 'wardrobe 2', 'wardrobe 3', 'wardrobe 4', 'wardrobe 5', 'wardrobe 6', 'wardrobe 7', 'wardrobe 8', 'safe', 'safe 2', 'storage', 'locker', 'satchel', 'sack', 'case'}
-- This is to maintain sorting order. I don't know why this was done, but omitting this will sort the bags arbitrarily, which (I guess) was not intended
storages_order         = S(res.bags:map(string.gsub-{' ', ''} .. string.lower .. table.get-{'english'})):sort(function(name1, name2)
    local index1 = storages_order_tokens:find(name1)
    local index2 = storages_order_tokens:find(name2)

    if not index1 and not index2 then
        return name1 < name2
    end

    if not index1 then
        return false
    end

    if not index2 then
        return true
    end

    return index1 < index2
end)

-- Borrowed from findall
function get_local_storage()
    local items    = windower.ffxi.get_items()
    local storages = {}

    if not items then
        return false
    end

    storages.gil = items.gil

    for _, storage_name in ipairs(storages_order) do
        storages[storage_name] = T{}

        for _, data in ipairs(items[storage_name]) do
            if type(data) == 'table' then
				if data.id ~= 0 then
					local id = tostring(data.id)
					storages[storage_name][id] = (storages[storage_name][id] or 0) + data.count
				end
			end
        end
    end
	
	return storages
end

function data_load()
	local file_data = {}
	for line in io.lines(windower.addon_path..'\\'..storages_path..'\\inventory_decisions.lua') do
		--file_data[#file_data+1] = line
		local key, value = string.match(line, "([^;]+);(.*)")
		file_data[key] = value
	end
	return file_data
end

function generate_report(bag)
	-- Generate report data
	local storage = get_local_storage()
	local decisions = data_load()
	local report = {}
	
	for i,v in pairs(storage[bag]) do
		item = res.items[tonumber(i)].english
		dec = "None"
		
		if decisions then
			for j,k in pairs(decisions) do
				if j == item then
					dec = tostring(k)
					break
				end
			end
		end
		-- Apply formatting
		
		-- Item matches intended bag (i.e., it's where it needs to be)
		if string.lower(dec) == string.lower(bag) then
			dec = color_teal..dec.."\\cr"
			
		-- Item does NOT match intended bag (i.e., it needs to be moved)
		elseif string.lower(dec) ~= string.lower(bag) and storage[string.lower(dec)] then
			dec = color_palered..dec.."\\cr"
		
		-- Item does not have a decision provided (i.e., you need to update via command or manual file)
		elseif dec == "None" then
			dec = color_pink..dec.."\\cr"
		
		-- Item needs to be transferred to another character
		elseif string.startswith(dec, "->") then
			dec = color_yellow..dec.."\\cr"
		
		-- Item intended to be sold on AH
		elseif string.startswith(dec, "$AH") then
			dec = color_green..dec.."\\cr"
			
		-- Item intended to be sold to an NPC/Vendor
		elseif string.startswith(dec, "$VD") then
			dec = color_orange..dec.."\\cr"

		-- Item intended to be sold in a bazaar
		elseif string.startswith(dec, "$BZ") then
			dec = color_purple..dec.."\\cr"

		-- Item intended to be used for crafting purposes
		elseif string.startswith(dec, "^CR") then
			dec = color_lightblue..dec.."\\cr"

		-- Item intended to be used for item/weapon upgrades
		elseif string.startswith(dec, "^UP") then
			dec = color_blue..dec.."\\cr"

		-- Item intended to be used for collecting/accumulating (e.g., alexandrite, pluton, etc.)
		elseif string.startswith(dec, "^CO") then
			dec = color_palepink..dec.."\\cr"

		-- Item intended to be stored with an NPC or storage slip
		elseif string.startswith(dec, "^ST") then
			dec = color_yellowgreen..dec.."\\cr"
			
		-- Item intended to be stored with an NPC or storage slip
		elseif string.startswith(dec, "^QU") then
			dec = color_brown..dec.."\\cr"
			
		-- Item intended to be dropped
		elseif string.startswith(dec, "^DR") then
			dec = color_red..dec.."\\cr"
			
		-- Item doesn't match any nomenclature
		else
			dec = color_grey..dec.."\\cr"
		end
		report[#report+1] = item..";"..dec
	end
	
	return report
end

function to_table(array)
	local tab_report = {}
	for _,v in pairs(array) do
		local key, value = string.match(v, "([^;]+);(.*)")
		tab_report[key] = value
	end
	return tab_report
end

function update_hud(bag, report)
	texts.text(textbox, "~~~  InventoryAnalyzer ("..bag..") ~~~\n"..table.concat(report, "\n"))
end

windower.register_event('addon command', function(command, ...)
	command = command and command:lower() or nil
	args = T{...}
	update()
	local storage = get_local_storage()
  
	if not command then
		log('No commands given.')
		log('You could try:  //ia inventory')
		log('Or:  //ia safe2')
		log('How about:  //ia update [item] [decision]')
	elseif command == "visible" then
		if visible == true then
			textbox:visible(false)
			visible = false
		else
			textbox:visible(true)
			visible = true
		end
	elseif command == "legend" then
		if leg_visible == true then
			legend:visible(false)
			leg_visible = false
		else
			legend:visible(true)
			leg_visible = true
		end
	elseif command == "filter" then
		if #args >= 2 then
			local report = generate_report(string.lower(args[1]))
			local report_table = to_table(report)
			local filter = {}

			for i,v in pairs(report_table) do
				if string.contains(string.lower(tostring(v)), string.lower(args[2])) then
					-- !! How to format strings with color:  string.format("\\cs(r,g,b)..[string]..\\cr")
					filter[#filter+1] = tostring(i)..";"..tostring(v)
				end
			end
			texts.text(textbox, "~~~  InventoryAnalyzer ("..command..";"..args[1]..") ~~~\n"..table.concat(filter, "\n"))
		else
			log("No bag/query given. Select a bag to filter and query term.")
		end
	elseif command == "update" then
		if #args >= 2 then
			local update = {}
			local found = false
			-- TODO:  Need to add duplication check/removal somewhere in here or separate function call after file is appended
			for i,v in pairs(res.items) do
				if string.lower(args[1]) == string.lower(res.items[tonumber(i)].english) then
					update[#update+1] = res.items[tonumber(i)].english..";"..tostring(args[2].."\n")
					
					--local decisions_data = data_load()
					
					--if decisions_data[res.items[tonumber(i)].english] then
						--decisions_data[res.items[tonumber(i)].english] = tostring(args[2].."\n")
						--local temp_str = ""
						--for j,k in pairs(decisions_data) do
							
						
					--else
					inventory_decisions_storage:append(table.concat(update, "\n"))
					--end
					
					found = true
					break
				end
			end
			if found == false then
				log("Item does not exist. Please check spelling and try again.")
			end
		else
			log("Syntax for update is:  update [item] [decision]")
			log("i.e., update 'prism powder' keep")
			log("i.e., update sheepskin craft")
		end
	elseif storage[command] then
		local report = generate_report(command)
		update_hud(command, report)
	else
		log("Invalid bag given. Options are:  'temporary', 'inventory', 'wardrobe', 'wardrobe 2', 'wardrobe 3', 'wardrobe 4', 'wardrobe 5', 'wardrobe 6', 'wardrobe 7', 'wardrobe 8', 'safe', 'safe 2', 'storage', 'locker', 'satchel', 'sack', 'case'")
	end
end)

-- DELETE/TEST