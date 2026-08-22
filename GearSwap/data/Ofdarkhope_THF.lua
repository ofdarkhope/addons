-- Includes
include('Universal_Self_Commands.lua')
include('Universal_Binds.lua')

include('Modes.lua')

MeleeMode = M{'Normal', 'DT'}
THMode = M{'Off', 'On'}

windower.send_command('input /macro book 1')

windower.send_command('bind ^f10 gs c toggle meleemode')	-- Ctl-F10
windower.send_command('bind ^f11 gs c toggle thmode')		-- Ctl-F11

function user_unload()
    send_command('unbind ^f10') -- Ctl-F10	
	send_command('unbind ^f11') -- Ctl-F11
end

function get_sets()

	sets.idle = {}			-- leave this empty
	sets.precast = {}		-- leave this empty
	sets.midcast = {}		-- leave this empty
	sets.aftercast = {}		-- leave this empty
	
	sets.melee = {}			-- leave this empty
	sets.ws = {}			-- leave this empty
	sets.ja = {}			-- leave this empty
	
	sets.melee.tp = {
		main="Tauret",
		sub={ name="Shijo", augments={'DEX+15','"Dual Wield"+5','"Triple Atk."+2',}},
		ammo="Ginsen",
		head="Skulker's Bonnet +3",
		body="Pillager's Vest +3",
		hands={ name="Adhemar Wrist. +1", augments={'Accuracy+20','Attack+20','"Subtle Blow"+8',}},
		legs="Pill. Culottes +3",
		feet="Plun. Poulaines +3",
		neck={ name="Asn. Gorget +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Odr Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Chirich Ring",
		right_ring="Rajas Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+7','"Store TP"+10','Phys. dmg. taken-2%',}},
	}
	
	sets.melee.th = {
		ammo="Per. Lucky Egg",
		head="Skulker's Bonnet +3",
		body="Pillager's Vest +3",
		hands={ name="Plun. Armlets +2", augments={'Enhances "Perfect Dodge" effect',}},
		legs="Pill. Culottes +3",
		feet="Skulk. Poulaines +2",
		neck={ name="Asn. Gorget +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Odr Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Chirich Ring",
		right_ring="Rajas Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+7','"Store TP"+10','Phys. dmg. taken-2%',}},
	}
	
	sets.melee.dt = {
	    main="Tauret",
		sub={ name="Shijo", augments={'DEX+15','"Dual Wield"+5','"Triple Atk."+2',}},
		ammo="Staunch Tathlum",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Meg. Gloves +2",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Asn. Gorget +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Odr Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Defending Ring",
		right_ring="Murky Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+7','"Store TP"+10','Phys. dmg. taken-2%',}},
	}
	
	sets.ws["Rudra's Storm"] = {
		ammo="Yetshila",
		head="Pill. Bonnet +3",
		body="Pillager's Vest +3",
		hands="Meg. Gloves +2",
		legs="Pill. Culottes +3",
		feet="Plun. Poulaines +3",
		neck={ name="Asn. Gorget +1", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Odr Earring",
		right_ear="Moonshade Earring",
		left_ring="Ramuh Ring",
		right_ring="Rajas Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+7','"Store TP"+10','Phys. dmg. taken-2%',}},
	}
	
	sets.ws['Evisceration'] = {
		ammo="Yetshila",
		head="Blistering Sallet +1",
		body="Pillager's Vest +3",
		hands="Mummu Wrists +2",
		legs="Pill. Culottes +3",
		feet="Plun. Poulaines +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear="Moonshade Earring",
		left_ring="Ramuh Ring",
		right_ring="Rajas Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+7','"Store TP"+10','Phys. dmg. taken-2%',}},
	}
	
	sets.idle.normal = {
		ammo="Staunch Tathlum",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Nyame Gauntlets",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Asn. Gorget +1", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
		left_ring="Defending Ring",
		right_ring="Murky Ring",
		back="Mubvum. Mantle",
	}
end
	
function precast(spell)
	if spell.type ~= 'JobAbility' then
		equip(sets.melee.tp)
	elseif sets.ws[spell.name] then
		equip(sets.ws[spell.name])
	end
end

function midcast(spell)

end

function aftercast(spell)
	idle()
end

function idle()
	if player.status == 'Engaged' then
		if THMode.current == "On" then
			equip(sets.melee.th)
		elseif THMode.current == "Off" then
			if MeleeMode.current == "Normal" then
				equip(sets.melee.tp)
			elseif MeleeMode.current == "DT" then
				equip(sets.melee.dt)
			end
		end
	end
end