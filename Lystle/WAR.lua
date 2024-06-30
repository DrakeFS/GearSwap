-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
--[[ Updated 9/18/2014, functions with Mote's new includes.
-- Have not played WAR recently, please PM me with any errors 
            BG: Fival
            FFXIAH: Asura.Fiv
]]--
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
            state.Buff['Aftermath'] = buffactive['Aftermath: Lv.1'] or
            buffactive['Aftermath: Lv.2'] or
            buffactive['Aftermath: Lv.3'] or false
            state.Buff['Mighty Strikes'] = buffactive['Mighty Strikes'] or false
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'AccLow', 'AccHigh')
    state.RangedMode:options('Normal')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal','DW')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'Regen')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    
    update_combat_weapon()
    update_melee_groups()
    --select_default_macro_book()
    update_combat_form()
    lockstyleset()

end

function init_gear_sets()
    
    --------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Sets to apply to arbitrary JAs
    sets.precast.JA.Berserk = {}
    sets.precast.JA['Aggressor'] = {}
    sets.precast.JA['Mighty Strikes'] = {}
    sets.precast.JA['Blood Rage'] = {}
    sets.precast.JA['Warcry'] = {}
    sets.precast.JA['Tomahawk'] = {}
    -- Sets to apply to any actions of spell.type
    sets.precast.Waltz = {}
        
    -- Sets for specific actions within spell.type
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Sets for fast cast gear for spells
    sets.precast.FC = {}

    -- Fast cast gear for specific spells or spell maps
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

    -- Weaponskill sets
    sets.precast.WS = {
        ammo="Knobkierrie",
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands="Sulev. Gauntlets +2",
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet="Sulev. Leggings +2",
        neck="Rep. Plat. Medal",
        waist="Cornelia's Belt",
        left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+16','Mag. Acc.+16','Crit.hit rate+6','STR+7 VIT+7',}},
        left_ring="Lehko's Ring",
        right_ring="Epaminondas's Ring",
        back=gear.WarCTP,
    }
    
    
    sets.precast.WS.AccLow = set_combine(sets.precast.WS, {})
    sets.precast.WS.AccHigh = set_combine(sets.precast.WS.AccLow, {})
    sets.precast.WS.Attack = set_combine(sets.precast.WS, {})
    sets.precast.WS.MS = set_combine(sets.precast.WS, {})
    
    sets.precast.WS['Decimation'] = {
        ammo="Coiste Bodhar",
        head="Flam. Zucchetto +2",
        body="Flamma Korazin +2",
        hands="Flam. Manopolas +2",
        legs="Flamma Dirs +2",
        feet="Flam. Gambieras +2",
        neck="Rep. Plat. Medal",
        waist="Shetal Stone",
        left_ear="Thrud Earring",
        right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+16','Mag. Acc.+16','Crit.hit rate+6','STR+7 VIT+7',}},
        left_ring="Lehko's Ring",
        right_ring="Rajas Ring",
        back=gear.WarCTP,
    }

    sets.precast.WS['Savage Blade'] = {
        ammo="Seething Bomblet",
        head="Sulevia's Mask +2",
        body="Sulevia's Plate. +2",
        hands="Sulev. Gauntlets +2",
        legs="Sulev. Cuisses +2",
        feet="Sulev. Leggings +2",
        neck="Clotharius Torque",
        waist="Dynamic Belt",
        left_ear="Steelflash Earring",
        right_ear="Bladeborn Earring",
        left_ring="Sulevia's Ring",
        right_ring="Begrudging Ring",
    }

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- Generic spell recast set
    sets.midcast.FastRecast = {}
    
    -- Specific spells
    sets.midcast.Utsusemi = {}

    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    sets.idle = {
        ammo="Amar Cluster",
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands="Nyame Gauntlets",
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet="Nyame Sollerets",
        neck="Loricate Torque",
        waist="Plat. Mog. Belt",
        left_ear="Glorious Earring",
        right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
        left_ring="Defending Ring",
        right_ring="Shneddick Ring",
    }

    sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})
    
    sets.idle.Regen = set_combine(sets.idle, {})
    
    sets.idle.Weak = set_combine(sets.idle, {})
    
    -- Defense sets
    sets.defense.PDT = {
        ammo="Amar Cluster",
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands="Nyame Gauntlets",
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet="Nyame Sollerets",
        neck="Loricate Torque",
        waist="Plat. Mog. Belt",
        left_ear="Glorious Earring",
        right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
        left_ring="Defending Ring",
        right_ring="Shneddick Ring",
    }
    sets.defense.Reraise = set_combine(sets.defense.PDT, {})
    sets.defense.MDT = set_combine(sets.defense.PDT, {})

    -- Gear to wear for kiting
    sets.Kiting = {}

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- If using a weapon that isn't specified later, the basic engaged sets should automatically be used.
    -- Equip the weapon you want to use and engage, disengage, or force update with f12, the correct gear will be used; default weapon is whats equip when file loads.
    sets.engaged = {
        ammo="Coiste Bodhar",
        head="Flam. Zucchetto +2",
        body="Flamma Korazin +2",
        hands="Flam. Manopolas +2",
        legs="Flamma Dirs +2",
        feet="Flam. Gambieras +2",
        neck="Clotharius Torque",
        waist="Dynamic Belt",
        left_ear="Suppanomimi",
        right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+16','Mag. Acc.+16','Crit.hit rate+6','STR+7 VIT+7',}},
        left_ring="Lehko's Ring",
        right_ring="Rajas Ring",
        back=gear.WarCTP,
    }
    
    sets.engaged.AccLow = set_combine(sets.engaged, {})
    sets.engaged.AccHigh = set_combine(sets.engaged.AccLow, {})
    sets.engaged.PDT = set_combine(sets.engaged, {})
    sets.engaged.AccLow.PDT = set_combine(sets.engaged.PDT, {})
    sets.engaged.AccHigh.PDT = set_combine(sets.engaged.AccLow.PDT, {})

    --------------------------------------
    -- Two Handed sets
    --------------------------------------  
    sets.engaged.THand = {
        ammo="Coiste Bodhar",
        head="Flam. Zucchetto +2",
        body="Flamma Korazin +2",
        hands="Flam. Manopolas +2",
        legs="Flamma Dirs +2",
        feet="Flam. Gambieras +2",
        neck="Clotharius Torque",
        waist="Dynamic Belt",
        left_ear="Brutal Earring",
        right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+16','Mag. Acc.+16','Crit.hit rate+6','STR+7 VIT+7',}},
        left_ring="Lehko's Ring",
        right_ring="Rajas Ring",
        back=gear.WarCTP,
    }
    
    sets.engaged.THand.AccLow = set_combine(sets.engaged.THand, {})
    sets.engaged.THand.AccHigh = set_combine(sets.engaged.THand.AccLow, {})
    sets.engaged.THand.PDT = set_combine(sets.engaged.THand, {})
    sets.engaged.THand.AccLow.PDT = set_combine(sets.engaged.PDT, {})
    sets.engaged.THand.AccHigh.PDT = set_combine(sets.engaged.AccLow.PDT, {})
    --------------------------------------
    -- DW sets
    --------------------------------------
    sets.engaged.DW = {
        ammo="Seething Bomblet",
        head="Flam. Zucchetto +2",
        body="Flamma Korazin +2",
        hands="Flam. Manopolas +2",
        legs="Flamma Dirs +2",
        feet="Flam. Gambieras +2",
        neck="Clotharius Torque",
        waist="Shetal Stone",
        left_ear="Suppanomimi",
        right_ear={ name="Boii Earring +2", augments={'System: 1 ID: 1676 Val: 0','Accuracy+16','Mag. Acc.+16','Crit.hit rate+6','STR+7 VIT+7',}},
        left_ring="Lehko's Ring",
        right_ring="Rajas Ring",
        back=gear.WarCTP,
    }
    
    sets.engaged.DW.AccLow = set_combine(sets.engaged.DW, {})
    sets.engaged.DW.AccHigh = set_combine(sets.engaged.DW.AccLow, {})
    sets.engaged.DW.PDT = set_combine(sets.engaged.DW, {})
    sets.engaged.DW.AccLow.PDT = set_combine(sets.engaged.PDT, {})
    sets.engaged.DW.AccHigh.PDT = set_combine(sets.engaged.AccLow.PDT, {})
    
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
    -- Mighty Strikes TP Gear, combines with current melee set.
    sets.buff.MS = {}
    -- Day/Element Helm, if helm is not in inventory or wardrobe, this will not fire, for those who do not own one
    sets.WSDayBonus = {}
    -- Earrings to use with Upheaval when TP is 3000
    sets.VIT_earring = {}
    -- Earrings to use with all other weaponskills when TP is 3000
    sets.STR_earring = {}
    -- Mantle to use with Upheaval on Darksday
    sets.Upheaval_shadow = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)

end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    --[[if spell.type == 'WeaponSkill' then
            if is_sc_element_today(spell) and player.inventory['Gavialis Helm'] or player.wardrobe['Gavialis Helm'] then
                equip(sets.WSDayBonus)
            end
            if player.tp == 3000 then
                if spell.english == "Upheaval" then
                    equip(sets.VIT_earring)
                else
                    equip(sets.STR_earring)
                end
            end
            if spell.english == "Upheaval" and world.day_element == 'Dark' then
                equip(sets.Upheaval_shadow)
            end
    end]]
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    --[[if spell.english == "Tomahawk" and not spell.interrupted then 
        send_command('timers create "Tomahawk" 90 down')
    end]]
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
    update_combat_weapon()
    update_melee_groups()
    update_combat_form()
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    --[[if buff == "Aftermath: Lv.3" or buff == "Aftermath" then
        classes.CustomMeleeGroups:clear()
        if (buff == "Aftermath: Lv.3" and gain) or buffactive["Aftermath: Lv.3"] then
            if player.equipment.main == "Conqueror" then
                classes.CustomMeleeGroups:append('AM3')
                if gain then
                    send_command('timers create "Aftermath: Lv.3" 180 down;wait 120;input /echo Aftermath: Lv.3 [WEARING OFF IN 60 SEC.];wait 30;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 20;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
                else
                    send_command('timers delete "Aftermath: Lv.3"')
                    add_to_chat(123,'AM3: [OFF]')
                end
            end
        end
        if (buff == "Aftermath" and gain) or buffactive.Aftermath then
            if player.equipment.main == "Bravura" and state.HybridMode.value == 'PDT' then
                classes.CustomMeleeGroups:append('AM')
            end
        end
    end
    if buff == "Aftermath: Lv.3" or buff == "Aftermath" then
        handle_equipping_gear(player.status)
    end
    if buff == 'Blood Rage' and gain then
        send_command('timers create "Blood Rage" 60 down abilities/00255.png')
        else
        send_command('timers delete "Blood Rage"')
    end
    if buff == 'Warcry' and gain then
        send_command('timers create "Warcry" 60 down abilities/00255.png')
        else
        send_command('timers delete "Warcry"')
    end
    if buff == "sleep" and gain and player.hp > 200 and player.status == "Engaged" then
        equip({neck="Berserker's Torque"})
        else
        handle_equipping_gear(player.status)
    end]]
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
--[[function get_custom_wsmode(spell, spellMap, default_wsmode)
    local wsmode = ''
    if state.Buff['Mighty Strikes'] then
        wsmode = wsmode .. 'MS'
    end
        if wsmode ~= '' then
            return wsmode
    end
end]]

-- Modify the default melee set after it was constructed.
--[[function customize_melee_set(meleeSet)
    if buffactive["Mighty Strikes"] then
        meleeSet = set_combine(meleeSet, sets.buff.MS)
    end
    return meleeSet
end]]

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_weapon()
    update_melee_groups()
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
local msg = 'Melee'
if state.CombatForm.has_value then
msg = msg .. ' (' .. state.CombatForm.value .. ')'
end
if state.CombatWeapon.has_value then
msg = msg .. ' (' .. state.CombatWeapon.value .. ')'
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
add_to_chat(122, msg)
eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(5, 20)
    --[[if player.sub_job == 'WAR' then
        set_macro_page(5, 20)
    elseif player.sub_job == 'NIN' then
        set_macro_page(5, 20)
    elseif player.sub_job == 'SAM' then
        set_macro_page(5, 20)
    else
        set_macro_page(5, 20)
    end]]
end

function update_combat_weapon()
    state.CombatWeapon:set(player.equipment.main)
end

function update_melee_groups()
    --[[classes.CustomMeleeGroups:clear()
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Conqueror" then
        classes.CustomMeleeGroups:append('AM3')
    end
    if buffactive.Aftermath and player.equipment.main == "Bravura" and state.HybridMode.value == 'PDT' then
        classes.CustomMeleeGroups:append('AM')
    end]]
end

--[[function is_sc_element_today(spell)
    if spell.type ~= 'WeaponSkill' then
        return
    end

   local weaponskill_elements = S{}:
    union(skillchain_elements[spell.skillchain_a]):
    union(skillchain_elements[spell.skillchain_b]):
    union(skillchain_elements[spell.skillchain_c])

    if weaponskill_elements:contains(world.day_element) then
        return true
    else
        return false
    end
end]]

function update_combat_form()
    if cf_check then --checks if cf_check() exists
        cf_check() -- Check for 2H, Single or Duel Wield, function is defined in the Lystle-Globals.lua
    end
end

function lockstyleset()
    send_command('wait 5;input /lockstyleset 6')
end