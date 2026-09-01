-- Includes
include('Ofdarkhope_THF_SelfCommands.lua')
include('Universal_Binds.lua')
include('Modes.lua')

-- Set macro book to RDM
windower.send_command('input /macro book 1')
local num = math.random(7, 9)
windower.send_command('input /lockstyleset '..tostring(num))

function get_sets()

	sets.idle = {}			-- leave this empty
	sets.precast = {}		-- leave this empty
	sets.midcast = {}		-- leave this empty
	sets.aftercast = {}		-- leave this empty
	
	sets.melee = {}			-- leave this empty
	sets.ws = {}			-- leave this empty
	sets.ja = {}			-- leave this empty
	
	sets.melee.tp = {
		ammo="Ginsen",
		head="Skulker's Bonnet +3",
		body="Pillager's Vest +3",
		hands={ name="Adhemar Wrist. +1", augments={'Accuracy+20','Attack+20','"Subtle Blow"+8',}},
		legs="Pill. Culottes +3",
		feet="Plun. Poulaines +3",
		neck={ name="Asn. Gorget +1", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Odr Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Chirich Ring",
		right_ring="Chirich Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+7','"Store TP"+10','Phys. dmg. taken-2%',}},
	}
	
	sets.melee.th = {
		ammo="Per. Lucky Egg",
		head="Skulker's Bonnet +3",
		body="Pillager's Vest +3",
		hands="Skulk. Armlets +2",
		legs="Pill. Culottes +3",
		feet="Skulk. Poulaines +2",
		neck={ name="Asn. Gorget +1", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Odr Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Murky Ring",
		right_ring="Chirich Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+7','"Store TP"+10','Phys. dmg. taken-2%',}},
	}
	
	sets.melee.dt = {
		ammo="Staunch Tathlum",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Skulk. Armlets +2",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Asn. Gorget +1", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Odr Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Defending Ring",
		right_ring="Murky Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+7','"Store TP"+10','Phys. dmg. taken-2%',}},
	}
	
	sets.ws["Rudra's Storm"] = {
		ammo="Oshasha's Treatise",
		head="Pill. Bonnet +3",
		body="Skulker's Vest +2",
		hands="Meg. Gloves +2",
		legs="Skulk. Culottes +2",
		feet="Plun. Poulaines +3",
		neck={ name="Asn. Gorget +1", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Odr Earring",
		right_ear="Moonshade Earring",
		left_ring="Ramuh Ring",
		right_ring="Beithir Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+9','Weapon skill damage +10%',}},
	}
	
	sets.ws['Evisceration'] = {
		ammo="Yetshila",
		head="Blistering Sallet +1",
		body="Pillager's Vest +3",
		hands="Mummu Wrists +2",
		legs="Skulk. Culottes +2",
		feet="Plun. Poulaines +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear="Moonshade Earring",
		left_ring="Ramuh Ring",
		right_ring="Rajas Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+9','Weapon skill damage +10%',}},
	}
	
	sets.ws['Aeolian Edge'] = {
	    ammo="Ghastly Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Asn. Gorget +1", augments={'Path: A',}},
		waist="Skrymir Cord",
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Medada's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+9','Weapon skill damage +10%',}},
	}

end
	
function precast(spell)
	if sets.ws[spell.name] then
		equip(sets.ws[spell.name])
	elseif sets.ja[spell.name] then
		equip(sets.ja[spell.name])
	elseif spell.type ~= 'JobAbility' then
		equip(sets.melee.tp)
	end
end

function midcast(spell)

end

function aftercast(spell)
	idle()
end

function idle()
	if player.status == 'Engaged' then
		if thMode.current == "on" then
			equip(sets.melee.th)
		elseif thMode.current == "off" then
			if meleeMode.current == "tp" then
				equip(sets.melee.tp)
			elseif meleeMode.current == "dt" then
				equip(sets.melee.dt)
			end
		end
	else equip(sets.melee.dt)
	end
end