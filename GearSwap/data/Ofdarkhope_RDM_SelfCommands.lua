-- General Include Files
include('Modes.lua')

-- Modes
nukingMode = M{'Normal', 'MagicBurst'}
weaponMode = M{'SavageHighAcc', 'SavageLowAcc', 'EnMagWS', 'EnBurst', 'BlackHaloBurst'}
runspeed = M(false)

-- Self Commands
function self_command(command)
	local commandArgs = command
	
	if #commandArgs:split(' ') >= 2 then
		commandArgs = T(commandArgs:split(' '))
		
		if commandArgs[1]:lower() == "toggle" then
			if commandArgs[2]:lower() == "nukemode" then
				nukingMode:cycle()
				windower.add_to_chat(123, 'Nuking Mode now set to '..tostring(nukingMode.current))
				
			elseif commandArgs[2]:lower() == "weapons" then
				weaponMode:cycle()
				windower.add_to_chat(123, 'WeaponMode now set to '..tostring(weaponMode.current))
				updateWeapons(weaponMode.value)
				
			elseif commandArgs[2]:lower() == 'runspeed' then
				runspeed:toggle()
				updateRunspeedGear(runspeed.value)
				
			elseif commandArgs[2]:lower() == "meleemode" then
				MeleeMode:cycle()
				windower.add_to_chat(123, 'Melee Mode now set to '..tostring(MeleeMode.current))
				
			else
				windower.add_to_chat(123, 'Error! Unknown second argument to toggle.')
			end
		else
			windower.add_to_chat(123, 'Error! First word must be toggle.')
		end
	else
		windower.add_to_chat(123, 'Error! Need two words.')
	end
end

-- Function to update weapons
function updateWeapons(value)
	if value == "SavageLowAcc" then
		equip({main="Naegling"})
		equip({sub="Thibron"})
	elseif value == "SavageHighAcc" then
		equip({main="Naegling"})
		equip({sub={ name="Crocea Mors", augments={'Path: C',}}})
	elseif value == "EnMagWS" then
		equip({main={ name="Crocea Mors", augments={'Path: C',}}})
		equip({sub="Daybreak"})
	elseif value == "EnBurst" then
		equip({main={ name="Crocea Mors", augments={'Path: C',}}})
		equip({sub="Wizard's Rod"})
	elseif value == "BlackHaloBurst" then
		equip({main="Maxentius"})
		equip({sub="Wizard's Rod"})
	end
end

-- Leg Swap Functions for Running
function updateRunspeedGear(value)
    if not value then  
        enable('legs')
        idle()
    else
		equip({legs="Carmine Cuisses +1"})
		disable('legs')
		idle()
	end
end

mov = {counter=0}
if player and player.index and windower.ffxi.get_mob_by_index(player.index) then
	mov.x = windower.ffxi.get_mob_by_index(player.index).x
	mov.y = windower.ffxi.get_mob_by_index(player.index).y
	mov.z = windower.ffxi.get_mob_by_index(player.index).z
end
moving = false

windower.raw_register_event('prerender',function()
	mov.counter = mov.counter + 1
	if mov.counter > 30 then
		local pl = windower.ffxi.get_mob_by_index(player.index)
		if pl and pl.x and mov.x then
			local movement = math.sqrt( (pl.x-mov.x)^2 + (pl.y-mov.y)^2 + (pl.z-mov.z)^2 ) > 0.1
			if movement and not moving then
				send_command('gs c toggle runspeed')
				moving = true
			elseif not movement and moving then
				send_command('gs c toggle runspeed')
				moving = false
			end
		end

		if pl and pl.x then
			mov.x = pl.x
			mov.y = pl.y
			mov.z = pl.z
		end
		mov.counter = 0
	end
end)