function define_global_sets()
	-- Special
	gear.CPCape = { name="Mecisto. Mantle", augments={'Cap. Point+26%','Rng.Atk.+1','DEF+5',}}

	-- Head

	-- Hands
	
	-- Body

	-- Legs
	gear.HercLTH = {name="Herculean Trousers", augments={'MND+10','CHR+7','"Treasure Hunter"+2','Accuracy+6 Attack+6',}}

	-- Boots
	
	-- JSE Capes
	gear.ThfCTP = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	gear.WarCTP = {name="Cichol's Mantle", augments={'STR+20','Accuracy+11 Attack+11',}}
	gear.WhmCFC = {name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}
	gear.BrdCFC = {name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+5','"Fast Cast"+10',}}
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
	send_command('bind ^` gs c cycle SongMode')

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
	send_command('unbind ^`')

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
    return meleeSet
end