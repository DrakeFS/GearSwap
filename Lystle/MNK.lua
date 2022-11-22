-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    include('Mote-TreasureHunter')
    
    state.Buff.Footwork = buffactive.Footwork or false
    state.Buff.Impetus = buffactive.Impetus or false

    state.FootworkWS = M(false, 'Footwork on WS')

    info.impetus_hit_count = 0

    windower.raw_register_event('action', on_action_for_impetus)
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal')
    state.WeaponskillMode:options('Normal', 'SomeAcc', 'Acc', 'Fodder')
    state.HybridMode:options('Normal', 'PDT', 'Counter')
    state.PhysicalDefenseMode:options('PDT', 'HP')

    update_combat_form()
    update_melee_groups()

    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs on use
    sets.precast.JA['Hundred Fists'] = {}
    sets.precast.JA['Boost'] = {waist="Ask Sash"}
    sets.precast.JA['Dodge'] = {}
    sets.precast.JA['Focus'] = {}
    sets.precast.JA['Counterstance'] = {}
    sets.precast.JA['Footwork'] = {}
    sets.precast.JA['Formless Strikes'] = {}
    sets.precast.JA['Mantra'] = {}
    sets.precast.JA['Chi Blast'] = {}
    sets.precast.JA['Chakra'] = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.Step = {}
    sets.precast.Flourish1 = {}


    -- Fast cast sets for spells
    
    --sets.precast.FC = {}

    --sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

    sets.TreasureHunter = {
        body=gear.HercBTH,
        legs=gear.HercLTH,
    }
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.
    
    
    sets.precast.WS['Raging Fists']    = set_combine(sets.precast.WS, {})
    sets.precast.WS['Howling Fist']    = set_combine(sets.precast.WS, {})
    sets.precast.WS['Asuran Fists']    = set_combine(sets.precast.WS, {belt="Shadow Belt",})
    sets.precast.WS['Victory Smite']   = set_combine(sets.precast.WS, {})
    sets.precast.WS['Shijin Spiral']   = set_combine(sets.precast.WS, {})
    sets.precast.WS['Dragon Kick']     = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tornado Kick']    = set_combine(sets.precast.WS, {})
    sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Cataclysm'] = {}
    
    -- Midcast Sets
    --sets.midcast.FastRecast = {}

    -- Specific spells
    --sets.midcast.Utsusemi = {}

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    --sets.resting = {}
    

    -- Idle sets
    sets.idle = {
    neck="Sanctity Necklace",
    }

    sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})
    
    --sets.idle.Weak = {}
    
    -- Defense sets
    sets.defense.PDT = {}

    --[[sets.defense.HP = {}

    sets.defense.MDT = {}

    sets.Kiting = {}

    sets.ExtraRegen = {}]]

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee sets
    sets.engaged = {
        head="Mummu Bonnet +2",
        body="Mummu Jacket +2",
        hands="Malignance Gloves",
        legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
        feet="Mummu Gamash. +2",
        neck="Lissome Necklace",
        waist="Famine Sash",
        left_ear="Crep. Earring",
        right_ear="Sherida Earring",
        left_ring="Rajas Ring",
        right_ring="Begrudging Ring",
        back="Atheling Mantle",
        }
    
    -- Defensive melee hybrid sets
    --sets.engaged.PDT = {}
    
    --sets.engaged.Counter = {}

    -- Hundred Fists/Impetus melee set mods
    --[[sets.engaged.HF = set_combine(sets.engaged)
    sets.engaged.HF.Impetus = set_combine(sets.engaged, {body="Bhikku Cyclas +1"})
    sets.engaged.Impetus = set_combine(sets.engaged, {body="Bhikku Cyclas +1"})
    sets.engaged.Acc.HF = set_combine(sets.engaged.Acc)
    sets.engaged.Acc.HF.Impetus = set_combine(sets.engaged.Acc, {body="Bhikku Cyclas +1"})
    sets.engaged.Acc.Impetus = set_combine(sets.engaged.Acc, {body="Bhikku Cyclas +1"})
    sets.engaged.Counter.HF = set_combine(sets.engaged.Counter)
    sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter, {body="Bhikku Cyclas +1"})
    sets.engaged.Counter.Impetus = set_combine(sets.engaged.Counter, {body="Bhikku Cyclas +1"})
    sets.engaged.Acc.Counter.HF = set_combine(sets.engaged.Acc.Counter)
    sets.engaged.Acc.Counter.HF.Impetus = set_combine(sets.engaged.Acc.Counter, {body="Bhikku Cyclas +1"})
    sets.engaged.Acc.Counter.Impetus = set_combine(sets.engaged.Acc.Counter, {body="Bhikku Cyclas +1"})
    ]]

    -- Footwork combat form
    sets.engaged.Footwork = {}
    
    -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
    sets.impetus_body = {}
    sets.footwork_kick_feet = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Don't gearswap for weaponskills when Defense is on.
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        eventArgs.handled = true
    end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
            -- Need 6 hits at capped dDex, or 9 hits if dDex is uncapped, for Tantra to tie or win.
            if (state.OffenseMode.current == 'Fodder' and info.impetus_hit_count > 5) or (info.impetus_hit_count > 8) then
                equip(sets.impetus_body)
            end
        elseif state.Buff.Footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
            equip(sets.footwork_kick_feet)
        end
        
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and not spell.interrupted and state.FootworkWS and state.Buff.Footwork then
        send_command('cancel Footwork')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Set Footwork as combat form any time it's active and Hundred Fists is not.
    if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
    
    -- Hundred Fists and Impetus modify the custom melee groups
    if buff == "Hundred Fists" or buff == "Impetus" then
        classes.CustomMeleeGroups:clear()
        
        if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
            classes.CustomMeleeGroups:append('HF')
        end
        
        if (buff == "Impetus" and gain) or buffactive.impetus then
            classes.CustomMeleeGroups:append('Impetus')
        end
    end

    -- Update gear if any of the above changed
    if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" or buff == "Boost" then
        handle_equipping_gear(player.status)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set (idleSet)
    if buffactive['Boost'] then
        idleSet = set_combine(idleSet, {waist="Ask Sash"})
    end
    return idleSet
end

function customize_melee_set(meleeSet)
    if buffactive['Boost'] then
        meleeSet = set_combine(meleeSet, {waist="Ask Sash"})
    end
    return meleeSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    update_melee_groups()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'ws' then
        handle_WS()
        eventArgs.handled = true
    end
end

function handle_WS()
    if buffactive.footwork then
        send_command('@input /ws "Tornado Kick" <t>')
    elseif player.tp < 2000 then
        send_command('@input /ws "Asuran Fists" <t>')
    else 
        send_command('@input /ws "Raging Fists" <t>')
    end
end 

function update_combat_form()
    if buffactive.footwork and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()
    
    if buffactive['hundred fists'] then
        classes.CustomMeleeGroups:append('HF')
    end
     
    if buffactive.impetus then
        classes.CustomMeleeGroups:append('Impetus')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 2)
end


-------------------------------------------------------------------------------------------------------------------
-- Custom event hooks.
-------------------------------------------------------------------------------------------------------------------

-- Keep track of the current hit count while Impetus is up.
function on_action_for_impetus(action)
    if state.Buff.Impetus then
        -- count melee hits by player
        if action.actor_id == player.id then
            if action.category == 1 then
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- Reactions (bitset):
                        -- 1 = evade
                        -- 2 = parry
                        -- 4 = block/guard
                        -- 8 = hit
                        -- 16 = JA/weaponskill?
                        -- If action.reaction has bits 1 or 2 set, it missed or was parried. Reset count.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 1
                        end
                    end
                end
            elseif action.category == 3 then
                -- Missed weaponskill hits will reset the counter.  Can we tell?
                -- Reaction always seems to be 24 (what does this value mean? 8=hit, 16=?)
                -- Can't tell if any hits were missed, so have to assume all hit.
                -- Increment by the minimum number of weaponskill hits: 2.
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- This will only be if the entire weaponskill missed or was parried.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 2
                        end
                    end
                end
            end
        elseif action.actor_id ~= player.id and action.category == 1 then
            -- If mob hits the player, check for counters.
            for _,target in pairs(action.targets) do
                if target.id == player.id then
                    for _,action in pairs(target.actions) do
                        -- Spike effect animation:
                        -- 63 = counter
                        -- ?? = missed counter
                        if action.has_spike_effect then
                            -- spike_effect_message of 592 == missed counter
                            if action.spike_effect_message == 592 then
                                info.impetus_hit_count = 0
                            elseif action.spike_effect_animation == 63 then
                                info.impetus_hit_count = info.impetus_hit_count + 1
                            end
                        end
                    end
                end
            end
        end
        
        --add_to_chat(123,'Current Impetus hit count = ' .. tostring(info.impetus_hit_count))
    else
        info.impetus_hit_count = 0
    end
    
end