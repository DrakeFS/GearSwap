-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+H ]           Toggle Charm Defense Mods
--              [ WIN+D ]           Toggle Death Defense Mods
--              [ WIN+K ]           Toggle Knockback Defense Mods
--              [ WIN+A ]           AttackMode: Capped/Uncapped WS Modifier
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Use current Rune
--              [ CTRL+- ]          Rune element cycle forward.
--              [ CTRL+= ]          Rune element cycle backward.
--              [ CTRL+` ]          Use current Rune
--
--              [ CTRL+Numpad/ ]    Berserk/Meditate/Souleater
--              [ CTRL+Numpad* ]    Warcry/Sekkanoki/Arcane Circle
--              [ CTRL+Numpad- ]    Aggressor/Third Eye/Weapon Bash
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ CTRL+G ]          Cycles between available greatswords
--              [ CTRL+W ]          Toggle Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Resolution
--              [ CTRL+Numpad8 ]    Upheaval
--              [ CTRL+Numpad9 ]    Dimidiation
--              [ CTRL+Numpad5 ]    Ground Strike
--              [ CTRL+Numpad6 ]    Full Break
--              [ CTRL+Numpad1 ]    Herculean Slash
--              [ CTRL+Numpad2 ]    Shockwave
--              [ CTRL+Numpad3 ]    Armor Break
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------


--  gs c rune                       Uses current rune
--  gs c cycle Runes                Cycles forward through rune elements
--  gs c cycleback Runes            Cycles backward through rune elements


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    res = require 'resources'
end

-- Setup vars that are user-independent.
function job_setup()

    -- /BLU Spell Maps
    blue_magic_maps = {}

    blue_magic_maps.Enmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific',
        'Poison Breath', 'Blitzstrahl', 'Sheep Song', 'Chaotic Eye'}
    blue_magic_maps.Cure = S{'Wild Carrot'}
    blue_magic_maps.Buffs = S{'Cocoon', 'Refueling'}

    rayke_duration = 35
    gambit_duration = 96

    lockstyleset = 2

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('STP', 'Normal', 'LowAcc', 'MidAcc', 'HighAcc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT', 'HP')
    state.MagicalDefenseMode:options('MDT')

    state.Knockback = M(false, 'Knockback')

    state.WeaponSet = M{['description']='Weapon Set', 'Epeolatry', 'Lionheart', 'Aettir', 'GreatAxe'}
    state.AttackMode = M{['description']='Attack', 'Uncapped', 'Capped'}
     state.WeaponLock = M(false, 'Weapon Lock')

    state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}

    -- Additional local binds
    --[[include('Global-Binds.lua') -- OK to remove this line
    include('Global-GEO-Binds.lua') -- OK to remove this line

    send_command('bind ^` input //gs c rune')
    send_command('bind !` input /ja "Vivacious Pulse" <me>')
    send_command('bind ^insert gs c cycleback Runes')
    send_command('bind ^delete gs c cycle Runes')
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind @a gs c cycle AttackMode')
    send_command('bind @c gs c toggle CP')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @k gs c toggle Knockback')
    send_command('bind !q input /ma "Temper" <me>')

    if player.sub_job == 'BLU' then
        send_command('bind !w input /ma "Cocoon" <me>')
    elseif player.sub_job == 'WAR' then
        send_command('bind !w input /ja "Defender" <me>')
    elseif player.sub_job == 'DRK' then
        send_command('bind !w input /ja "Last Resort" <me>')
    elseif player.sub_job == 'SAM' then
        send_command('bind !w input /ja "Hasso" <me>')
    end

    send_command('bind !o input /ma "Regen IV" <stpc>')
    send_command('bind !p input /ma "Ice Spikes" <me>')

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @c gs c toggle CP')

    if player.sub_job == 'WAR' then
        send_command('bind ^numpad/ input /ja "Berserk" <me>')
        send_command('bind ^numpad* input /ja "Warcry" <me>')
        send_command('bind ^numpad- input /ja "Aggressor" <me>')
    elseif player.sub_job == 'DRK' then
        send_command('bind ^numpad/ input /ja "Souleater" <me>')
        send_command('bind ^numpad* input /ja "Arcane Circle" <me>')
        send_command('bind ^numpad- input /ja "Weapon Bash" <me>')
    elseif player.sub_job == 'SAM' then
        send_command('bind ^numpad/ input /ja "Meditate" <me>')
        send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
        send_command('bind ^numpad- input /ja "Third Eye" <me>')
    end

    send_command('bind ^numpad7 input /ws "Resolution" <t>')
    send_command('bind ^numpad8 input /ws "Upheaval" <t>')
    send_command('bind ^numpad9 input /ws "Dimidiation" <t>')
    send_command('bind ^numpad5 input /ws "Ground Strike" <t>')
    send_command('bind ^numpad6 input /ws "Full Break" <t>')
    send_command('bind ^numpad1 input /ws "Herculean Slash" <t>')
    send_command('bind ^numpad2 input /ws "Shockwave" <t>')
    send_command('bind ^numpad3 input /ws "Armor Break" <t>')

    select_default_macro_book()
    set_lockstyle()]]
end

function user_unload()
    --[[send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^f11')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind @a')
    send_command('unbind @c')
    send_command('unbind @d')
    send_command('unbind !q')
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind !o')
    send_command('unbind !p')
    send_command('unbind ^,')
    send_command('unbind @w')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad9')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad1')
    send_command('unbind @numpad*')

    send_command('unbind #`')
    send_command('unbind #1')
    send_command('unbind #2')
    send_command('unbind #3')
    send_command('unbind #4')
    send_command('unbind #5')
    send_command('unbind #6')
    send_command('unbind #7')
    send_command('unbind #8')
    send_command('unbind #9')
    send_command('unbind #0')]]
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Enmity sets
    sets.Enmity = {}

    sets.Enmity.HP = {}

    sets.precast.JA['Vallation'] = {}
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = {}
    sets.precast.JA['Battuta'] = {}
    sets.precast.JA['Liement'] = {}

    sets.precast.JA['Lunge'] = {}

    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {}
    sets.precast.JA['Rayke'] = {}
    sets.precast.JA['Elemental Sforzo'] = {}
    sets.precast.JA['Swordplay'] = {}
    sets.precast.JA['Vivacious Pulse'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {}

    sets.precast.FC.HP = set_combine(sets.precast.FC, {})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {}

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    sets.precast.WS.Uncapped = set_combine(sets.precast.WS, {})  

    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], {})

    sets.precast.WS['Resolution'].Uncapped = set_combine(sets.precast.WS['Resolution'], {})

    sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'], {})

    sets.precast.WS['Dimidiation'].Uncapped = set_combine(sets.precast.WS['Dimidiation'], {})

    sets.precast.WS['Herculean Slash'] = sets.precast.JA['Lunge']

    sets.precast.WS['Shockwave'] = {}

    sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Upheaval'] = sets.precast.WS['Resolution']
    sets.precast.WS['Full Break'] = sets.precast.WS['Shockwave']
    sets.precast.WS['Savage Blade'] = {
    ammo="Aqreqaq Bomblet",
    head={ name="Herculean Helm", augments={'Phys. dmg. taken -1%','Weapon skill damage +3%','"Treasure Hunter"+1','Accuracy+20 Attack+20',}},
    body="Ayanmo Corazza +2",
    hands="Meg. Gloves +1",
    legs="Meg. Chausses +1",
    feet="Aya. Gambieras +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Odr Earring",
    right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    left_ring="Petrov Ring",
    right_ring="Apate Ring",
    back="Xucau Mantle",
    }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {} -- +10% from merit points

    sets.midcast.Cure = {}

    sets.midcast['Enhancing Magic'] = {}

    sets.midcast.EnhancingDuration = {}

    sets.midcast['Phalanx'] = set_combine(sets.midcast.SpellInterrupt, {})

    sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.SpellInterrupt, {})

    sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Shell = sets.midcast.Protect

    sets.midcast['Divine Magic'] = {}

    sets.midcast.Flash = sets.Enmity
    sets.midcast.Foil = sets.Enmity
    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast['Blue Magic'] = {}
    sets.midcast['Blue Magic'].Enmity = sets.Enmity
    sets.midcast['Blue Magic'].Cure = sets.midcast.Cure
    sets.midcast['Blue Magic'].Buff = sets.midcast['Enhancing Magic']


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {}

    sets.idle.DT = {}

    sets.idle.Town = set_combine(sets.idle, {})

    sets.idle.Weak = sets.idle.DT
    sets.Kiting = {legs="Carmine Cuisses +1"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.Knockback = {}

    sets.defense.PDT = {
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ring="Vocane Ring",
    right_ring="Defending Ring",
    }

    sets.defense.MDT = {}

    sets.defense.HP = {}

    sets.defense.Parry = {}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {
    ammo="Ginsen",
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Clotharius Torque",
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Cessance Earring",
    left_ring="Pernicious Ring",
    right_ring="Petrov Ring",
    }
    
    sets.engaged.THand = sets.enganged
    
    sets.engaged.DW = {
    ammo="Ginsen",
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Clotharius Torque",
    waist="Windbuffet Belt +1",
    left_ear="Suppanomimi",
    right_ear="Eabani Earring",
    left_ring="Pernicious Ring",
    right_ring="Petrov Ring",
    }

    sets.engaged.LowAcc = set_combine(sets.engaged, {})

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {})

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {})

    sets.engaged.STP = set_combine(sets.engaged, {})

    sets.engaged.Aftermath = {}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.Hybrid = {
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Loricate Torque +1",
    left_ring="Vocane Ring",
    right_ring="Defending Ring",
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.Hybrid)

    sets.engaged.Aftermath.DT = {}    

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {}

    sets.Embolden = set_combine(sets.midcast.EnhancingDuration, {})

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])

    if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] then
        add_to_chat(167, 'Stopped due to status.')
        eventArgs.cancel = true
        return
    end
    if state.DefenseMode.value == 'HP' then
        currentSpell = spell.english
        eventArgs.handled = true
        if spell.action_type == 'Magic' then
            equip(sets.precast.FC.HP)
        elseif spell.action_type == 'Ability' then
            equip(sets.Enmity.HP)
            equip(sets.precast.JA[currentSpell])
        end
    else
        if spell.action_type == 'Ability' then
            equip(sets.Enmity)
            equip(sets.precast.JA[spell])
        end
    end
    if spell.english == 'Lunge' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Swipe" <t>')
--            add_to_chat(122, '***Lunge Aborted: Timer on Cooldown -- Downgrading to Swipe.***')
            eventArgs.cancel = true
            return
        end
    end
    if spell.english == 'Valiance' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Vallation" <me>')
            eventArgs.cancel = true
            return
        elseif spell.english == 'Valiance' and buffactive['vallation'] then
            cast_delay(0.2)
            send_command('cancel Vallation') -- command requires 'cancel' add-on to work
        end
    end
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.DefenseMode.value == 'HP' and spell.english ~= "Phalanx" then
        eventArgs.handled = true
        if spell.action_type == 'Magic' then
            if spell.English == 'Flash' or spell.English == 'Foil' or spell.English == 'Stun'
                or blue_magic_maps.Enmity:contains(spell.english) then
                equip(sets.Enmity.HP)
            elseif spell.skill == 'Enhancing Magic' then
                equip(sets.midcast.EnhancingDuration)
            end
        end
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if state.DefenseMode.value == 'None' then
        if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
        end
        if spell.english == 'Phalanx' and buffactive['Embolden'] then
            equip(sets.midcast.EnhancingDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])

    if spell.name == 'Rayke' and not spell.interrupted then
        send_command('@timers c "Rayke ['..spell.target.name..']" '..rayke_duration..' down spells/00136.png')
        send_command('wait '..rayke_duration..';input /echo [Rayke just wore off!];')
    elseif spell.name == 'Gambit' and not spell.interrupted then
        send_command('@timers c "Gambit ['..spell.target.name..']" '..gambit_duration..' down spells/00136.png')
        send_command('wait '..gambit_duration..';input /echo [Gambit just wore off!];')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.Charm.current)
    classes.CustomDefenseGroups:append(state.Knockback.current)
    classes.CustomDefenseGroups:append(state.Death.current)

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.Charm.current)
    classes.CustomMeleeGroups:append(state.Knockback.current)
    classes.CustomMeleeGroups:append(state.Death.current)
end

function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.

    if buff == "terror" then
        if gain then
            equip(sets.defense.PDT)
        end
    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
             disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

    if buff == 'Embolden' then
        if gain then
            equip(sets.Embolden)
            disable('head','legs','back')
        else
            enable('head','legs','back')
            status_change(player.status)
        end
    end

    if buff:startswith('Aftermath') then
        state.Buff.Aftermath = gain
        customize_melee_set()
        handle_equipping_gear(player.status)
    end

    if buff == 'Battuta' and not gain then
        status_change(player.status)
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end

    equip(sets[state.WeaponSet.current])
    update_combat_form()

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_update(cmdParams, eventArgs)
    equip(sets[state.WeaponSet.current])
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Knockback.value == true then
        idleSet = set_combine(idleSet, sets.defense.Knockback)
    end
    update_combat_form()
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Epeolatry"
        and state.DefenseMode.value == 'None' then
        if state.HybridMode.value == "DT" then
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath.DT)
        else
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
        end
    end
    if state.Knockback.value == true then
        meleeSet = set_combine(meleeSet, sets.defense.Knockback)
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Battuta'] then
        defenseSet = set_combine(defenseSet, sets.defense.Parry)
    end
    if state.Knockback.value == true then
        defenseSet = set_combine(defenseSet, sets.defense.Knockback)
    end

    return defenseSet
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local r_msg = state.Runes.current
    local r_color = ''
    if state.Runes.current == 'Ignis' then r_color = 167
    elseif state.Runes.current == 'Gelus' then r_color = 210
    elseif state.Runes.current == 'Flabra' then r_color = 204
    elseif state.Runes.current == 'Tellus' then r_color = 050
    elseif state.Runes.current == 'Sulpor' then r_color = 215
    elseif state.Runes.current == 'Unda' then r_color = 207
    elseif state.Runes.current == 'Lux' then r_color = 001
    elseif state.Runes.current == 'Tenebrae' then r_color = 160 end

    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local am_msg = '(' ..string.sub(state.AttackMode.value,1,1).. ')'

    local ws_msg = state.WeaponskillMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Knockback.value == true then
        msg = msg .. ' Knockback Resist |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(r_color, string.char(129,121).. '  ' ..string.upper(r_msg).. '  ' ..string.char(129,122)
        ..string.char(31,210).. ' Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002).. ' |'
        ..string.char(31,207).. ' WS' ..am_msg.. ': ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060)
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002).. ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002).. ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    end
end

function get_custom_wsmode(spell, action, spellMap)
    if spell.type == 'WeaponSkill' and state.AttackMode.value == 'Uncapped' then
        return "Uncapped"
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function update_combat_form()
    if cf_check then --checks if cf_check() exists
        cf_check() -- Check for 2H, Single or Duel Wield, function is defined in the Dagna-Globals.lua
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book: (set, book)
    if player.sub_job == 'BLU' then
        set_macro_page(2, 12)
    elseif player.sub_job == 'DRK' then
        set_macro_page(3, 12)
    elseif player.sub_job == 'WHM' then
        set_macro_page(4, 12)
    else
        set_macro_page(1, 12)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end
