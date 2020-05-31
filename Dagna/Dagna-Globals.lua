function define_global_sets()
	-- Capes
	gear.CPCape = {name="Mecisto. Mantle", augments={'Cap. Point+44%','INT+1','"Mag.Atk.Bns."+1','DEF+2',}}

	-- Head
	gear.HercHFC = {name="Herculean Helm", augments={'"Fast Cast"+4','Mag. Acc.+3',}}
	gear.HercFTH = {name="Herculean Helm", augments={'Phys. dmg. taken -1%','Weapon skill damage +3%','"Treasure Hunter"+1','Accuracy+20 Attack+20',}}
	
	-- Hands
	gear.HercGMB = {name="Herculean Gloves", augments={'VIT+15','"Mag.Atk.Bns."+24','Accuracy+6 Attack+6','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}

	-- Body
	gear.HercBTH = {name="Herculean Vest", augments={'Sklchn.dmg.+1%','"Cure" spellcasting time -5%','"Treasure Hunter"+1',}}

	-- Legs
	gear.HercLTH = {name="Herculean Trousers", augments={'Weapon skill damage +2%','Chance of successful block +1','"Treasure Hunter"+1','Mag. Acc.+16 "Mag.Atk.Bns."+16',}}
	gear.SamTTP = { name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}}
	gear.LengoFC = {name="Lengo Pants", augments={'INT+7','Mag. Acc.+7','"Mag.Atk.Bns."+3','"Refresh"+1',}}
	gear.EnticeMBP = {name="Enticer's Pants", augments={'MP+40','Pet: Mag. Acc.+9','Pet: Damage taken -2%',}}

	-- Boots
	gear.HercFTP = {name="Herculean Boots", augments={'DEX+9','"Triple Atk."+3','Accuracy+11 Attack+11',}}
	gear.MerlFFC = {name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+18','DEX+2','Accuracy+15 Attack+15','Mag. Acc.+15 "Mag.Atk.Bns."+15',}}

	-- JSE Capes

	gear.BluCTP = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}
	gear.BluCDEX = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
	gear.BluCSTR = {name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.BluCMB	= {name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
	gear.BluCMAC = {name="Cornflower Cape", augments={'MP+22','DEX+5','Blue Magic skill +10',}}
	gear.RdmCTP = {name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20',}}
	gear.RdmCMB = {name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Mag. Evasion+15',}}
	gear.DrgCTP = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
	gear.SmnCPHY = {name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20',}}
	
	-- Override sets
	sets.reive = {neck="Ygnas's Resolve +1"}
	sets.DI = {feet="Heidrek Boots"}
	sets.CapacityMantle = {back=gear.CPCape}

	-- Global States
	state.CapacityMode = M(false, 'Capacity Point Mantle')
	
end

function global_on_load()
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
    return meleeSet
end