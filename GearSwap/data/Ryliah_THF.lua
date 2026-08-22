-- Includes
include('Universal_Self_Commands.lua')
include('Universal_Binds.lua')

-- Gearswap Section

function get_sets()
	sets.idle = {}			-- leave this empty
	sets.precast = {}		-- leave this empty
	sets.midcast = {}		-- leave this empty
	sets.aftercast = {}		-- leave this empty
	
	sets.melee = {}			-- leave this empty
	sets.ws = {}			-- leave this empty
	sets.ja = {}			-- leave this empty
	
	sets.precast.fast = {

	}
	
	sets.midcast.standard = {
	
	}
	
	sets.melee.tp = {

	}
	
	sets.melee.dt = {

	}
	
	sets.ws[""] = {

	}
	
	sets.ws[""] = {

	}
	
	sets.idle.dt = {

	}
	
end
	
function precast(spell)
	if sets.ws[spell.name] then
		equip(sets.ws[spell.name])
	else
		equip(sets.precast.fast)
	end
end

function midcast(spell)
	if sets.ja[spell.name] then
		equip(sets.ja[spell.name])
	elseif sets.midcast[spell.name] then
		equip(sets.midcast[spell.name])
	else
		equip(sets.midcast.standard)
	end
end

function aftercast(spell)
	idle()
end

function idle()
	if player.status == 'Engaged' then
		equip(sets.melee.tp)
	else
		equip(sets.idle.dt)
	end
end