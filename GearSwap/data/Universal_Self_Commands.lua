-- Automation Modes
Auto_BRD = M{'Off', 'On'}
Alt_BRD_BuffMode = M{'Atk&Spd', 'MP', 'Def&Regen'}

function get_mobs()
	local max_distance = 30
    local mobs = {}
    local mob_array = windower.ffxi.get_mob_array()
    
    for index, entity in pairs(mob_array) do
        -- spawn_type 16 generally represents monsters/enemies
        if entity and entity.spawn_type == 16 and entity.hpp > 0 then
            -- Calculate distance from player (entity.distance is squared distance in yalms, or use math)
            if entity.distance and entity.distance <= (max_distance * max_distance) then
                table.insert(mobs, {
                    name = entity.name,
                    id = entity.id,
                    index = index,
                    distance = math.sqrt(entity.distance),
                    hpp = entity.hpp
                })
            end
        end
    end
	
	-- Need to make fuckers run to the target, might be able to achieve via individual gearswap files?
	windower.send_command('input //send mightywar /targetbnpc; wait 1; send mightywar /lockon; wait 1; send mightywar /attack')
    
    return mobs
end

