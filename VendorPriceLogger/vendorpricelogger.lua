_addon.name    = 'VendorPriceLogger'
_addon.author  = 'ofdarkhope'
_addon.version = '1.00'

require('logger')
require('texts')
require('tables')
require('maths')
require('pack')
packets = require('packets')
res = require('resources')
file  = require('files')

-- Check the storage file to be used and if it doesn't exist, fucking make it!
storages_path = 'data/'
player_name   = windower.ffxi.get_player().name
price_data_storage  = file.new(storages_path..'\\'..player_name..'_vendor_price_data.lua')

if not price_data_storage:exists() then
	price_data_storage:create()
end

-- Variables for exporting to file
item_id = 0
price = ""
name = ""
vendor = ""
vendor_x, vendor_y = 0
zone = ""
power = ""
sale_date = ""

windower.register_event('incoming chunk', function(id, original, modified, injected, blocked)

	if id == 0x03D then
		local message = packets.parse('incoming', original)

		-- Price check will occur first
		-- I want all prices to be logged, regardless of whether I sell
		if message['Type'] == 0 then
			price = message['Price']
			price_data_storage:append(item_id .. '_' .. power .. '_' .. zone .. '_' .. vendor .. '_(' .. vendor_x .. ',' .. vendor_y .. ')_' .. name .. '_' .. price .. '_' .. sale_date .. '\n')
		end
	end
	
	-- reversed due to endianness
	if id == 0x05e then
		local san, bas, win, un = original:unpack('b2b2b2b2', 0x04+1)
		
		if san == 1 then
			power = "San d'Oria"
		elseif bas == 1 then
			power = "Bastok"
		elseif win == 1 then
			power = "Windurst"
		else
			power = "Unknown"
		end
	
	end
end)

-- Used only for obtaining the item name that's getting price checked

windower.register_event('outgoing chunk', function(id, original, modified, injected, blocked)

	if id == 0x084 then
		local message = packets.parse('outgoing', original)
		name = res.items[message['Item']].english
		item_id = message['Item']
	end
end)

-- Gets various info, including NPC name, zone, (x,y), etc.
-- I used target change here to ensure these fields are always obtained when selecting any vendor, as its unlikely your vendor will change during the sale

windower.register_event('target change', function(index)

	-- Check to make sure we have a real value, otherwise we'll get error messages when our target goes to nil
	if index ~= 0 then
		local mob_data = windower.ffxi.get_mob_by_index(index)
		local zone_info = windower.ffxi.get_info()
		vendor = mob_data.name
		vendor_x = math.floor(mob_data.x)
		vendor_y = math.floor(mob_data.y)
		zone = res.zones[zone_info['zone']].english
		sale_date = os.date('%Y-%m-%d')
	end

end)