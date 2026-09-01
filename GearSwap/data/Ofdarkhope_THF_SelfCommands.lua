-- General Include Files
include('Modes.lua')

-- Modes
meleeMode = M{'tp', 'dt'}
thMode = M{'off', 'on'}
runspeed = M(false)

-- Self Commands
function self_command(command)
	local commandArgs = command
	
	if #commandArgs:split(' ') >= 2 then
		commandArgs = T(commandArgs:split(' '))
		
		if commandArgs[1]:lower() == "toggle" then
		
			if commandArgs[2]:lower() == 'runspeed' then
				runspeed:toggle()
				updateRunspeedGear(runspeed.value)
				
			elseif commandArgs[2]:lower() == "meleemode" then
				meleeMode:cycle()
				windower.add_to_chat(123, 'Melee Mode now set to '..tostring(meleeMode.current))
				updateGear(tostring(meleeMode.current))
				
			elseif commandArgs[2]:lower() == "thmode" then
				thMode:cycle()
				windower.add_to_chat(123, 'TH Mode now set to '..tostring(thMode.current))
				updateGear(tostring(thMode.current))
				
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

-- Function to update gear
function updateGear(value)
	if value == 'on' then
		equip(sets.melee.th)
	elseif value == 'dt' then
		equip(sets.melee.dt)
	elseif value == 'tp' then
		equip(sets.melee.tp)
	end
end

-- Leg Swap Functions for Running
function updateRunspeedGear(value)
    if not value then  
        enable('feet')
		idle()
    else
		equip({feet="Pill. Poulaines +1"})
		disable('feet')
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