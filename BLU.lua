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
    include('Mote-TreasureHunter')

    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    --state.Buff.Convergence = buffactive.Convergence or false
    --state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false

    state.EvasionMode = M(false)
   
    state.delayMod = M{'none', 'Samba'}
    state.delayMod:set('none')
    state.test = M(false)

    setup_blue_magic() --setup mappings for blue magic
    EVASpells = S{'Dream Flower','Sheep Song','Yawn','Magic Fruit','Occultation'}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'HP', 'SB')
    state.WeaponskillMode:options('Normal', 'PDL')
    state.CastingMode:options('Normal', 'Resistant')
    state.TreasureMode:set('Tag')

    on_job_change()
    
    send_command('bind @= gs c cycle delayMod')
    send_command('bind @` gs c toggle EvasionMode')
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind @= gs c cycle delayMod')
    send_command('unbind @` gs c toggle EvasionMode')
end


-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    gear.BluEMAC = {name="Hashishin Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+7','Mag. Acc.+7',}}
    gear.BluCTP = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}
    gear.BluCDEX = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
    gear.BluCSTR = {name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    gear.BluCMB = {name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
    gear.BluCMAC = {name="Cornflower Cape", augments={'MP+22','DEX+5','Blue Magic skill +10',}}
    gear.BluCEVA = {name="Rosmerta's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Evasion+15',}}

    sets.TreasureHunter = {
        ammo="Per. Lucky Egg",
        legs = gear.HercLTH,
        waist = "Chaac Belt",
    }
    
    sets.Kiting  = {legs="Carmine Cuisses +1",}
    
    --sets.buff['Burst Affinity'] = {}
    sets.buff['Chain Affinity'] = {body="Luhlaza Jubbah"}
    --sets.buff.Convergence = {}
    --sets.buff.Diffusion = {feet="Luhlaza Charuqs +3"}
    sets.buff.Enchainment = {body="Luhlaza Jubbah"}
    sets.buff.Efflux = {legs='Hashishin Tayt +3'}

    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Diffusion'] = {feet="Luhlaza Charuqs +3"}


    -- Waltz set (chr and vit)
    --sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    --sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        ammo="Impatiens",
        head = gear.HercHTH,
        body="Hashishin Mintan +3",
        hands={ name="Leyline Gloves", augments={'Accuracy+7','"Mag.Atk.Bns."+10',}},
        legs="Aya. Cosciales +2",
        feet="Jhakri Pigaches +2",
        left_ring="Jhakri Ring",
        right_ring="Kishar Ring"
    }

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Oshasha's Treatise",
        head="Hashishin Kavuk +3",
        body="Assim. Jubbah +3",
        hands="Jhakri Cuffs +2",
        legs={ name="Luhlaza Shalwar +3", augments={'Enhances "Assimilation" effect',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck={ name="Mirage Stole +2", augments={'Path: A',}},
        waist="Fotia Belt",
        left_ear="Ishvara Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Epaminondas's Ring",
        right_ring="Cornelia's Ring",
        back=gear.BluCSTR
    }
    
   -- sets.precast.WS.acc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        feet="Aya. Gambieras +2",
        neck="Fotia Gorget",
        left_ear="Odr Earring",
        right_ring="Ayanmo Ring"
    })

    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
        ammo="Oshasha's Treatise",
        head="Pixie Hairpin +1",
        body="Hashishin Mintan +3",
        hands="Hashi. Bazu. +3",
        legs={ name="Luhlaza Shalwar +3", augments={'Enhances "Assimilation" effect',}},
        feet="Hashi. Basmak +3",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Regal Earring",
        right_ear="Friomisi Earring",
        left_ring="Cornelia's Ring",
        right_ring="Archon Ring",
        back=gear.BluCMB
    })
    
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        waist="Sailfi Belt +1",
    })
    
    sets.precast.WS['Savage Blade'].PDL = set_combine(sets.precast.WS, {
        hands="Gleti's Gauntlets",
        feet="Gleti's Boots"
    })
    
    sets.precast.WS['Expiacion'] = sets.precast.WS['Savage Blade']

    sets.precast.WS['Expiacion'].PDL = set_combine(sets.precast.WS['Savage Blade'], {
        hands="Gleti's Gauntlets",
        feet="Gleti's Boots"
    })

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
        ammo="Falcon Eye",
        head = gear.AdhHTP,
        body="Abnoba Kaftan",
        hands="Gleti's Gauntlets",
        legs="Gleti's Breeches",
        feet="Gleti's Boots",
        left_ear="Cessance Earring",
        right_ear="Odr Earring",
        back=gear.BluCDEX
    })

    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS['Savage Blade'], {
        neck="Fotia Gorget",
        waist="Fotia Belt"
    })

    sets.precast.WS['Black Halo'].PDL = set_combine(sets.precast.WS['Black Halo'], {
        hands="Gleti's Gauntlets",
        feet="Gleti's Boots"
    })

    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS['Sanguine Blade'], {
        right_ring="Jhakri Ring"
    })

    sets.precast.WS["Realmrazer"] = set_combine(sets.precast.WS, {
        body="Hashishin Mintan +3",
        hands="Hashi. Bazu. +3",
        legs="Hashishin Tayt +3",
        feet="Hashi. Basmak +3",
        neck="Fotia Gorget",
        right_ear="Regal Earring",
    })

    -- Midcast Sets
    sets.midcast.FastRecast = {}
    
    sets.midcast['Blue Magic'] = {}
    
    -- Physical Spells --
    
    sets.midcast['Blue Magic'].Physical = {
        ammo="Amar Cluster",
        head="Hashishin Kavuk +3",
        body="Hashishin Mintan +3",
        hands="Hashi. Bazu. +3",
        legs="Hashishin Tayt +3",
        feet={ name="Luhlaza Charuqs +3", augments={'Enhances "Diffusion" effect',}},
        neck={ name="Mirage Stole +2", augments={'Path: A',}},
        waist="Anguinus Belt",
        left_ear="Crep. Earring",
        right_ear={ name="Hashishin Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+7','Mag. Acc.+7',}},
        left_ring="Ilabrat Ring",
        right_ring="Apate Ring",
        back=gear.BluCSTR
    }

    sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical, {})


    -- Magical Spells --
    
    sets.midcast['Blue Magic'].Magical = {
        ammo="Pemphredo Tathlum",
        head="Hashishin Kavuk +3",
        body="Hashishin Mintan +3",
        hands="Hashi. Bazu. +3",
        legs={ name="Luhlaza Shalwar +3", augments={'Enhances "Assimilation" effect',}},
        feet="Hashi. Basmak +3",
        neck="Sibyl Scarf",
        waist={ name="Acuity Belt +1", augments={'Path: A',}},
        left_ear="Regal Earring",
        right_ear="Friomisi Earring",
        left_ring="Jhakri Ring",
        right_ring="Kishar Ring",
        back=gear.BluCMB
    }

    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical, {})
    
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {})

    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {})
    
    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})

    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {})

    sets.midcast['Blue Magic'].MagicAccuracy = {
        ammo="Pemphredo Tathlum",
        head="Assim. Keffiyeh +3",
        body="Hashishin Mintan +3",
        hands="Hashi. Bazu. +3",
        legs="Hashishin Tayt +3",
        feet="Hashi. Basmak +3",
        neck={ name="Mirage Stole +2", augments={'Path: A',}},
        waist={ name="Acuity Belt +1", augments={'Path: A',}},
        left_ear="Njordr Earring",
        right_ear=gear.BluEMAC,
        left_ring="Crepuscular Ring",
        right_ring="Ayanmo Ring",
        back=gear.BluCMAC
    }

    -- Breath Spells --
    sets.midcast['Blue Magic']['Regurgitation']=sets.midcast['Blue Magic'].MagicAccuracy
    sets.midcast['Blue Magic'].Breath = set_combine(sets.midcast['Blue Magic'].Magical, {
        head="Luh. Keffiyeh +1"
    })
    -- Other Types --
    
    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})

    sets.midcast['Blue Magic']['White Wind'] = {}
    
    sets.midcast['Blue Magic']['Reaving Wind'] = set_combine(sets.midcast['Blue Magic'].Magical, sets.precast.FC)
    
    sets.midcast['Blue Magic']['Feather Tickle'] = set_combine(sets.midcast['Blue Magic'].Magical, sets.precast.FC)

    sets.midcast['Blue Magic'].Healing = {
        ammo="Impatiens",
        head="Hashishin Kavuk +3",
        body="Vrikodara Jupon",
        hands={ name="Telchine Gloves", augments={'Potency of "Cure" effect received+5%',}},
        legs="Hashishin Tayt +3",
        feet="Hashi. Basmak +3",
        neck="Incanter's Torque",
        waist="Gishdubar Sash",
        left_ear="Mendi. Earring",
        right_ear="Regal Earring",
        left_ring="Kunaji Ring",
        back="Solemnity Cape",
    }

    sets.midcast['Blue Magic'].SkillBasedBuff = {
        ammo="Mavi Tathlum",
        head={ name="Luh. Keffiyeh +1", augments={'Enhances "Convergence" effect',}},
        body="Assim. Jubbah +3",
        hands="Rawhide Gloves",
        legs="Hashishin Tayt +3",
        feet={ name="Luhlaza Charuqs +3", augments={'Enhances "Diffusion" effect',}},
        neck={ name="Mirage Stole +2", augments={'Path: A',}},
        left_ear={ name="Hashishin Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+7','Mag. Acc.+7',}},
        right_ear="Njordr Earring",
        back=gear.BluCMAC
    }

    sets.midcast['Blue Magic'].Buff = {}
    
    sets.midcast['Tenebral Crush'] = set_combine(sets.midcast['Blue Magic'].Magical,{
        head = "Pixie Hairpin +1",
        right_ring="Archon Ring"
    })
    
    sets.midcast.Protect = {}
    sets.midcast.Protectra = {}
    sets.midcast.Shell = {}
    sets.midcast.Shellra = {}
    
    

    
    
    -- Sets to return to when not performing an action.

    -- Gear for learning spells: +skill and AF hands.
    --[[sets.Learning = {
        ammo="Mavi Tathlum",
        --head="Luh. Keffiyeh +1",  
        body="Assim. Jubbah +3",
        hands="Assimilator's Bazubands +2",
        legs="Hashishin Tayt +3",
        feet="Luhlaza Charuqs +3",
        neck="Mirage Stole +2",
        back="Cornflower Cape"
    }]]

    sets.Subtle = {
        neck="Bathy Choker +1",
        head={ name="Dampening Tam", augments={'DEX+6','Mag. Acc.+13',}},
        left_ring="Beeline Ring",
        right_ring="Rajas Ring"
    }

    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
    sets.idle = {
        head="Malignance Chapeau",
        body="Hashishin Mintan +3",
        hands="Malignance Gloves",
        legs="Carmine Cuisses +1",
        feet="Nyame Sollerets",
        neck="Sanctity Necklace",
        left_ring="Defending Ring",
        right_ring="Vocane Ring",
        back=gear.BluCTP
    }

    sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})

    -- Defense sets
    sets.defense.PDT = {    
        ammo="Crepuscular Pebble",
        head="Malignance Chapeau",
        body="Hashishin Mintan +3",
        hands="Malignance Gloves",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Loricate Torque +1",
        waist="Plat. Mog. Belt",
        left_ring="Defending Ring",
        right_ring="Vocane Ring",
        back=gear.BluCTP
    }

    sets.defense.MDT = set_combine(sets.defense.PDT, {})

    sets.Kiting = {legs="Carmine Cuisses +1"}

    sets.Evasion = {
        ammo="Amar Cluster",
        head="Nyame Helm",
        body="Nyame Mail",
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck={ name="Bathy Choker +1", augments={'Path: A',}},
        waist="Kasiri Belt",
        left_ear="Eabani Earring",
        right_ear="Infused Earring",
        left_ring="Defending Ring",
        right_ring="Vocane Ring",
        back=gear.BluCEVA
    }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        ammo="Coiste Bodhar",
        head=gear.AdhHTP,
        body="Malignance Tabard",
        hands=gear.AdhGTP,
        legs=gear.SamTTP,
        feet=gear.HercFTP,
        neck="Mirage Stole +2", 
        waist="Windbuffet Belt +1",
        left_ear="Cessance Earring",
        right_ear="Crep. Earring",
        left_ring="Pernicious Ring",
        right_ring="Petrov Ring",
        back=gear.BluCTP
    }

    sets.engaged.TizAM3 = set_combine(sets.emgaged, {
        head="Malignance Chapeau",
    })

    sets.engaged.HP = set_combine(sets.engaged, {
        left_ear="Odnowa Earring +1",
        right_ear="Odnowa Earring",
        back="Xucau Mantle"
    })

    sets.engaged.Acc = set_combine(sets.engaged, {
        ammo="Falcon Eye",
        legs="Hashishin Tayt +3",
        feet="Aya. Gambieras +2",
        waist="Hurch'lan Sash",
        left_ear="Odr Earring",
        right_ear="Crep. Earring",
        left_ring="Cacoethic Ring",
        right_ring="Ilabrat Ring"
    })

    sets.engaged.SB = set_combine(sets.engaged, sets.Subtle)

    --sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
    
    sets.engaged.DW = set_combine(sets.engaged, {
        waist="Reiki Yotai",
        right_ear="Eabani Earring"
    })

    sets.engaged.DW.TizAM3 = set_combine(sets.engaged, {
        waist="Reiki Yotai",
        right_ear="Eabani Earring",
        head="Malignance Chapeau",
        left_ear="Crep. Earring"
    })

    sets.engaged.DW.HP = set_combine(sets.engaged.DW, {
        left_ear="Odnowa Earring +1",
        right_ear="Odnowa Earring",
        back="Xucau Mantle"
    })

    sets.engaged.DW.MaxHaste = set_combine(sets.engaged.DW, {})
    
    sets.engaged.DW.HighHaste = set_combine(sets.engaged.DW, {})

    sets.engaged.DW.HighHaste.TizAM3 = set_combine(sets.engaged.DW, {
        head="Malignance Chapeau",
        left_ear="Crep. Earring"
    })

    
    sets.engaged.DW.MidHaste = set_combine(sets.engaged.DW.HighHaste, {
        right_ear="Suppanomimi"
    })
    
    sets.engaged.DW.LowHaste = set_combine(sets.engaged.DW.MidHaste, {})

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
        ammo="Falcon Eye",
        head="Hashishin Kavuk +3",
        hands=gear.AdhGTP,
        legs="Hashishin Tayt +3",
        feet="Hashi. Basmak +3",
        right_ear="Odr Earring",
        left_ring="Cacoethic Ring",
        right_ring="Ilabrat Ring"
    })
    
    sets.engaged.DW.SB = set_combine(sets.engaged.DW, sets.Subtle)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'ws' then
        handle_WS()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'test' then
        test()
    end
end

function test()
    add_to_chat(123, ''..world.area..'')
end

function handle_WS()
    if player.equipment.main == "Tizona" then
        send_command('@input /ws "Expiacion" <t>')
    elseif player.equipment.main == "Naegling" then
        send_command('@input /ws "Savage Blade" <t>')
    elseif player.equipment.main == "Maxentius" then
        send_command('@input /ws "Black Halo" <t>')
    elseif player.equipment.main == "Almace" then
        send_command('@input /ws "Chant du Cygne" <t>')
    elseif player.equipment.main == "Caliburnus" then
        send_command('@input /ws "Imperator" <t>')
    else
        add_to_chat(122, "No WS set for this weapon")
    end    
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if state.EvasionMode.value then
        equip(sets.Evasion)
    end
end

function job_midcast(spell, action, spellMap, eventArgs, midcastSet)
    if blue_magic_maps.SkillBasedBuff:contains(spell.name) then
        equip(sets.midcast['Blue Magic'].SkillBasedBuff)
    end
end
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs, midcastSet)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end

    if buffactive['Diffusion'] and blue_magic_maps.AllBuffs:contains(spell.english) then
        equip(sets.precast.JA['Diffusion'])
    end    

    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end
    
    if state.TreasureMode.value == 'Tag' then
        if spell.english == 'Sound Blast' or spell.english == 'Whirl of Rage' or spell.english == 'Embalming Earth' then
            equip(sets.TreasureHunter)
        end
    end

    --[[if state.EvasionMode.value and (spell.name == 'Dream Flower' or spell.name == 'Sheep Song' or spell.name == 'Yawn' or spell.name == 'Magic Fruit') then
        equip(sets.Evasion)
    end]]

    if state.EvasionMode.value and EVASpells:contains(spell.name) then
        equip(sets.Evasion)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if player.status == 'Engaged' then
        check_TizAM3()
    end
end

function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        check_TizAM3()
    end
end

function check_TizAM3()
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == 'Tizona' then
        classes.CustomMeleeGroups:append('TizAM3')
    else
        classes.CustomMeleeGroups:clear()
        if cf_check then --checks if cf_check() exists
            cf_check() -- Check for 2H, Single or Duel Wield, function is defined in the Dagna-Globals.lua
        end 
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        state.Buff[buff] = gain
    elseif state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
    if buff =='Aftermath: Lv.3' then
        check_TizAM3()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.EvasionMode.value and not (player.equipment.right_ring == "Warp ring" or player.equipment.left_ring == "Warp ring") then
        idleSet = set_combine(idleSet, sets.Evasion)
    end

    return idleSet
end

function customize_melee_set(meleeSet)
    if state.EvasionMode.value and not (player.equipment.right_ring == "Warp ring" or player.equipment.left_ring == "Warp ring") then
        meleeSet = set_combine(meleeSet, sets.Evasion)
    end

    return meleeSet
end
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    determine_haste_group()
    handle_equipping_gear()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if cf_check then --checks if cf_check() exists
        cf_check() -- Check for 2H, Single or Duel Wield, function is defined in the Dagna-Globals.lua
    end 
end

-- Set a Haste Group
function determine_haste_group()
    if buffactive['Haste Samba'] or state.delayMod.Value ~= 'none' then
        hasteSamba = true
    else
        hasteSamba = false
    end
    -- Low haste DW required: 
    -- DW6: 19%
    -- DW5: 21%
    -- DW4: 26%
    -- DW3: 31%
    
    --Mid Haste DW required:
    -- DW6: 13% 
    -- DW5: 15%
    -- DW4: 20%
    -- DW3: 25%
    
    --High Haste DW required:
    -- DW6: -1% (potential minor TP loss if barely above a TP\Delay threshold)
    -- DW5: 1%
    -- DW4: 6%
    -- DW3: 11%
    
    -- Max haste DW Required:
    -- DW3 -1% (potential minor TP loss if barely above a TP\Delay threshold)
    -- DW2 9% (Sub Dancer only, no DW trait set)
    
    -- Sets assume DW3
    
    classes.CustomMeleeGroups:clear()
    
    if (buffactive.haste and hasteSamba and buffactive.march == 1) 
    or (buffactive.march == 2 and hasteSamba) 
    or (buffactive.embrava and (buffactive.haste or buffactive.march) and hasteSamba) 
    or (buffactive['Mighty Guard'] and buffactive.haset and hasteSamba) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif (buffactive.haste and buffactive.march) or (buffactive.march == 2) then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.haste and hasteSamba then
        classes.CustomMeleeGroups:append('MidHaste')
    elseif buffactive.haste then
        classes.CustomMeleeGroups:append('LowHaste')
    end
end

function display_current_job_state(eventArgs)
    if state.EvasionMode.value then
        add_to_chat(121, "Evasion Mode is On")
    end
end

    -- Select default macro book on initial load or subjob change.

function on_job_change()
    set_macro_page(1, 16)
    send_command('wait 5;input /lockstyleset 20')
end
    
function setup_blue_magic()

    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.

    blue_magic_maps = {}
    
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm'
    }

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike',
    }

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Uppercut','Vertical Cleave'
    }
        
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive'
    }
        
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
    }
        
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray',
        'Diffusion Ray','Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
        'Ice Break','Leafstorm','Maelstrom','Rail Cannon','Regurgitation','Rending Deluge',
        'Retinal Glare','Subduction','Spectral Floe','Tem. Upheaval','Water Bomb','Tenebral Crush'
    }

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light'
    }

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{
        'Thermal Pulse'
    }

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Charged Whisker','Gates of Hades'
    }
            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn','Cruel Joke','Entomb'
    }
        
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }

    -- Stun spells
    blue_magic_maps.Stun = S{
        'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'
    }
        
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'
    }
    
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Plasma Charge',
        'Pyric Bulwark','Reactor Cool','Occultation'
    }

    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Harden Shell',
        'Memento Mori','Nat. Meditation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Winds of Promyvion',
        'Zephyr Mantle','Feather Barrier','Warm-Up'
    }
    
    
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
        'Crashing Thunder','Droning Whirlwind','Gates of Hades','Harden Shell','Polar Roar',
        'Pyric Bulwark','Thunderbolt','Tourbillion','Uproot','Mighty Guard','Cruel Joke'
    }
    blue_magic_maps.AllBuffs = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Memento Mori','Nat. Meditation','Occultation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Zephyr Mantle','Barrier Tusk',
        'Diamondhide','Magic Barrier','Metallic Body','Plasma Charge','Pyric Bulwark','Reactor Cool','Mighty Guard'
    }
end