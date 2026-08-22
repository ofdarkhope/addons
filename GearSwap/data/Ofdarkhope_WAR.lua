include('organizer-lib')

function get_sets()

    sets.JA = {}
    sets.JA.Berserk = {body="Pumm. Lorica +1", back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}, feet="Agoge Calligae +1"}
    sets.JA.Aggressor = {head="Pumm. Mask +1", body="Agoge Lorica +1"}
    sets.JA.Warcry = {head="Agoge Mask +1"}
    sets.JA['Blood Rage'] = {body="Boii Lorica +3"}
    sets.JA['Mighty Strikes'] = {hands="Agoge Mufflers +1"}
    sets.JA.Tomahawk = {ammo="Thr. Tomahawk",feet="Agoge Calligae +1"}
    sets.JA.Provoke = sets.Enmity
    
    sets.TP = {}
    TP_mode = 'Normal'
    sets.TP.Ragnarok = {main="Ragnarok"}
    sets.TP.Ukonvasara = {main="Ukonvasara"}

    sets.TP.Normal = {
        ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Boii Lorica +3",
		hands="Flam. Manopolas +2",
		legs="Boii Cuisses +3",
		feet="Flam. Gambieras +2",
		neck={ name="Warrior's Beads", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Schere Earring",
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Flamma Ring",
		right_ring="Karieyh Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
    
    sets.TP.Acc = {
        ammo="Seeth. Bomblet +1",
		head="Boii Mask +2",
		body="Boii Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Boii Calligae +3",
		neck={ name="Warrior's Beads", augments={'Path: A',}},
		waist="Null Belt",
		left_ear="Mache Earring",
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Flamma Ring",
		right_ring="Sulevia's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
    
    sets.TP.DT = sets.DT
    
    sets.Enmity = {
        ammo="Iron Gobbet",
        head="Pummeler's Mask +1",
        body="Yorium Cuirass",
        hands={ name="Yorium Gauntlets", augments={'Mag. Evasion+8','Enmity+10','Phys. dmg. taken -4%',}},
        legs={ name="Odyssean Cuisses", augments={'Attack+9','Enmity+8',}},
        feet={ name="Eschite Greaves", augments={'HP+80','Enmity+7','Phys. dmg. taken -4',}},
        neck="Unmoving Collar +1",
        waist="Goading Belt",
        left_ear="Trux Earring",
        right_ear="Pluto's Pearl",
        left_ring="Eihwaz Ring",
        right_ring="Provocare Ring",
        back="Impassive Mantle",
    }
    sets.FC = {
        left_ear="Loquac. Earring",
    }
	
	sets.WS = {}
	
    sets.WS['Raging Rush'] = {
    	ammo="Seeth. Bomblet +1",
		head="Boii Mask +2",
		body="Boii Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Sulev. Leggings +2",
		neck={ name="Warrior's Beads", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Flamma Ring",
		right_ring="Karieyh Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
        
    sets.WS["Ukko's Fury"] = {
    	ammo="Seeth. Bomblet +1",
		head="Boii Mask +2",
		body="Boii Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Sulev. Leggings +2",
		neck={ name="Warrior's Beads", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Flamma Ring",
		right_ring="Karieyh Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
        
    sets.WS["Fell Cleave"] = {
    	ammo="Seeth. Bomblet +1",
		head="Boii Mask +2",
		body="Boii Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Sulev. Leggings +2",
		neck={ name="Warrior's Beads", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Flamma Ring",
		right_ring="Karieyh Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
	
	sets.WS['Savage Blade'] = {
    	ammo="Seeth. Bomblet +1",
		head="Boii Mask +2",
		body="Boii Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Sulev. Leggings +2",
		neck={ name="Warrior's Beads", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Flamma Ring",
		right_ring="Karieyh Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
    
    sets.WS.Resolution = {
		ammo="Seeth. Bomblet +1",
		head="Boii Mask +2",
		body="Boii Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Sulev. Leggings +2",
		neck={ name="Warrior's Beads", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring="Flamma Ring",
		right_ring="Karieyh Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
    
    sets.WS.Gavialis = {head="Gavialis Helm"}
    
    sets.Idle = {
        ammo="Seeth. Bomblet +1",
		head="Boii Mask +2",
		body="Boii Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Boii Calligae +3",
		neck={ name="Warrior's Beads", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Schere Earring",
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Karieyh Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
    
    sets.DT = {
		ammo="Seeth. Bomblet +1",
		head="Boii Mask +2",
		body="Boii Lorica +3",
		hands="Flam. Manopolas +2",
		legs="Sulev. Cuisses +2",
		feet="Boii Calligae +3",
		neck={ name="Warrior's Beads", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Schere Earring",
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Crit.hit rate+4',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Karieyh Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
    
    sets.TP.DT = sets.DT
    
    
end

--[[
function precast(spell)
    if spell.cast_time then
        equip(sets.FC)
    end
end
]]--

function precast(spell)
	if spell.type ~= 'JobAbility' then
		equip(sets.melee.tp)
	elseif sets.ws[spell.name] then
		equip(sets.ws[spell.name])
	end
end

function midcast(spell)
    if sets.JA[spell.name] then
        equip(sets.JA[spell.name])
    elseif sets.WS[spell.name] then
        equip(sets.WS[spell.name])
        if sets.WS[spell.name].Gavialis and sets.WS[spell.name].Gavialis[world.day] then
            equip(sets.WS.Normal)
        end
    end
end

function aftercast(spell)
    if player.status == 'Engaged' then
        equip(sets.TP[TP_mode])
    else
        equip(sets.Idle)
    end
end

function status_change(new,old)
    if T{'Idle','Resting'}:contains(new) then
        equip(sets.Idle)
    elseif new == 'Engaged' then
        equip(sets.TP[TP_mode])
    end
end

function self_command(command)
    if command == 'DT' then
        equip(sets.DT)
    elseif command == 'TP' then
        if TP_mode=="Acc" then
            TP_mode="Normal"
        elseif TP_mode=="Normal" then
            TP_mode="DT"
        elseif TP_mode=="DT" then
            TP_mode='Acc'
        end
        windower.add_to_chat('TP mode is now: '..TP_mode)
        equip(sets.TP[TP_mode])
    end
end