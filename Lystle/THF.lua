-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
    
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Crit')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')

    -- Additional local binds
    -- send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')
    --state.TreasureMode:set('Fulltime')
    select_default_macro_book()
    lockstyleset()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    -- send_command('unbind ^`')
    send_command('unbind !-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

    sets.TreasureHunter = {
        ammo="Per. Lucky Egg",
        head=gear.HercHeTH,
        body=gear.HercBTH,
        hands={ name="Plun. Armlets +1", augments={'Enhances "Perfect Dodge" effect',}},
        legs=gear.HercLTH,
        feet="Skulk. Poulaines +3",
        waist="Chaac Belt",
        left_ring="Gorney Ring",
    }
    -- sets.ExtraRegen = {head="Ocelomeh Headpiece +1"}
    sets.Kiting = {feet="Jute Boots +1",}

    --sets.buff['Sneak Attack'] = {}

    --sets.buff['Trick Attack'] = {}

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    --sets.precast.JA['Collaborator'] = {}
    --sets.precast.JA['Accomplice'] = {}
    sets.precast.JA['Flee'] = {feet="Pill. Poulaines +3",}
    --sets.precast.JA['Hide'] = {}
    --sets.precast.JA['Conspirator'] = {} 
    sets.precast.JA['Steal'] = {
        ammo="Barathrum",
        head="Rogue's Bonnet",
        legs="Assassin's Culottes",
        feet="Pill. Poulaines +3",
        left_ring="Gorney Ring",
    }
    --sets.precast.JA['Despoil'] = {}
    --sets.precast.JA['Perfect Dodge'] = {}
    --sets.precast.JA['Feint'] = {} 

    --sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    --sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    -- Waltz set (chr and vit)
    --sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    --sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    --- sets.precast.FC = {head="Haruspex Hat",ear2="Loquacious Earring",hands="Thaumas Gloves",ring1="Prolix Ring",legs="Enif Cosciales"}

    -- sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


    -- Ranged snapshot gear
    -- sets.precast.RA = {}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {    
        ammo="Oshasha's Treatise",
        head={ name="Herculean Helm", augments={'Accuracy+15','"Fast Cast"+4','Weapon skill damage +7%','Accuracy+16 Attack+16','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands="Meg. Gloves +2",
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Sherida Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Epaminondas's Ring",
        right_ring="Begrudging Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    }
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})
    --[[sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'], {})
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'], {})
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'], {})]]

    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {})
    
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        head="Mummu Bonnet +2",
        body="Mummu Jacket +2",
        hands="Mummu Wrists +2",
        legs="Mummu Kecks +2",
        feet="Mummu Gamash. +2",
        right_ear="Crep. Earring",
        left_ring="Lehko's Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
    })
    
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {})
    
    sets.precast.WS['Shark Bite'] = set_combine(sets.precast.WS, {})
    
    sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {})
    
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        feet="Nyame Sollerets",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','"Store TP"+4',}},
        left_ring="Mummu Ring",
    })
    
    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

    sets.precast.WS["Savage Blade"] = set_combine(sets.precast.WS, {
        legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
        feet="Meg. Jam. +1",
        right_ring="Meghanada Ring",
    })


    --------------------------------------
    -- Midcast sets
    --------------------------------------
    sets.midcast['ELemental Magic'] = {
        head="Nyame Helm",
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands="Nyame Gauntlets",
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet="Nyame Sollerets",
    }
    sets.midcast.FastRecast = {}

    -- Specific spells
    sets.midcast.Utsusemi = {}

    -- Ranged gear
    sets.midcast.RA = {}

    sets.midcast.RA.Acc = {}


    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
        head="Nyame Helm",
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands="Malignance Gloves",
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet="Pill. Poulaines +3",
        neck="Sanctity Necklace",
        left_ring="Meghanada Ring",
        right_ring="Defending Ring",
        back="Solemnity Cape",  
    }

    sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})

    sets.idle.Weak = {}


    -- Defense sets

    sets.defense.Evasion = {
        head="Meghanada Visor +1",
        body="Meg. Cuirie +2",
        hands="Malignance Gloves",
        legs="Mummu Kecks +2",
        feet="Meg. Jam. +1",
        neck="Loricate Torque",
        left_ring="Defending Ring",
        right_ring="Shneddick Ring",
        back="Solemnity Cape",
    }

    sets.defense.PDT = set_combine(sets.defense.Evasion, {})

    sets.defense.MDT = {}


    --------------------------------------
    -- Melee sets
    --------------------------------------

    -- Normal melee group
    sets.engaged = {    
        ammo="Coiste Bodhar",
        head="Mummu Bonnet +2",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
        feet="Mummu Gamash. +2",
        neck="Clotharius Torque",
        waist="Shetal Stone",
        left_ear="Sherida Earring",
        right_ear={ name="Skulk. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','"Store TP"+5',}},
        left_ring="Rajas Ring",
        right_ring="Lehko's Ring",
        back = gear.ThfCTP,
    }
    
    sets.engaged.Acc = set_combine(sets.engaged,{neck="Sanctity Necklace",})

    sets.engaged.Crit = set_combine(sets.engaged,{    
        ammo="Seething Bomblet",
        head="Mummu Bonnet +2",
        body="Mummu Jacket +2",
        hands="Mummu Wrists +2",
        legs="Mummu Kecks +2",
        feet="Mummu Gamash. +2",
        neck="Clotharius Torque",
        waist="Dynamic Belt",
        left_ear="Steelflash Earring",
        right_ear="Suppanomimi",
        left_ring="Mummu Ring",
        right_ring="Begrudging Ring",
    })
    -- Mod set for trivial mobs (Skadi+1)
    -- sets.engaged.Mod = {}

    -- Mod set for trivial mobs (Thaumas)
    -- sets.engaged.Mod2 = {}

    sets.engaged.Evasion = set_combine(sets.engaged,{})
    sets.engaged.Acc.Evasion = set_combine(sets.engaged,{})

    sets.engaged.PDT = set_combine(sets.engaged,{})
    sets.engaged.Acc.PDT = set_combine(sets.engaged,{})

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
    
    msg = msg .. ', TH: ' .. state.TreasureMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 6)
    else
        set_macro_page(1, 6)
    end
end

    -- Set a Style Lock
function lockstyleset()
    send_command('wait 5;input /lockstyleset 4')
end