function define_global_sets()
    -- Head
    gear.HercHFC = {name="Herculean Helm", augments={'"Fast Cast"+4','Mag. Acc.+3',}}
    gear.HercHTH = {name="Herculean Helm", augments={'Phys. dmg. taken -1%','Weapon skill damage +3%','"Treasure Hunter"+1','Accuracy+20 Attack+20',}}
    gear.HercHMWS = {name="Herculean Helm", augments={'Weapon skill damage +2%','MND+14','Accuracy+9 Attack+9','Mag. Acc.+16 "Mag.Atk.Bns."+16',}}    
    -- Hands
    gear.HercGMB = {name="Herculean Gloves", augments={'VIT+15','"Mag.Atk.Bns."+24','Accuracy+6 Attack+6','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}
    gear.MerlGPBP = { name="Merlinic Dastanas", augments={'Pet: Attack+10 Pet: Rng.Atk.+10','Blood Pact Dmg.+10',}}
    gear.AdhGTP = { name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    -- Body
    gear.HercBTH = { name="Herculean Vest", augments={'Pet: INT+1','Accuracy+5','"Treasure Hunter"+1','Mag. Acc.+8 "Mag.Atk.Bns."+8',}}

    -- Legs
    --gear.HercLTH = {name="Herculean Trousers", augments={'Mag. Acc.+7','DEX+9','"Treasure Hunter"+1','Mag. Acc.+8 "Mag.Atk.Bns."+8',}}
    gear.HercLMB = { name="Herculean Trousers", augments={'Weapon skill damage +4%','Chance of successful block +2','Mag. Acc.+16 "Mag.Atk.Bns."+16',}}
    gear.SamTTP = { name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}}
    gear.LengoFC = {name="Lengo Pants", augments={'INT+7','Mag. Acc.+7','"Mag.Atk.Bns."+3','"Refresh"+1',}}
    gear.EnticeMBP = {name="Enticer's Pants", augments={'MP+50','Pet: Accuracy+15 Pet: Rng. Acc.+15','Pet: Mag. Acc.+15','Pet: Damage taken -5%',}}

    -- Boots
    gear.HercFTP = {name="Herculean Boots", augments={'DEX+9','"Triple Atk."+3','Accuracy+11 Attack+11',}}
    gear.MerlFFC = {name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+18','DEX+2','Accuracy+15 Attack+15','Mag. Acc.+15 "Mag.Atk.Bns."+15',}}

    -- Capes
    gear.CPCape = { name="Mecisto. Mantle", augments={'Cap. Point+45%','"Mag.Atk.Bns."+2','DEF+1',}}
    
    -- Override sets
    sets.reive = {neck="Ygnas's Resolve +1"}
    sets.DI = {feet="Heidrek Boots"}
    sets.CapacityMantle = {back=gear.CPCape}

    -- Global States
    state.CapacityMode = M(false, 'Capacity Point Mantle')
    
end

function global_on_load()
    dw_skill_list = S{2,3,5,11}
    thand_skill_list = S{4,6,7,8,10,12}
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
    send_command('bind ^= gs c cycle treasuremode')

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
    send_command('unbind ^=')
end

-- Global intercept on midcast.
function user_post_precast(spell, action, spellMap, eventArgs)
    if buffactive['Reive Mark'] and spell.type == 'WeaponSkill' then
        equip(sets.reive)
    end
    if buffactive['Elvorseal'] and spell.type == 'WeaponSkill' then
        equip(sets.DI)
    end
end

function user_customize_idle_set(idleSet)
    if buffactive['Reive Mark'] then
        idleSet = set_combine(idleSet, sets.reive)
    end
    if state.CapacityMode.value then
        idleSet = set_combine(idleSet, sets.CapacityMantle)
    end
    if  player.hpp <= 50 then
        idleSet = set_combine(idleSet,sets.defense.PDT)
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
        meleeSet = set_combine(meleeSet, sets.DI)
    end
    if  player.hpp <= 50 then
        meleeSet = set_combine(meleeSet, sets.defense.PDT)
    end
    return meleeSet
end

function cf_check()
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