-- Includes
include('Universal_Binds.lua')

windower.send_command('input /macro book 1')
local num = math.random(1, 1)
windower.send_command('input /lockstyleset '..tostring(num))

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
	    range="Compensator",
		left_ring="Barataria Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+3',}},
	}
	
	sets.melee.tp = {
		main="Kaja Knife",
		range="Compensator",
		ammo="Steel Bullet",
		head="Mummu Bonnet +2",
		body="Mummu Jacket +2",
		hands="Mummu Wrists +2",
		legs="Mummu Kecks +2",
		feet="Mummu Gamash. +2",
		left_ear="Mache Earring +1",
		right_ear="Mache Earring +1",
		left_ring="Chirich Ring",
		right_ring="Chirich Ring",
		back="Aptitude Mantle +1",
	}
	
	sets.melee.dt = {

	}
	
	sets.ws["Savage Blade"] = {
		main="Kaja Sword",
		range="Compensator",
		head="Meghanada Visor +2",
		body="Laksa. Frac +3",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		left_ear="Mache Earring +1",
		right_ear="Mache Earring +1",
		left_ring="Meghanada Ring",
		right_ring="Chirich Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +3%',}},
	}
	
	sets.ws["Evisceration"] = {
		main="Kaja Knife",
		range="Compensator",
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		left_ear="Mache Earring +1",
		right_ear="Mache Earring +1",
		left_ring="Meghanada Ring",
		right_ring="Chirich Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +3%',}},
	}
	
	sets.idle.dt = {
		back="Aptitude Mantle +1",
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