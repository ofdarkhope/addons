-- Includes
--include('Universal_Self_Commands.lua')
include('Universal_Binds.lua')

local num = math.random(4, 6)

windower.send_command('input /macro book 5')
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
		head="Flam. Zucchetto +2",
		body="Dagon Breast.",
		hands="Pel. Vambraces +2",
		legs="Sulev. Cuisses +2",
		feet="Flam. Gambieras +2",
		neck="Anu Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Brutal Earring",
		right_ear={ name="Pel. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Crit.hit rate+3',}},
		left_ring="Chirich Ring",
		right_ring="Chirich Ring",
		back={ name="Mecisto. Mantle", augments={'Cap. Point+40%','DEF+1',}},
	}
	
	sets.idle.dt = {
		ammo="Ginsen",
		head="Sulevia's Mask +2",
		body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Sulev. Leggings +2",
		neck="Sanctity Necklace",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Alabaster Earring",
		right_ear={ name="Pel. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Crit.hit rate+3',}},
		left_ring="Murky Ring",
		right_ring="Defending Ring",
		back={ name="Mecisto. Mantle", augments={'Cap. Point+40%','DEF+1',}},
	}
	
	sets.ja["Angon"] = {
		ammo="Angon",
		head="Flam. Zucchetto +2",
		body="Dagon Breast.",
		hands="Pel. Vambraces +2",
		legs="Sulev. Cuisses +2",
		feet="Flam. Gambieras +2",
		neck="Anu Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Brutal Earring",
		right_ear={ name="Pel. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Crit.hit rate+3',}},
		left_ring="Chirich Ring",
		right_ring="Chirich Ring",
		back={ name="Mecisto. Mantle", augments={'Cap. Point+40%','DEF+1',}},
	}
	
	sets.ws["Stardiver"] = {
		ammo="Knobkierrie",
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
		body="Flamma Korazin +2",
		hands="Flam. Manopolas +2",
		legs="Pelt. Cuissots +2",
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Pel. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Crit.hit rate+3',}},
		left_ring="Rajas Ring",
		right_ring="Pernicious Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
	sets.ws["Impulse Drive"] = {
		ammo="Knobkierrie",
		head="Blistering Sallet +1",
		body="Flamma Korazin +2",
		hands="Flam. Manopolas +2",
		legs="Pelt. Cuissots +2",
		feet="Sulev. Leggings +2",
		neck="Sanctity Necklace",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Pel. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Crit.hit rate+3',}},
		left_ring="Karieyh Ring +1",
		right_ring="Cho'j Band",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.ws["Camlann's Torment"] = {
		ammo="Knobkierrie",
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
		body="Flamma Korazin +2",
		hands="Flam. Manopolas +2",
		legs="Pelt. Cuissots +2",
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Pel. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Crit.hit rate+3',}},
		left_ring="Rajas Ring",
		right_ring="Cho'j Band",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.ws["Wheeling Thrust"] = {
	    ammo="Knobkierrie",
		head="Peltast's Mezail +3",
		body="Sulevia's Plate. +2",
		hands="Nyame Gauntlets",
		legs="Pelt. Cuissots +2",
		feet="Sulev. Leggings +2",
		neck={ name="Dgn. Collar +1", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Pel. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Crit.hit rate+3',}},
		left_ring="Karieyh Ring +1",
		right_ring="Cho'j Band",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.ws["Savage Blade"] = {
	    main="Naegling",
		ammo="Knobkierrie",
		head="Peltast's Mezail +3",
		body="Pelt. Plackart +2",
		hands="Pel. Vambraces +2",
		legs="Vishap Brais +2",
		feet="Sulev. Leggings +2",
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear={ name="Pel. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','Crit.hit rate+3',}},
		left_ring="Rajas Ring",
		right_ring="Cho'j Band",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
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
	if sets.ja[spell.name] then
		equip(sets.ja[spell.name])
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