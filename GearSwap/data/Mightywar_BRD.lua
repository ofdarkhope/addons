-- Includes
include('Universal_Binds.lua')

windower.send_command('input /macro book 2')
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
		head="Brioso Roundlet +3",
		body="Brioso Justau. +3",
		hands="Brioso Cuffs +3",
		legs="Aya. Cosciales +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Sailfi Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Mache Earring +1",
		left_ring="Murky Ring",
		right_ring="Inyanga Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
	}
	
	-- For song potency and duration
	-- Currently All Songs +5; Duration +37%
	sets.midcast.standard = {
		main="Kali",
		head="Brioso Roundlet +3",
		body="Brioso Justau. +3",
		hands="Brioso Cuffs +3",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Sailfi Belt +1",
		left_ear="Alabaster Earring",
		right_ear="Mache Earring +1",
		left_ring="Murky Ring",
		right_ring="Inyanga Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
	}
	
	sets.melee.tp = {
		main="Kaja Sword",
		range="Blurred Harp +1",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Bard's Charm +1",
		waist="Chiner's Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Mache Earring +1",
		left_ring="Murky Ring",
		right_ring="Inyanga Ring",
		back="Aptitude Mantle +1",
	}
	
	sets.melee.dt = {
		main="Kaja Sword",
		range="Blurred Harp +1",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Bard's Charm +1",
		waist="Chiner's Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Alabaster Earring",
		left_ring="Murky Ring",
		right_ring="Inyanga Ring",
		back="Aptitude Mantle +1",
	}
	
	sets.ws["Savage Blade"] = {
		main="Kaja Sword",
		range="Blurred Harp +1",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Bard's Charm +1",
		waist="Paewr Belt",
		left_ear="Alabaster Earring",
		right_ear="Mache Earring +1",
		left_ring="Murky Ring",
		right_ring="Ayanmo Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-2%',}},
	}
	
	sets.ws[""] = {

	}
	
	sets.idle.dt = {
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
		neck="Bard's Charm +1",
		waist="Chiner's Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Mache Earring +1",
		left_ring="Murky Ring",
		right_ring="Inyanga Ring",
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
	elseif spell.type == "BardSong" then
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