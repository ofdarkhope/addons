-- Includes
include('Ofdarkhope_RDM_SelfCommands.lua')
include('Ofdarkhope_RDM_Binds.lua')

-- Set macro book to RDM
windower.send_command('input /macro book 3')

self_spell_maps = {
	['Cure']='selfcure',['Cure II']='selfcure',['Cure III']='selfcure',['Cure IV']='selfcure',['Cure V']='selfcure',['Cure VI']='selfcure', ['Full Cure']='selfcure',
	['Barfire']='barelement',['Barstone']='barelement',['Barwater']='barelement',['Baraero']='barelement',['Barblizzard']='barelement',['Barthunder']='barelement',
	['Protect']='maxskill',['Protect II']='maxskill',['Protect III']='maxskill',['Protect IV']='maxskill',['Protect V']='maxskill',
    ['Shell']='maxskill',['Shell II']='maxskill',['Shell III']='maxskill',['Shell IV']='maxskill',['Shell V']='maxskill',
	['Regen']='maxskill',['Regen II']='maxskill',
    ['Refresh']='selfrefresh',['Refresh II']='selfrefresh',['Refresh III']='selfrefresh',
	['Gain-AGI']='selfduration',['Gain-CHR']='selfduration',['Gain-DEX']='selfduration',['Gain-INT']='selfduration',['Gain-MND']='selfduration',['Gain-STR']='selfduration',['Gain-VIT']='selfduration',
	['Enstone']='maxskill',['Enwater']='maxskill',['Enaero']='maxskill',['Enfire']='maxskill',['Enblizzard']='maxskill',['Enthunder']='maxskill',['Temper II']='maxskill',
	['Phalanx']='selfphalanx',['Stoneskin']='stoneskin',['Haste II']='selfduration',['Aquaveil']='aquaveil'
}

other_spell_maps = {
	['Cure']='othercure',['Cure II']='othercure',['Cure III']='othercure',['Cure IV']='othercure',['Cure V']='othercure',['Cure VI']='othercure', ['Full Cure']='othercure',
	['Protect']='maxskill',['Protect II']='maxskill',['Protect III']='maxskill',['Protect IV']='maxskill',['Protect V']='maxskill',
    ['Shell']='maxskill',['Shell II']='maxskill',['Shell III']='maxskill',['Shell IV']='maxskill',['Shell V']='maxskill',
	['Regen']='maxskill',['Regen II']='maxskill',
    ['Refresh']='otherrefresh',['Refresh II']='otherrefresh',['Refresh III']='otherrefresh',
	['Phalanx II']='maxskill',['Haste II']='otherduration'
}

enfeeb_maps = {
    ['Dia']='potency', ['Dia II']='potency', ['Dia III']='potency',
    ['Bio']='potency', ['Bio II']='potency', ['Bio III']='potency',
    ['Paralyze']='mndpot', ['Paralyze II']='mndpot', 
    ['Slow']='mndpot', ['Slow II']='mndpot', 
    ['Addle']='mndpot', ['Addle II']='mndpot',
    ['Sleep']='macc', ['Sleep II']='macc', ['Sleepga']='macc', 
    ['Silence']='macc', 
    ['Inundation']='macc', 
    ['Dispel']='macc', 
    ['Break']='macc', 
    ['Bind']='macc', 
    ['Blind']='intpot', ['Blind II']='intpot', 
    ['Gravity']='potency', ['Gravity II']='potency',
    -- We leave Frazzle and FrazzleII as pure macc to help land it in cases its a high resist. 
    -- This lets us follow up with a high potency Frazzle3 
    ['Frazzle']='macc', ['Frazzle II']='macc', ['Frazzle III']='skillmndpot', 
    ['Distract']='skillmndpot', ['Distract II']='skillmndpot', ['Distract III']='skillmndpot', 
    ['Poison']='skillpot', ['Poison II']='skillpot', ['Poisonga']='skillpot',
}

-- Gearswap Primary Section
function get_sets()
	sets.idle = {}					-- leave this empty
	sets.precast = {}				-- leave this empty
	sets.midcast = {}				-- leave this empty
	sets.aftercast = {}				-- leave this empty
	sets.midcast.enfeebling = {}	-- leave this empty
	sets.midcast.enhancing = {}		-- leave this empty
	
	sets.melee = {}					-- leave this empty
	sets.ws = {}					-- leave this empty
	sets.ja = {}					-- leave this empty
	
	sets.midcast.enfeebling.mndpot = {
		ammo="Hydrocera",
		head="Viti. Chapeau +4",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		legs="Leth. Fuseau +3",
		feet="Viti. Boots +4",
		neck={ name="Dls. Torque +1", augments={'Path: A',}},
		waist="Obstin. Sash",
		left_ear="Snotra Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
	sets.midcast.enfeebling.intpot = {
		ammo="Ghastly Tathlum +1",
		head="Viti. Chapeau +4",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		legs="Leth. Fuseau +3",
		feet="Viti. Boots +4",
		neck={ name="Dls. Torque +1", augments={'Path: A',}},
		waist="Acuity Belt +1",
		left_ear="Snotra Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring",
		right_ring="Medada's Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
	sets.midcast.enfeebling.potency = {
	    ammo="Hydrocera",
		head="Leth. Chappel +3",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3",
		neck={ name="Dls. Torque +1", augments={'Path: A',}},
		waist="Obstin. Sash",
		left_ear="Snotra Earring",
		right_ear="Malignance Earring",
		left_ring="Kishar Ring",
		right_ring="Medada's Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
	-- macc @ 502
	sets.midcast.enfeebling.macc = {
		ammo="Hydrocera",
		head="Atro. Chapeau +4",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3",
		neck={ name="Dls. Torque +1", augments={'Path: A',}},
		waist="Acuity Belt +1",
		left_ear="Snotra Earring",
		right_ear="Malignance Earring",
		left_ring="Medada's Ring",
		right_ring="Stikini Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
	sets.midcast.enfeebling.skillmndpot = {
		ammo="Hydrocera",
		head="Viti. Chapeau +4",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		legs="Leth. Fuseau +3",
		feet="Viti. Boots +4",
		neck={ name="Dls. Torque +1", augments={'Path: A',}},
		waist="Obstin. Sash",
		left_ear="Snotra Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
	sets.midcast.enfeebling.skillpot = {
		ammo="Hydrocera",
		head="Viti. Chapeau +4",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		legs="Leth. Fuseau +3",
		feet="Viti. Boots +4",
		neck={ name="Dls. Torque +1", augments={'Path: A',}},
		waist="Obstin. Sash",
		left_ear="Snotra Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
	sets.midcast.enhancing.othercure = {
	    ammo="Staunch Tathlum",
		head={ name="Kaykaus Mitra", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}},
		body="Bunzi's Robe",
		hands={ name="Kaykaus Cuffs", augments={'MP+60','MND+10','Mag. Acc.+15',}},
		legs="Atrophy Tights +3",
		feet={ name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
		neck="Elite Royal Collar",
		waist="Plat. Mog. Belt",
		left_ear="Alabaster Earring",
		right_ear="Malignance Earring",
		left_ring="Murky Ring",
		right_ring="Defending Ring",
		back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +1','Enha.mag. skill +2','Mag. Acc.+10','Enh. Mag. eff. dur. +12',}},
	}
	
	sets.midcast.enhancing.selfcure = {
		ammo="Staunch Tathlum",
		head={ name="Kaykaus Mitra", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}},
		body="Bunzi's Robe",
		hands={ name="Kaykaus Cuffs", augments={'MP+60','MND+10','Mag. Acc.+15',}},
		legs="Atrophy Tights +3",
		feet={ name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
		neck="Elite Royal Collar",
		waist="Gishdubar Sash",
		left_ear="Alabaster Earring",
		right_ear="Malignance Earring",
		left_ring="Murky Ring",
		right_ring="Defending Ring",
		back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +1','Enha.mag. skill +2','Mag. Acc.+10','Enh. Mag. eff. dur. +12',}},
	}
	
	sets.midcast.enhancing.maxskill = {
		ammo="Staunch Tathlum",
		head="Leth. Chappel +3",
		body="Viti. Tabard +4",
		hands="Viti. Gloves +2",
		legs="Atrophy Tights +3",
		feet="Leth. Houseaux +3",
		neck={ name="Dls. Torque +1", augments={'Path: A',}},
		waist="Olympus Sash",
		left_ear="Malignance Earring",
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +1','Enha.mag. skill +2','Mag. Acc.+10','Enh. Mag. eff. dur. +12',}},
	}
	
	sets.midcast.enhancing.selfduration = {
		ammo="Staunch Tathlum",
		head="Leth. Chappel +3",
		body="Viti. Tabard +4",
		hands="Atro. Gloves +4",
		legs="Atrophy Tights +3",
		feet="Leth. Houseaux +3",
		neck={ name="Dls. Torque +1", augments={'Path: A',}},
		waist="Embla Sash",
		left_ear="Alabaster Earring",
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Defending Ring",
		right_ring="Murky Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','Enmity-10','Phys. dmg. taken-10%',}},
	}
	
	sets.midcast.enhancing.otherduration = {
		ammo="Staunch Tathlum",
		head="Leth. Chappel +3",
		body="Viti. Tabard +4",
		hands="Atro. Gloves +4",
		legs="Atrophy Tights +3",
		feet="Leth. Houseaux +3",
		neck={ name="Dls. Torque +1", augments={'Path: A',}},
		waist="Embla Sash",
		left_ear="Alabaster Earring",
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Defending Ring",
		right_ring="Murky Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','Enmity-10','Phys. dmg. taken-10%',}},
	}
	
	sets.midcast.enhancing.selfphalanx = {
	    ammo="Staunch Tathlum",
		head="Leth. Chappel +3",
		body="Viti. Tabard +4",
		hands="Atro. Gloves +4",
		legs="Atrophy Tights +3",
		feet="Leth. Houseaux +3",
		neck={ name="Dls. Torque +1", augments={'Path: A',}},
		waist="Embla Sash",
		left_ear="Alabaster Earring",
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Defending Ring",
		right_ring="Murky Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','Enmity-10','Phys. dmg. taken-10%',}},
	}
	
	sets.midcast.enhancing.selfrefresh = {
		ammo="Staunch Tathlum",
		head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		body="Atrophy Tabard +4",
		hands="Atro. Gloves +4",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3",
		neck={ name="Dls. Torque +1", augments={'Path: A',}},
		waist="Gishdubar Sash",
		left_ear="Alabaster Earring",
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Murky Ring",
		right_ring="Defending Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','Enmity-10','Phys. dmg. taken-10%',}},
	}
	
	sets.midcast.enhancing.otherrefresh = {
	    ammo="Staunch Tathlum",
		head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		body="Atrophy Tabard +4",
		hands="Atro. Gloves +4",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3",
		neck={ name="Dls. Torque +1", augments={'Path: A',}},
		waist="Embla Sash",
		left_ear="Alabaster Earring",
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Murky Ring",
		right_ring="Defending Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','Enmity-10','Phys. dmg. taken-10%',}},
	}
	
	sets.midcast.enhancing.aquaveil = {
	    ammo="Staunch Tathlum",
		head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		body="Atrophy Tabard +4",
		hands="Atro. Gloves +4",
		legs="Shedir Seraweels",
		feet="Leth. Houseaux +3",
		neck={ name="Dls. Torque +1", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear="Alabaster Earring",
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Murky Ring",
		right_ring="Defending Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','Enmity-10','Phys. dmg. taken-10%',}},
	}
	
	sets.midcast.enhancing.stoneskin = {
		ammo="Staunch Tathlum",
		head="Leth. Chappel +3",
		body="Atrophy Tabard +4",
		hands="Atro. Gloves +4",
		legs="Shedir Seraweels",
		feet="Leth. Houseaux +3",
		neck={ name="Dls. Torque +1", augments={'Path: A',}},
		waist="Siegel Sash",
		left_ear="Alabaster Earring",
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Murky Ring",
		right_ring="Defending Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','Enmity-10','Phys. dmg. taken-10%',}},
	}
	
	sets.midcast.enhancing.barelement = {
		ammo="Staunch Tathlum",
		head="Leth. Chappel +3",
		body="Atrophy Tabard +4",
		hands="Atro. Gloves +4",
		legs="Shedir Seraweels",
		feet="Leth. Houseaux +3",
		neck={ name="Dls. Torque +1", augments={'Path: A',}},
		waist="Siegel Sash",
		left_ear="Alabaster Earring",
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Murky Ring",
		right_ring="Defending Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','Enmity-10','Phys. dmg. taken-10%',}},
	}
	
	sets.midcast.enhancing.selfphalanx = {
	    ammo="Staunch Tathlum",
		head={ name="Taeon Chapeau", augments={'Phalanx +3',}},
		body={ name="Taeon Tabard", augments={'Phalanx +3',}},
		hands={ name="Taeon Gloves", augments={'Phalanx +2',}},
		legs={ name="Taeon Tights", augments={'Phalanx +3',}},
		feet={ name="Taeon Boots", augments={'Phalanx +3',}},
		neck={ name="Dls. Torque +1", augments={'Path: A',}},
		waist="Embla Sash",
		left_ear="Alabaster Earring",
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Murky Ring",
		right_ring="Defending Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','Enmity-10','Phys. dmg. taken-10%',}},
	}
	
	-- RDM native plus job master is 38%
	-- Below set is way maxed
	sets.precast.fast = {
		ammo="Hydrocera",
		head="Atro. Chapeau +4", -- FC + 16%
		body={ name="Viti. Tabard +4", augments={'Enhances "Chainspell" effect',}}, -- FC + 14%
		hands="Jhakri Cuffs +2",
		legs="Aya. Cosciales +2", -- FC + 5%
		feet={ name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}}, -- FC + 3%
		neck="Deviant Necklace",
		waist="Embla Sash", -- FC + 5%
		left_ear="Malignance Earring", -- FC + 4%
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}}, -- FC + 7%
		left_ring="Medada's Ring",
		right_ring="Kishar Ring", -- FC + 4 %
		back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.ja['Composure'] = {
		ammo="Ghastly Tathlum +1",
		head="Leth. Chappel +3",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3",
		neck={ name="Dls. Torque +1", augments={'Path: A',}},
		waist="Embla Sash",
		left_ear="Eabani Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring",
		right_ring="Defending Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','Enmity-10','Phys. dmg. taken-10%',}},
	}
	
	sets.midcast.Normal = {
		main="Bunzi's Rod",
		sub="Wizard's Rod",
		ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head="Leth. Chappel +3",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		legs="Leth. Fuseau +3",
		feet={ name="Viti. Boots +4", augments={'Immunobreak Chance',}},
		neck="Sibyl Scarf",
		waist="Skrymir Cord",
		left_ear="Friomisi Earring",
		right_ear="Malignance Earring",
		left_ring="Shiva Ring +1",
		right_ring="Medada's Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
	sets.midcast.MagicBurst = {
		main="Bunzi's Rod",
		sub="Wizard's Rod",
		ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head="Ea Hat",
		body="Ea Houppelande",
		hands="Bunzi's Gloves",
		legs="Leth. Fuseau +3",
		feet={ name="Viti. Boots +4", augments={'Immunobreak Chance',}},
		neck="Sibyl Scarf",
		waist={ name="Acuity Belt +1", augments={'Path: A',}},
		left_ear="Friomisi Earring",
		right_ear="Malignance Earring",
		left_ring="Jhakri Ring",
		right_ring="Medada's Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
	sets.idle.dt = { 
		ammo="Staunch Tathlum",
		head="Leth. Chappel +3",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3",
		neck="Elite Royal Collar",
		waist="Skrymir Cord",
		left_ear="Moonshade Earring",
		right_ear="Malignance Earring",
		left_ring="Murky Ring",
		right_ring="Stikini Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','Enmity-10','Phys. dmg. taken-10%',}},
	}
	
	sets.melee.tp = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Leth. Ganth. +3",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Anu Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Brutal Earring",
		right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+9','Mag. Acc.+9',}},
		left_ring="Chirich Ring",
		right_ring="Chirich Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Damage taken-5%',}},
	}
	
	sets.ws["Savage Blade"] = {
		ammo="Hydrocera",
		head={ name="Viti. Chapeau +4", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body={ name="Viti. Tabard +4", augments={'Enhances "Chainspell" effect',}},
		hands="Atro. Gloves +4",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3",
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Stikini Ring",
		back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.ws["Black Halo"] = {
	    ammo="Hydrocera",
		head={ name="Viti. Chapeau +4", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Atrophy Tabard +4",
		hands="Atro. Gloves +4",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3",
		neck="Sanctity Necklace",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Stikini Ring",
		back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.ws["Sanguine Blade"] = {
	    ammo="Hydrocera",
		head={ name="Viti. Chapeau +4", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Atrophy Tabard +4",
		hands="Atro. Gloves +4",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3",
		neck="Sanctity Necklace",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.ws["Seraph Blade"] = {
		ammo="Ghastly Tathlum +1",
		head="Leth. Chappel +3",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3",
		neck="Sanctity Necklace",
		waist="Skrymir Cord",
		left_ear="Moonshade Earring",
		right_ear="Malignance Earring",
		left_ring="Shiva Ring +1",
		right_ring="Stikini Ring",
		back={ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.ws["Red Lotus Blade"] = {
	    ammo="Hydrocera",
		head={ name="Viti. Chapeau +4", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Atrophy Tabard +4",
		hands="Atro. Gloves +4",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3",
		neck="Sanctity Necklace",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Rajas Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
	sets.ws["Chant du Cygne"]={
		ammo="Yetshila",
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
		body="Malignance Tabard",
		hands="Aya. Manopolas +2",
		legs={ name="Zoar Subligar +1", augments={'Path: A',}},
		feet="Malignance Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear="Mache Earring +1",
		left_ring="Ramuh Ring",
		right_ring="Rajas Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
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
	local enfeebType = get_enfeeb_map(spell)
	local selfSpellType = get_self_spell_map(spell)
	local otherSpellType = get_other_spell_map(spell)

	if sets.ja[spell.name] then
		equip(sets.ja[spell.name])		
	elseif spell.skill == "Enhancing Magic" or spell.skill == "Healing Magic" then
		if spell.target.type == "SELF" then
			equip(sets.midcast.enhancing[selfSpellType])
		elseif spell.target.type == "PLAYER" then
			equip(sets.midcast.enhancing[otherSpellType])
		end
	elseif spell.skill == 'Enfeebling Magic' then
		equip(sets.midcast.enfeebling[enfeebType])
	elseif spell.type == "BlackMagic" then
		equip(sets.midcast[nukingMode.current])
	elseif spell.type == "WhiteMagic" then
		equip(sets.midcast.WhiteMagic)
	end

end

function aftercast(spell)
	-- Set weapons back to whatever they were prior to spell/ability casting
	updateWeapons(weaponMode.current)
	idle()
end

function idle()
	if player.status == 'Engaged' then
		equip(sets.melee.tp)
	else
		equip(sets.idle.dt)
	end
end

-- Get spell mapping
function get_enfeeb_map(spell)
    return enfeeb_maps[spell.name]
end

function get_self_spell_map(spell)
	return self_spell_maps[spell.name]
end

function get_other_spell_map(spell)
	return other_spell_maps[spell.name]
end