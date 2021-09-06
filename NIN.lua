-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- To use this LUAs shadow casting logic create a macro

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false
    state.Buff.Shadows = buffactive.shadows or false
    ShadowType = 'None'

    determine_haste_group()
	
	include('Mote-TreasureHunter')	
	state.TreasureMode:set('none')
	send_command('bind ^= gs c cycle treasuremode')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

    gear.MovementFeet = {name="Danzo Sune-ate"}
    gear.DayFeet = "Danzo Sune-ate"
    gear.NightFeet = "Danzo Sune-ate"
    
    select_movement_feet()
	lockstyleset()
    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    
    sets.TreasureHunter = {
        ammo="Per. Lucky Egg",
        head = gear.HercHTH,
        body = gear.HercBTH, 
        --legs = gear.HercLTH,
        waist = "Chaac Belt",
    }
	
	--------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {}
    sets.precast.JA['Futae'] = {}
    sets.precast.JA['Sange'] = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {}

    sets.precast.Flourish1 = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
	head = gear.HercHFC,
	}
	
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

    -- Snapshot for ranged
    sets.precast.RA = {}
	
    sets.precast.enmity =  {}
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="C. Palug Stone",
        head="Mummu Bonnet +1",
        body="Abnoba Kaftan",
        hands="Mummu Wrists +1",
        legs={ name="Ta'lab Trousers", augments={'Accuracy+14','Mag. Evasion+13','Enmity-6','Crit.hit rate+3',}},
        feet="Mummu Gamash. +1",
        neck="Clotharius Torque",
        waist="Anguinus Belt",
        left_ear="Cessance Earring",
        right_ear="Odr Earring",
        left_ring="Mummu Ring",
        right_ring="Ilabrat Ring",
        back="Sacro Mantle",
	}
	
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Aeolian Edge'] = {}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}
	
    sets.midcast.Utsusemi = set_combine(sets.midcast.SelfNinjutsu, {})

    sets.midcast.ElementalNinjutsu = {}

    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {})

    sets.midcast.NinjutsuDebuff = {}

    sets.midcast.NinjutsuBuff = {}

    sets.midcast.RA = {}
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
    sets.idle = {
	ammo="Ginsen",
    head={ name="Dampening Tam", augments={'DEX+6','Mag. Acc.+13',}},
    body="Mummu Jacket +1",
    hands=gear.HercGMB,
    legs="Mummu Kecks +1",
    feet="Danzo Sune-Ate",
    neck="Loricate Torque +1",
    waist="Windbuffet Belt +1",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
    back="Solemnity Cape",
	}

    sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb"})
    
    sets.idle.Weak = {}
    
    -- Defense sets
    sets.defense.Evasion = {}

    sets.defense.PDT = {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Loricate Torque +1",
        left_ring="Defending Ring",
        right_ring="Vocane Ring",
        back="Solemnity Cape",
	}

    sets.defense.MDT = {}

    sets.Kiting = {feet=gear.MovementFeet}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        ammo="Ginsen",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands=gear.AdhGTP,
        legs=gear.SamTTP,
        feet=gear.HercFTP,
        neck="Clotharius Torque",
        waist="Anguinus Belt",
        left_ear="Cessance Earring",
        right_ear="Odr Earring",
        left_ring="Petrov Ring",
        right_ring="Ilabrat Ring",
        back="Sacro Mantle",
	}
	
    sets.engaged.Acc = set_combine(sets.engaged, {})
	
    sets.engaged.Evasion = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.Evasion = set_combine(sets.engaged, {})
	
    sets.engaged.PDT = set_combine(sets.PDT, sets.engaged)
	
    sets.engaged.Acc.PDT = set_combine(sets.engaged, {})

    -- Custom melee group: High Haste (~20% DW)
    sets.engaged.HighHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.HighHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Evasion.HighHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.Evasion.HighHaste = set_combine(sets.engaged, {})
	
    sets.engaged.PDT.HighHaste = set_combine(sets.PDT, sets.engaged)
	
    sets.engaged.Acc.PDT.HighHaste = set_combine(sets.engaged, {})

    -- Custom melee group: Embrava Haste (7% DW)
    sets.engaged.EmbravaHaste = set_combine(sets.engaged, {})
    sets.engaged.Acc.EmbravaHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Evasion.EmbravaHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.Evasion.EmbravaHaste = set_combine(sets.engaged, {})
	
    sets.engaged.PDT.EmbravaHaste = set_combine(sets.PDT, sets.engaged)
	
    sets.engaged.Acc.PDT.EmbravaHaste = set_combine(sets.engaged, {})
	
    -- Custom melee group: Max Haste (0% DW)
    sets.engaged.MaxHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.MaxHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Evasion.MaxHaste = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.Evasion.MaxHaste = set_combine(sets.engaged, {})
	
    sets.engaged.PDT.MaxHaste = set_combine(sets.PDT, sets.engaged)
	
    sets.engaged.Acc.PDT.MaxHaste = set_combine(sets.engaged, {})


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {}
    sets.buff.Doom = {}
    sets.buff.Yonin = {}
    sets.buff.Innin = {}
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific commands
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'shadow' then
        handle_Shadows()
        eventArgs.handled = true
    end
end

function handle_Shadows()
    -- Always trys to cast San > Ni > Ichi
    local spell_recasts = windower.ffxi.get_spell_recasts()

    if spell_recasts[340] > 0 then
        if spell_recasts[339] > 0 then
            if spell_recasts[338] > 0 then
                add_to_chat(8, 'All Shadows on CD, proceed to panic!')
            else
                send_command('@input /ma "Utsusemi: Ichi" <me>')
            end
        else
            send_command('@input /ma "Utsusemi: Ni" <me>')
        end
    else
        send_command('@input /ma "Utsusemi: San" <me>')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.

function job_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Utsusemi: Ichi' and ShadowType == 'Ni' and (buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)']) then
        cancel_spell()
    elseif spell.name == 'Utsusemi: Ni' and ShadowType == 'San' and buffactive['Copy Image (4+)'] then
        cancel_spell()
    end

    if state.DefenseMode == "Physical" or state.DefenseMode == "Magical" then
        if spell.action_type == 'Ability' then
            equip(sets.Enmity)
            equip(sets.precast.JA[spell])
        end
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if spell.name == 'Utsusemi: Ichi' and (ShadowType == 'Ni' or ShadowType == 'San') and (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
        send_command('cancel copy image')
        send_command('cancel copy image (2)')
    elseif spell.name == 'Utsusemi: Ni' and ShadowType == 'San' and (buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)']) then
        send_command('cancel copy image')
        send_command('cancel copy image (2)')
        send_command('cancel copy image (3)')
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end

    if spell.name == 'Utsusemi: San' and spell.interrupted == false then
        ShadowType = 'San'
    elseif spell.name == 'Utsusemi: Ni' and spell.interrupted == false then
        ShadowType = 'Ni'
    elseif spell.name == 'Utsusemi: Ichi' and spell.interrupted == false then
        ShadowType = 'Ichi'
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
end

function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
        select_movement_feet()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Migawari then
        idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    
    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_movement_feet()
    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Hachiya body/legs, Iga head + Patentia Sash, and DW earrings
    
    -- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

    -- For high haste, we want to be able to drop one of the 10% groups.
    -- Basic gear hits capped delay (roughly) with:
    -- 1 March + Haste
    -- 2 March
    -- Haste + Haste Samba
    -- 1 March + Haste Samba
    -- Embrava
    
    -- High haste buffs:
    -- 2x Marches + Haste Samba == 19% DW in gear
    -- 1x March + Haste + Haste Samba == 22% DW in gear
    -- Embrava + Haste or 1x March == 7% DW in gear
    
    -- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste+March or 2x March
    -- 2x Marches + Haste
    
    -- So we want four tiers:
    -- Normal DW
    -- 20% DW -- High Haste
    -- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
    -- 0 DW - Max Haste
    
    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
        classes.CustomMeleeGroups:append('EmbravaHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end


function select_movement_feet()
    if world.time >= 17*60 or world.time < 7*60 then
        gear.MovementFeet.name = gear.NightFeet
    else
        gear.MovementFeet.name = gear.DayFeet
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 13)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 13)
    else
        set_macro_page(1, 13)
    end
end

-- Set a Style Lock
function lockstyleset()
	send_command('wait 5;input /lockstyleset 21')
end