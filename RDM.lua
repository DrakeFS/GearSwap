-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    --state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None')
    state.HybridMode:options('Normal')
    state.CastingMode:options('Normal', 'ConserveMP')
    state.IdleMode:options('Normal', 'Leveling')
	
	lockstyleset()
	state.MagicBurst = M(false, 'Magic Burst')
	
	-- send_command('bind != gs c toggle CapacityMode')
	
	send_command('bind ^q gs c cycle CastingMode')
	send_command('bind !q gs c toggle MagicBurst')

	update_combat_form()
    
    --select_default_macro_book(1, 4)
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    sets.CapacityMantle = {back=gear.CPCape}
	
	-- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body= {name="Viti. Tabard +1", augments={'Enhances "Chainspell" effect',}}}
	
	-- Spells Fastcast 
	
    sets.precast.FC = {
    ammo="Impatiens",
    head="Atrophy Chapeau +1",
    body={ name="Viti. Tabard +1", augments={'Enhances "Chainspell" effect',}},
    hands="Aya. Manopolas +2",
    legs={ name="Lengo Pants", augments={'INT+7','Mag. Acc.+7','"Mag.Atk.Bns."+3','"Refresh"+1',}},
    feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+18','DEX+2','Accuracy+15 Attack+15','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    waist="Embla Sash",
    left_ear="Malignance Earring",
    left_ring="Kishar Ring",
	}

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {})

    -- Weaponskill sets
    
    sets.precast.WS = {
    ammo="Ginsen",
    head="Jhakri Coronal +2",
    body="Ayanmo Corazza +2",
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet="Battlecast Gaiters",
    neck="Sanctity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Steelflash Earring",
    right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    left_ring="Ayanmo Ring",
    right_ring="Rajas Ring",
    back=gear.RdmCTP,
	}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Sanguine Blade'], {
	neck="Soil Gorget",
	waist="Soil Belt",
	})

    sets.precast.WS['Sanguine Blade'] = {
	head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +1",
    neck="Sanctity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Malignance Earring",
    right_ear="Novio Earring",
    left_ring="Ayanmo Ring",
    right_ring="Jhakri Ring",
    back=gear.RdmCMB,
	}
	
	sets.precast.WS['Seraph Blade'] = set_combine( sets.precast.WS['Sanguine Blade'],{})
	sets.precast.WS['Red Lotus Blade'] = set_combine( sets.precast.WS['Sanguine Blade'],{})
	sets.precast.WS['Black Halo'] = set_combine( sets.precast.WS['Sanguine Blade'],{})
	sets.precast.WS['Aeolian Edge'] = set_combine( sets.precast.WS['Sanguine Blade'],{})
	
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
	neck="Light Gorget",
	waist="Light Belt",
	})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
    ammo="Ginsen",
    head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
	legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +1",
    neck="Thunder Gorget",
    waist="Thunder Belt",
    right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    left_ring="Rajas Ring",
    right_ring="Apate Ring",
	})

    -- Midcast Sets
	
    sets.midcast.FastRecast = {}

    sets.midcast.Cure = {
    head="Vitiation Chapeau +2",
    body= {name="Viti. Tabard +1", augments={'Enhances "Chainspell" effect',}},
    hands="Jhakri Cuffs +2",
    legs="Atrophy Tights +1",
    feet="Leth. Houseaux +1",
	neck="Nodens Gorget",
	right_ear="Mendi. Earring",
    back="Solemnity Cape",
	}

    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
	head="Jhakri Coronal +2",
	neck= {name="Duelist's Torque", augments={'Path: A',}},
    body= {name="Viti. Tabard +1", augments={'Enhances "Chainspell" effect',}},
    hands="Atrophy Gloves +2",
    feet="Leth. Houseaux +1",
    waist="Embla Sash",
	back = gear.RdmCMB,
	}

    sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast['Temper II']= sets.midcast['Enhancing Magic']	
	
	sets.midcast.Blink = sets.midcast.FastRecast
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {legs="Shedir Seraweels",})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {body="Atrophy Tabard +3", legs="Leth. Fuseau +1",})
	
    sets.midcast.Stoneskin =set_combine(sets.midcast['Enhancing Magic'], {legs="Shedir Seraweels",})

    sets.midcast.Haste = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.Flurry = sets.midcast.Haste	
	sets.midcast.Firestorm = sets.midcast.Haste
	sets.midcast.Hailstorm = sets.midcast.Haste
	sets.midcast.Windstorm = sets.midcast.Haste
	sets.midcast.Sandstorm = sets.midcast.Haste
	sets.midcast.Thunderstorm = sets.midcast.Haste
	sets.midcast.Rainstorm = sets.midcast.Haste
	sets.midcast.Aurorastorm = sets.midcast.Haste
	sets.midcast.Voidstorm = sets.midcast.Haste
	sets.midcast["Haste II"] = sets.midcast.Haste
	sets.midcast["Flurry II"] = sets.midcast.Haste
	sets.midcast['Shock Spikes'] = sets.midcast.Haste
	sets.midcast['Ice Spikes'] = sets.midcast.Haste
	sets.midcast['Blaze Spikes'] = sets.midcast.Haste
	sets.midcast['Refresh II'] = sets.midcast.Refresh
	sets.midcast['Refresh III'] = sets.midcast.Refresh
	sets.midcast['Regen II'] = sets.midcast.Refresh
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Protectra = sets.midcast.Protect
	sets.midcast.Shell = sets.midcast.Protect
	sets.midcast.Shellra = sets.midcast.Protect
	
	sets.midcast['Barfire'] = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Barblizzard = sets.midcast.Barfire
	sets.midcast.Baraero = sets.midcast.Barfire
	sets.midcast.Barstone = sets.midcast.Barfire
	sets.midcast.Barthunder = sets.midcast.Barfire
	sets.midcast.Barwater = sets.midcast.Barfire
	sets.midcast.Barsleep = sets.midcast.Barfire
	sets.midcast.Barpoison = sets.midcast.Barfire
	sets.midcast.Barparalyze = sets.midcast.Barfire
	sets.midcast.Barblind = sets.midcast.Barfire
	sets.midcast.Barsilence = sets.midcast.Barfire
	sets.midcast.Baramnesia = sets.midcast.Barfire
	sets.midcast.Phalanx = sets.midcast.Barfire
	sets.midcast['Gain-STR'] = sets.midcast.Haste
	sets.midcast['Gain-DEX'] = sets.midcast.Haste
	sets.midcast['Gain-VIT'] = sets.midcast.Haste
	sets.midcast['Gain-AGI'] = sets.midcast.Haste
	sets.midcast['Gain-MND'] = sets.midcast.Haste
	sets.midcast['Gain-CHR'] = sets.midcast.Haste
	sets.midcast['Gain-INT'] = sets.midcast.Haste
		
    sets.midcast['Enfeebling Magic'] = {
    ammo="Regal Gem",
    head={ name="Vitiation Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
    body="Atrophy Tabard +3",
    hands="Leth. Gantherots +1",
    legs="Jhakri Slops +2",
    feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
    neck={ name="Duelist's Torque", augments={'Path: A',}},
    waist={ name="Acuity Belt +1", augments={'Path: A',}},
    left_ear="Malignance Earring",
    right_ear="Hermetic Earring",
    left_ring="Kishar Ring",
    right_ring="Jhakri Ring",
    back = gear.RdmCMB,
	}
		
    sets.midcast['Dia III'] = {
    ammo="Regal Gem",
    head={ name="Vitiation Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
    body="Lethargy Sayon +1",
    hands="Leth. Gantherots +1",
    legs="Jhakri Slops +2",
    feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
    neck={ name="Duelist's Torque", augments={'Path: A',}},
    waist={ name="Acuity Belt +1", augments={'Path: A',}},
    left_ear="Malignance Earring",
    right_ear="Hermetic Earring",
    left_ring="Kishar Ring",
    right_ring="Jhakri Ring",
    back = gear.RdmCMB,
	}
		
	sets.midcast['Slow II'] = sets.midcast['Dia III']	
	sets.midcast['Paralyze II'] = sets.midcast['Dia III']
	sets.midcast['Distract III'] = sets.midcast['Dia III']
	sets.midcast['Frazzle III'] = sets.midcast['Dia III']
	sets.midcast['Dispel'] = set_combine(sets.midcast['Enfeebling Magic'], {neck={ name="Duelist's Torque", augments={'Path: A',}},})

    sets.midcast['Elemental Magic'] = {
	head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +1",
    neck="Sanctity Necklace",
	waist={ name="Acuity Belt +1", augments={'Path: A',}},
    left_ear="Novio Earring",
    right_ear="Malignance Earring",
    left_ring="Ayanmo Ring",
    right_ring="Jhakri Ring",
	back = gear.RdmCMB,
	}

	sets.midcast['Elemental Magic'].ConserveMP = set_combine(sets.midcast['Elemental Magic'], {})

	sets.magic_burst = set_combine(sets.midcast['Elemental Magic'], {})

    sets.magic_burst.ConserveMP = set_combine(sets.midcast['Elemental Magic'], {}) 

    sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'], {head=empty, body="Twilight Cloak",})

	sets.midcast['Dark Magic'] = {}

    --sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast.Drain = {}

    sets.midcast.Aspir = sets.midcast.Drain
	
	sets.midcast.Klimaform = sets.midcast.FastRecast
	
	sets.midcast.Stone = {}
	

    -- Sets for special buff conditions on spells.

    
	sets.buff.ComposureOther = {
	head="Lethargy Chappel",
    body="Lethargy Sayon +1",
	hands="Leth. Gantherots +1",
	legs="Lethargy Fuseau +1",
	feet="Lethargy Houseaux +1"
	}

    sets.buff.Saboteur = {hands="Leth. Gantherots +1"}
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    
    -- Idle sets
    sets.idle = {
	ammo="Ginsen",
    head="Vitiation Chapeau +2",
    body="Jhakri Robe +2",
    hands="Aya. Manopolas +2",
    legs="Carmine Cuisses +1",
    feet="Aya. Gambieras +2",
    neck="Sanctity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
    back=gear.RdmCTP,
	}
    
	sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})

    -- Defense sets
    sets.defense.PDT = {
	ammo="Ginsen",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +1",
    feet="Aya. Gambieras +2",
    neck="Loricate Torque +1",
    waist="Windbuffet Belt +1",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
    back="Solemnity Cape",
	}

    sets.defense.MDT = set_combine(sets.defense.PDT, {})

    sets.Kiting = {legs="Carmine Cuisses +1"}

    sets.latent_refresh = {}

    --  sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
    ammo="Ginsen",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +1",
    feet="BAttlecast Gaiters",
    neck="Clotharius Torque",
    waist="Windbuffet Belt +1",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Pernicious Ring",
    right_ring="Petrov Ring",
	back=gear.RdmCTP,
	}

	sets.engaged.DW = {
    ammo="Ginsen",
    head="Malignance Chapeau",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Battlecast Gaiters",
    neck="Clotharius Torque",
    waist="Windbuffet Belt +1",
    left_ear="Eabani Earring",
    right_ear="Suppanomimi",
    left_ring="Pernicious Ring",
    right_ring="Petrov Ring",
    back=gear.RdmCTP,
	}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingDuration)
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
	if spell.action_type == 'Magic' then
	if spell.element == "Earth" and spell.skill == 'Elemental Magic' and (state.CastingMode.value == "Normal" or state.CastingMode.value == "ConserveMP")  then
		equip({ neck="Quanpur Necklace" })
	end
	    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
		if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
		if state.CastingMode.value == "ConserveMP" then
            equip(sets.magic_burst.ConserveMP)		
		elseif state.CastingMode.value == "MACC" then
        equip(sets.magic_burst.MACC)        
		else
        equip(sets.magic_burst)
        end	
end
end
end
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if spell.english == 'Break' or spell.english == 'Breakga' then
			send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 30 down spells/00220.png')
		elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
			send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
		elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
			send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
		end
		classes.CustomIdleGroups:clear()
	end
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Genmei Shield" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end

--------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 5)
    else
        set_macro_page(1, 5)
    end
end

function lockstyleset()
	send_command('wait 5;input /lockstyleset 17')
end