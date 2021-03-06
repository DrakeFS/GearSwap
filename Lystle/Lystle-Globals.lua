function define_global_sets()
    -- Special
    gear.CPCape = { name="Mecisto. Mantle", augments={'Cap. Point+37%','"Mag.Atk.Bns."+1','DEF+2',}}

    -- Head
    gear.HercHeTH = { name="Herculean Helm", augments={'Pet: STR+10','INT+14','"Treasure Hunter"+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}
    -- Hands
    
    -- Body
    gear.HercBTH = { name="Herculean Vest", augments={'DEX+9','Mag. Acc.+18','"Treasure Hunter"+2','Mag. Acc.+10 "Mag.Atk.Bns."+10',}}
    -- Legs
    gear.HercLTH = {name="Herculean Trousers", augments={'MND+10','CHR+7','"Treasure Hunter"+2','Accuracy+6 Attack+6',}}

    -- Feet
    
    -- JSE Capes
    gear.ThfCTP = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
    gear.WarCTP = {name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%',}}
    gear.WhmCFC = {name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}
    gear.BrdCFC = {name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}
    -- Override sets
    sets.CapacityMantle = {back=gear.CPCape}
    sets.PDI = {    
    body="Hervor Haubert",
    hands="Hervor Mouffles",
    feet="Hervor Sollerets",
    }

    -- Global States
    state.CapacityMode = M(false, 'Capacity Point Mantle')
    
end

function global_on_load()
    dw_skill_list = S{2,3,5,11}
    thand_skill_list = S{4,6,7,8,10}
    send_command('bind f9 gs c cycle OffenseMode')
    send_command('bind ^f9 gs c cycle HybridMode')
    send_command('bind !f9 gs c cycle RangedMode')
    send_command('bind @f9 gs c cycle WeaponskillMode')
    send_command('bind f10 gs c set DefenseMode Physical')
    send_command('bind ^f10 gs c cycle PhysicalDefenseMode')
    send_command('bind !f10 gs c toggle Kiting')
    send_command('bind f11 gs c set DefenseMode Magical')
    send_command('bind ^f11 gs c cycle CastingMode')
    send_command('bind f12 gs c update user')
    send_command('bind ^f12 gs c cycle IdleMode')
    send_command('bind !f12 gs c reset DefenseMode')
    send_command('bind != gs c toggle CapacityMode')
end

function global_on_unload()
    send_command('unbind f9')
    send_command('unbind ^f9')
    send_command('unbind !f9')
    send_command('unbind @f9')
    send_command('unbind f10')
    send_command('unbind ^f10')
    send_command('unbind !f10')
    send_command('unbind f11')
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind f12')
    send_command('unbind ^f12')
    send_command('unbind !f12')
    send_command('unbind !=')
end

-- Global intercept on midcast.
function user_post_precast(spell, action, spellMap, eventArgs)
    if buffactive['Reive Mark'] and spell.type == 'WeaponSkill' then
        equip(sets.reive)
    end
        if buffactive['Elvorseal'] and spell.type == 'WeaponSkill' then
        equip(sets.PDI)
    end
end

function user_customize_idle_set(idleSet)
    if buffactive['Reive Mark'] then
        idleSet = set_combine(idleSet, sets.reive)
    end
    if state.CapacityMode.value then
        idleSet = set_combine(idleSet, sets.CapacityMantle)
    end
    return idleSet
end

function user_customize_melee_set(meleeSet)
    if buffactive['Reive Mark'] then
        meleeSet = set_combine(meleeSet, sets.reive)
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
        if buffactive['Elvorseal'] then
        meleeSet = set_combine(meleeSet, sets.PDI)
    end
        if  player.hpp <= 65 then
        meleeSet = set_combine(meleeSet,sets.defense.PDT)
    end
    return meleeSet
end

function dw_check()
    local item_sub_id = player.equipment.sub ~= 'empty' and gearswap.items[gearswap.to_windower_bag_api(gearswap.res.bags[gearswap.items.equipment.sub.bag_id].en)][gearswap.items.equipment.sub.slot].id
    local item_main_id = player.equipment.main ~= 'empty' and gearswap.items[gearswap.to_windower_bag_api(gearswap.res.bags[gearswap.items.equipment.main.bag_id].en)][gearswap.items.equipment.main.slot].id
    if item_sub_id and dw_skill_list:contains(gearswap.res.items[item_sub_id].skill or 0) then
        state.CombatForm:set('DW')
    elseif item_main_id and thand_skill_list:contains(gearswap.res.items[item_main_id].skill) then
        state.CombatForm:set('THand')
    else
        state.CombatForm:reset()
    end
end