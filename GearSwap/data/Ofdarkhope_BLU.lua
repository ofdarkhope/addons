windower.send_command('input /macro book 4')

function get_sets()

	sets.idle = {}			-- leave this empty
	sets.precast = {}		-- leave this empty
	sets.midcast = {}		-- leave this empty
	sets.aftercast = {}		-- leave this empty
	
	sets.melee = {}			-- leave this empty
	sets.ws = {}			-- leave this empty
	sets.ja = {}			-- leave this empty
	
	sets.precast.fast = {
		main="Naegling",
		sub={ name="Thibron", augments={'TP Bonus +1000',}},
		ammo="Mantoptera Eye",
		head={ name="Herculean Helm", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','Magic burst dmg.+2%','MND+5','Mag. Acc.+2','"Mag.Atk.Bns."+12',}},
		body="Hashishin Mintan +1",
		hands="Hashi. Bazu. +1",
		legs="Aya. Cosciales +2",
		feet="Malignance Boots",
		neck="Sanctity Necklace",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Suppanomimi",
		right_ear="Eabani Earring",
		left_ring="Rajas Ring",
		right_ring="Defending Ring",
		back={ name="Mecisto. Mantle", augments={'Cap. Point+40%','DEF+1',}},
	}
	
	sets.midcast.nuke = {
		main="Naegling",
		sub={ name="Thibron", augments={'TP Bonus +1000',}},
		ammo="Ghastly Tathlum",
		head="Hashishin Kavuk +2",
		body="Jhakri Robe +2",
		hands="Hashi. Bazu. +2",
		legs={ name="Luhlaza Shalwar +2", augments={'Enhances "Assimilation" effect',}},
		feet="Jhakri Pigaches +2",
		neck="Deviant Necklace",
		waist="Yamabuki-no-Obi",
		left_ear="Friomisi Earring",
		right_ear="Strophadic Earring",
		left_ring="Shiva Ring +1",
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+5','"Mag.Atk.Bns."+10',}},
	}
	
	sets.melee.tp = {
		main="Naegling",
		sub={ name="Thibron", augments={'TP Bonus +1000',}},
		ammo="Mantoptera Eye",
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'Accuracy+20','Attack+20','"Subtle Blow"+8',}},
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Sanctity Necklace",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Suppanomimi",
		right_ear="Eabani Earring",
		left_ring="Rajas Ring",
		right_ring="Defending Ring",
		back={ name="Mecisto. Mantle", augments={'Cap. Point+40%','DEF+1',}},
	}
	
	sets.melee.dt = {
	    main="Naegling",
		sub={ name="Thibron", augments={'TP Bonus +1000',}},
		ammo="Mantoptera Eye",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Hashi. Bazu. +2",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Sanctity Necklace",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Suppanomimi",
		right_ear="Eabani Earring",
		left_ring="Rajas Ring",
		right_ring="Defending Ring",
		back={ name="Mecisto. Mantle", augments={'Cap. Point+40%','DEF+1',}},
	}
	
	sets.ws["Savage Blade"] = {
		main="Naegling",
		sub={ name="Thibron", augments={'TP Bonus +1000',}},
		ammo="Hydrocera",
		head="Hashishin Kavuk +2",
		body="Assim. Jubbah +2",
		hands="Jhakri Cuffs +2",
		legs={ name="Luhlaza Shalwar +2", augments={'Enhances "Assimilation" effect',}},
		feet="Jhakri Pigaches +2",
		neck="Sanctity Necklace",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Rajas Ring",
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.ws["Chant du Cygne"] = {
	    main="Naegling",
		sub={ name="Thibron", augments={'TP Bonus +1000',}},
		ammo="Mantoptera Eye",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Jhakri Cuffs +2",
		legs={ name="Adhemar Kecks +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		feet="Malignance Boots",
		neck="Sanctity Necklace",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Odr Earring",
		left_ring="Ramuh Ring",
		right_ring="Defending Ring",
		back="Bleating Mantle",
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
	elseif spell.skill == "Blue Magic" then
		equip(sets.midcast.nuke)
	end
end

function aftercast(spell)
	idle()
end

function idle()
	if player.status == 'Engaged' then
		equip(sets.melee.tp)
	else
		equip(sets.melee.tp)
	end
end