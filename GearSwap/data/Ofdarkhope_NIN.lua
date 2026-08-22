
windower.send_command('input /macro book 2')

function get_sets()

	sets.idle = {}			-- leave this empty
	sets.precast = {}		-- leave this empty
	sets.midcast = {}		-- leave this empty
	sets.aftercast = {}		-- leave this empty
	
	sets.melee = {}			-- leave this empty
	sets.ws = {}			-- leave this empty
	sets.ja = {}			-- leave this empty
	
	sets.melee.tp = {
		main="Kaja Katana",
		sub={ name="Shigi", augments={'Accuracy+50','Rng.Acc.+50','Damage Taken -5%',}},
		ammo="Happo Shuriken",
		head={ name="Ryuo Somen +1", augments={'STR+12','DEX+12','Accuracy+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'Accuracy+20','Attack+20','"Subtle Blow"+8',}},
		legs="Ken. Hakama",
		feet="Hiza. Sune-Ate +2",
		neck="Moonbeam Nodowa",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Odr Earring",
		right_ear={ name="Hattori Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','"Store TP"+7','DEX+11 AGI+11',}},
		left_ring="Shneddick Ring",
		right_ring="Rajas Ring",
		back={ name="Mecisto. Mantle", augments={'Cap. Point+40%','DEF+1',}},
	}
	
	sets.idle.dt = {
		main="Kaja Katana",
		sub={ name="Shigi", augments={'Accuracy+50','Rng.Acc.+50','Damage Taken -5%',}},
		ammo="Staunch Tathlum",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands={ name="Adhemar Wrist. +1", augments={'Accuracy+20','Attack+20','"Subtle Blow"+8',}},
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Sanctity Necklace",
		waist="Plat. Mog. Belt",
		left_ear="Odr Earring",
		right_ear={ name="Hattori Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','"Store TP"+7','DEX+11 AGI+11',}},
		left_ring="Shneddick Ring",
		right_ring="Defending Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.ws["Blade: Shun"] = {
		main="Kaja Katana",
		sub={ name="Shigi", augments={'Accuracy+50','Rng.Acc.+50','Damage Taken -5%',}},
		ammo="Oshasha's Treatise",
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
		body="Malignance Tabard",
		hands="Ken. Tekko",
		legs="Hiza. Hizayoroi +2",
		feet="Hattori Kyahan +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear={ name="Hattori Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','"Store TP"+7','DEX+11 AGI+11',}},
		left_ring="Ramuh Ring",
		right_ring="Rajas Ring",
		back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','MND+5','Weapon skill damage +10%',}},
	}
	
	sets.ws["Blade: Ku"] = {
		ammo="Oshasha's Treatise",
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
		body="Malignance Tabard",
		hands="Ken. Tekko",
		legs="Hiza. Hizayoroi +2",
		feet="Hattori Kyahan +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear={ name="Hattori Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','"Store TP"+7','DEX+11 AGI+11',}},
		left_ring="Ramuh Ring",
		right_ring="Rajas Ring",
		back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','MND+5','Weapon skill damage +10%',}},
	}
	
	sets.ws["Savage Blade"] = {
		ammo="Oshasha's Treatise",
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
		body="Malignance Tabard",
		hands="Ken. Tekko",
		legs="Hiza. Hizayoroi +2",
		feet="Hattori Kyahan +2",
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Odr Earring",
		right_ear={ name="Hattori Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+18','Mag. Acc.+18','"Store TP"+7','DEX+11 AGI+11',}},
		left_ring="Ramuh Ring",
		right_ring="Rajas Ring",
		back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','MND+5','Weapon skill damage +10%',}},
	}
	
	sets.midcast.Ninjutsu = {
		ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head={ name="Herculean Helm", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','Magic burst dmg.+2%','MND+5','Mag. Acc.+2','"Mag.Atk.Bns."+12',}},
		body="Hattori Ningi +2",
		hands="Hattori Tekko +2",
		legs="Malignance Tights",
		feet={ name="Herculean Boots", augments={'Accuracy+28','"Triple Atk."+2','DEX+2','Attack+13',}},
		neck="Sibyl Scarf",
		waist="Skrymir Cord",
		left_ear="Friomisi Earring",
		right_ear="Strophadic Earring",
		left_ring="Shiva Ring +1",
		right_ring="Medada's Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.fast = {
		ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head={ name="Herculean Helm", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','Magic burst dmg.+2%','MND+5','Mag. Acc.+2','"Mag.Atk.Bns."+12',}},
		body="Hattori Ningi +2",
		hands="Hattori Tekko +2",
		legs="Malignance Tights",
		feet={ name="Herculean Boots", augments={'Accuracy+28','"Triple Atk."+2','DEX+2','Attack+13',}},
		neck="Sibyl Scarf",
		waist="Skrymir Cord",
		left_ear="Friomisi Earring",
		right_ear="Strophadic Earring",
		left_ring="Kishar Ring",
		right_ring="Medada's Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}},
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
	elseif spell.skill == "Ninjutsu" then
		equip(sets.midcast.Ninjutsu)
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