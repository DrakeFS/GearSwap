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
    
    nukes = {}
    nukes.t1 = {['Stone']="Stone",      ['Water']="Water",      ['Aero']="Aero",     ['Fire']="Fire",    ['Blizzard']="Blizzard",     ['Thunder']="Thunder", ['Light']="Thunder", ['Dark']="Blizzard"}
    nukes.t2 = {['Stone']="Stone II",   ['Water']="Water II",   ['Aero']="Aero II",  ['Fire']="Fire II", ['Blizzard']="Blizzard II",  ['Thunder']="Thunder II", ['Light']="Thunder II", ['Dark']="Blizzard II"}
    nukes.t3 = {['Stone']="Stone III",  ['Water']="Water III",  ['Aero']="Aero III", ['Fire']="Fire III",['Blizzard']="Blizzard III", ['Thunder']="Thunder III", ['Light']="Thunder III", ['Dark']="Blizzard III"}
    nukes.t4 = {['Stone']="Stone IV",   ['Water']="Water IV",   ['Aero']="Aero IV",  ['Fire']="Fire IV", ['Blizzard']="Blizzard IV",  ['Thunder']="Thunder IV", ['Light']="Thunder IV", ['Dark']="Blizzard IV"}
    nukes.t5 = {['Stone']="Stone V",    ['Water']="Water V",    ['Aero']="Aero V",   ['Fire']="Fire V",  ['Blizzard']="Blizzard V",   ['Thunder']="Thunder V", ['Light']="Thunder V", ['Dark']="Blizzard V"}

    max_enhancing_skill = S{'Enfire', 'Enwater', 'Enthunder', 'Enstone', 'Enaero', 'Enblizzard', 'Temper', 'Temper II'}
    max_magic_accuracy  = S{'Frazzle II', 'Silence', 'Sleep', 'Sleep II', 'Sleepga', 'Sleepga II'}

    state.NukeElement = M{['description'] = 'Nuke Element'}
    state.NukeTier = M{['description'] = 'Nuke Tier'}
    state.MACC = M(false, 'MACC')
    state.MagicBurst = M(false, 'Burst')
    state.WeaponMode= M(false, 'Swap')

    on_job_change()

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Enspell')
    state.HybridMode:options('Normal')
    state.IdleMode:options('Normal', 'Leveling')
    state.NukeElement:options('Fire', 'Blizzard', 'Aero', 'Stone', 'Thunder', 'Water')
    state.NukeTier:options('t1', 't2', 't3', 't4', 't5')
    state.NukeTier:set('t5')
    
    send_command('bind ^q gs c toggle WeaponMode')
    send_command('bind !q gs c toggle MagicBurst')
    send_command('bind ^` gs c cycle NukeElement')
    send_command('bind ~^` gs c cycleback NukeElement')
    send_command('bind !` gs c cycle NukeTier')
    send_command('bind ~!` gs c cycleback NukeTier')
    send_command('bind @= gs c toggle MACC')

    update_combat_form()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    gear.RdmCTP = {name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}}
    gear.RdmCMB = {name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Mag. Evasion+15',}}
    gear.RdmCES = {name="Ghostfyre Cape", augments={'Enfb.mag. skill +6','Enha.mag. skill +10',}}
    gear.RdmCEnmity = {name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Enmity+10','Spell interruption rate down-10%',}}
            
    sets.TreasureHunter = {
        ammo="Per. Lucky Egg",
        head="Wh. Rarab Cap +1",
        waist="Chaac Belt",
    }
    
    sets.MACC = {
        range="Ullr",
        ammo=empty,
        head="Atrophy Chapeau +3",
    }

    sets.Enmity = {
        ammo="Paeapua",
        hands={ name="Merlinic Dastanas", augments={'Pet: Attack+10 Pet: Rng.Atk.+10','Blood Pact Dmg.+10',}},
        legs="Zoar Subligar +1",
        feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+18','DEX+2','Accuracy+15 Attack+15','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
        neck="Unmoving Collar +1",
        waist="Kasiri Belt",
        left_ear="Friomisi Earring",
        left_ring="Pernicious Ring",
        right_ring="Begrudging Ring",
        back=gear.RdmCEnmity,
    }
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body= {name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}}}
    
    -- Spells Fastcast 
    
    sets.precast.FC = {
        range=empty,
        ammo="Impatiens",
        head="Atrophy Chapeau +3",
        body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
        hands="Aya. Manopolas +2",
        legs={ name="Lengo Pants", augments={'INT+7','Mag. Acc.+7','"Mag.Atk.Bns."+3','"Refresh"+1',}},
        feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+18','DEX+2','Accuracy+15 Attack+15','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
        waist="Embla Sash",
        left_ear="Malignance Earring",
        right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}},
        left_ring="Kishar Ring",
    }

    sets.precast.FC['Impact'] = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak"})

    sets.precast.JA['Vallation'] = sets.Enmity
    sets.precast.JA['Valiance'] = sets.Enmity
    sets.precast.JA['Pflug'] = sets.Enmity
    sets.precast.JA['Swordplay'] = sets.Enmity


    -- Weaponskill sets
    
    sets.precast.WS = {
        ammo="Oshasha's Treatise",
        head="Jhakri Coronal +2",
        body="Ayanmo Corazza +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Leth. Houseaux +3",
        neck="Sanctity Necklace",
        waist="Windbuffet Belt +1",
        left_ear="Sherida Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Ayanmo Ring",
        right_ring="Rajas Ring",
        back=gear.RdmCTP,
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = {
        ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",
        body="Atrophy Tabard +3",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Malignance Earring",
        right_ear="Snotra Earring",
        left_ring="Petrov Ring",
        right_ring="Pernicious Ring",
        back=gear.RdmCMB,
    }

    sets.precast.WS['Seraph Blade'] = {
        ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Malignance Earring",
        right_ear="Novio Earring",
        left_ring="Ayanmo Ring",
        right_ring="Jhakri Ring",
        back=gear.RdmCMB,
    }
    
    sets.precast.WS['Sanguine Blade'] ={
        ammo="Regal Gem",
        head="Pixie Hairpin +1",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        neck="Sanctity Necklace",
        waist="Fotia Belt",
        left_ear="Malignance Earring",
        right_ear="Regal Earring",
        left_ring="Archon Ring",
        right_ring="Jhakri Ring",
        back=gear.RdmCMB,
    }
    
    sets.precast.WS['Red Lotus Blade'] = set_combine( sets.precast.WS['Seraph Blade'],{})
    sets.precast.WS['Black Halo'] = set_combine( sets.precast.WS['Seraph Blade'],{})
    sets.precast.WS['Aeolian Edge'] = set_combine( sets.precast.WS['Seraph Blade'],{})
    
    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
        ammo="Jukukik Feather",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Jhakri Cuffs +2",
        legs="Aya. Cosciales +2",
        feet="Battlecast Gaiters",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Sherida Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Petrov Ring",
        right_ring="Begrudging Ring",
    })

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Rajas Ring",
        right_ring="Apate Ring",
    })
    
    sets.precast.WS['Empyreal Arrow'] = {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Aya. Manopolas +2",
        legs="Carmine Cuisses +1",
        neck="Sanctity Necklace",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        right_ear="Suppanomimi",
        left_ring="Ilabrat Ring",
        right_ring="Beeline Ring",
    }

    -- Midcast Sets
    
    --sets.midcast.FastRecast = {}

    sets.midcast['Flash'] = set_combine(sets.Enmity, {
        head="Atrophy Chapeau +3",
        body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
        right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}},
    })

    sets.midcast.Cure = {
        head="Vitiation Chapeau +2",
        body= {name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
        hands="Jhakri Cuffs +2",
        legs="Atrophy Tights +2",
        feet="Leth. Houseaux +3",
        neck="Nodens Gorget",
        right_ear="Mendi. Earring",
        back="Solemnity Cape",
    }

    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
        neck= {name="Duelist's Torque", augments={'Path: A',}},
        body= {name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
        hands="Atrophy Gloves +3",
        legs="Atrophy Tights +2",
        feet="Leth. Houseaux +3",
        waist="Embla Sash",
        left_ear="Mimir Earring",
        right_ear={ name="Lethargy Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+6','Mag. Acc.+6',}},
        back = gear.RdmCMB,
    }

    sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.MaxSkill = set_combine(sets.midcast['Enhancing Magic'], {
        neck="Incanter's Torque",
        hands={ name="Viti. Gloves +3", augments={'Enhancing Magic duration',}},
        right_ear="Andoaa Earring",
        back = gear.RdmCES,
    })
        
    sets.midcast.Blink = sets.midcast.FastRecast
    
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {legs="Shedir Seraweels",})
     
    sets.midcast.Stoneskin =set_combine(sets.midcast['Enhancing Magic'], {legs="Shedir Seraweels",})

    sets.midcast.Haste = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Flurry = sets.midcast.Haste    
    sets.midcast.Firestorm = sets.midcast.Haste
    sets.midcast.Hailstorm = sets.midcast.Haste
    sets.midcast.Windstorm = sets.midcast.Haste
    sets.midcast.Sandstorm = sets.midcast.Haste
    sets.midcast.Thunderstorm = sets.midcast.Haste
    sets.midcast.Rainstorm = sets.midcast.Haste
    sets.midcast.Aurorastorm = sets.midcast.Haste
    sets.midcast.Voidstorm = sets.midcast.Haste
    sets.midcast["Haste II"] = sets.midcast.Haste
    sets.midcast["Flurry II"] = sets.midcast.Haste
    sets.midcast['Shock Spikes'] = sets.midcast.Haste
    sets.midcast['Blizzard Spikes'] = sets.midcast.Haste
    sets.midcast['Blaze Spikes'] = sets.midcast.Haste
    
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {body="Atrophy Tabard +3", legs="Leth. Fuseau +2",})
    sets.midcast['Refresh II'] = sets.midcast.Refresh
    sets.midcast['Refresh III'] = sets.midcast.Refresh
    sets.midcast['Regen II'] = sets.midcast.Refresh
    
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect
    
    sets.midcast['Barfire'] = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Barblizzard = sets.midcast.Barfire
    sets.midcast.Baraero = sets.midcast.Barfire
    sets.midcast.Barstone = sets.midcast.Barfire
    sets.midcast.Barthunder = sets.midcast.Barfire
    sets.midcast.Barwater = sets.midcast.Barfire
    sets.midcast.Barsleep = sets.midcast.Barfire
    sets.midcast.Barpoison = sets.midcast.Barfire
    sets.midcast.Barparalyze = sets.midcast.Barfire
    sets.midcast.Barblind = sets.midcast.Barfire
    sets.midcast.Barsilence = sets.midcast.Barfire
    sets.midcast.Baramnesia = sets.midcast.Barfire
    sets.midcast.Phalanx = sets.midcast.Barfire
    sets.midcast['Gain-STR'] = set_combine(sets.midcast['Enhancing Magic'], {hands={name="Viti. Gloves +3", augments={'Enhancing Magic duration',}}})
    sets.midcast['Gain-DEX'] = sets.midcast['Gain-STR']
    sets.midcast['Gain-VIT'] = sets.midcast['Gain-STR']
    sets.midcast['Gain-AGI'] = sets.midcast['Gain-STR']
    sets.midcast['Gain-MND'] = sets.midcast['Gain-STR']
    sets.midcast['Gain-CHR'] = sets.midcast['Gain-STR']
    sets.midcast['Gain-INT'] = sets.midcast['Gain-STR']
        
    sets.midcast['Enfeebling Magic'] = {
        ammo="Regal Gem",
        head={ name="Vitiation Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
        body="Atrophy Tabard +3",
        hands="Leth. Ganth. +2",
        legs="Jhakri Slops +2",
        feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
        neck={ name="Duelist's Torque", augments={'Path: A',}},
        waist={ name="Acuity Belt +1", augments={'Path: A',}},
        left_ear="Regal Earring",
        right_ear="Snotra Earring",
        left_ring="Kishar Ring",
        right_ring="Jhakri Ring",
        back = gear.RdmCMB,
    }
        
    sets.midcast['Dia III'] = {
        ammo="Regal Gem",
        head={ name="Vitiation Chapeau +2", augments={'Enfeebling Magic duration','Magic Accuracy',}},
        body="Lethargy Sayon +2",
        hands="Leth. Ganth. +2",
        legs="Jhakri Slops +2",
        feet={ name="Vitiation Boots +1", augments={'Immunobreak Chance',}},
        neck={ name="Duelist's Torque", augments={'Path: A',}},
        waist={ name="Acuity Belt +1", augments={'Path: A',}},
        left_ear="Malignance Earring",
        right_ear="Hermetic Earring",
        left_ring="Kishar Ring",
        right_ring="Jhakri Ring",
        back = gear.RdmCMB,
    }
        
    sets.midcast['Slow II'] = sets.midcast['Dia III']   
    sets.midcast['Paralyze II'] = sets.midcast['Dia III']
    sets.midcast['Distract III'] = sets.midcast['Dia III']
    sets.midcast['Frazzle III'] = sets.midcast['Dia III']
    sets.midcast['Dispel'] = set_combine(sets.midcast['Enfeebling Magic'], {neck={ name="Duelist's Torque", augments={'Path: A',}},})
    sets.midcast['Frazzle II'] = sets.midcast['Dia III']

    sets.midcast['Elemental Magic'] = {
        ammo="Pemphredo Tathlum",
        head="Leth. Chappel +2",
        body="Lethargy Sayon +2",
        hands="Leth. Ganth. +2",
        legs="Leth. Fuseau +2",
        feet="Leth. Houseaux +3",
        neck="Sanctity Necklace",
        waist={ name="Acuity Belt +1", augments={'Path: A',}},
        left_ear="Malignance Earring",
        right_ear="Hermetic Earring",
        left_ring="Ayanmo Ring",
        right_ring="Jhakri Ring",
        back = gear.RdmCMB,
    }

    sets.midcast['Elemental Magic'].ConserveMP = set_combine(sets.midcast['Elemental Magic'], {})

    sets.magic_burst = set_combine(sets.midcast['Elemental Magic'], {})

    sets.magic_burst.ConserveMP = set_combine(sets.midcast['Elemental Magic'], {}) 

    sets.midcast.Impact = set_combine(sets.midcast['Enfeebling Magic'], {head=empty, body="Twilight Cloak",})

    sets.midcast['Dark Magic'] = {}

    --sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast.Drain = {}

    sets.midcast.Aspir = sets.midcast.Drain
    
    sets.midcast.Klimaform = sets.midcast.FastRecast
    
    sets.midcast.Stone = {}
    

    -- Sets for special buff conditions on spells.

    
    sets.buff.ComposureOther = set_combine(sets.midcast['Enhancing Magic'], {
        head="Leth. Chappel +2",
        legs="Leth. Fuseau +2",
    })

    sets.buff.Saboteur = {hands="Leth. Ganth. +2"}
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    
    -- Idle sets
    sets.idle = {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Carmine Cuisses +1",
        feet="Nyame Sollerets",
        neck="Sanctity Necklace",
        left_ring="Defending Ring",
        right_ring="Vocane Ring",
        back=gear.RdmCTP,
    }
    
    sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})

    -- Defense sets
    sets.defense.PDT = {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Loricate Torque +1",
        waist="Windbuffet Belt +1",
        left_ring="Defending Ring",
        right_ring="Vocane Ring",
        back="Solemnity Cape",
    }

    sets.defense.MDT = set_combine(sets.defense.PDT, {})

    sets.Kiting = {legs="Carmine Cuisses +1"}

    sets.latent_refresh = {}

    --  sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        ammo="Coiste Bodhar",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +2",
        neck="Lissome Necklace",
        waist="Windbuffet Belt +1",
        left_ear="Crep. Earring",
        right_ear="Sherida Earring",
        left_ring="Pernicious Ring",
        right_ring="Petrov Ring",
        back=gear.RdmCTP,
    }

    sets.engaged.DW = set_combine(sets.engaged, {
        waist="Reiki Yotai",
        left_ear="Eabani Earring",
    })

    sets.engaged.DW.Enspell = {
        ammo="Paeapua",
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Aya. Manopolas +2",
        legs="Zoar Subligar +1",
        feet="Aya. Gambieras +2",
        neck="Clotharius Torque",
        waist="Reiki Yotai",
        left_ear="Eabani Earring",
        right_ear="Sherida Earring",
        left_ring="Petrov Ring",
        right_ring="Pernicious Ring",
        back=gear.RdmCES
    }

    sets.weapons = {}
    sets.weapons.Enfeebling = {main="Daybreak", sub="Ammurapi Shield"}
    sets.weapons.Enhancing = {main="Pukulatmuj +1", sub="Ammurapi Shield"}
    sets.weapons.Elemental = {main="Bunzi's Rod", sub="Ammurapi Shield"}
    sets.weapons.Cure = {main="Daybreak", sub="Sors Shield"}
    sets.weapons.Enfeebling.DW = {main="Daybreak", sub="Bunzi's Rod"}
    sets.weapons.Enhancing.DW = {main="Pukulatmuj +1", sub="Ammurapi Shield"}
    sets.weapons.Enhancing.DW.Temper = {main="Pukulatmuj +1", sub="Pukulatmuj"}
    sets.weapons.Elemental.DW = {main="Daybreak", sub="Bunzi's Rod"}
    sets.weapons.Cure.DW = {main="Daybreak", sub="Bunzi's Rod"}


end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific Gerswap command
-------------------------------------------------------------------------------------------------------------------

function job_update(cmdParams, eventArgs)
    update_combat_form()
end

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'nukeit' then
        handle_nuking()
    elseif cmdParams[1]:lower() == 'wsit' then
        handle_WS()
    end
end

function handle_WS()
    if player.equipment.main == "Vitiation Sword" then
        if player.tp <= 1500 then
            send_command('@input /ws "Sanguine Blade" <t>')
        else
            send_command('@input /ws "Seraph Blade" <t>')
        end
    elseif player.equipment.main == "Naegling" then
        send_command('@input /ws "Savage Blade" <t>')
    elseif player.equipment.main == "Maxentius" then
        send_command('@input /ws "Black Halo" <t>')
    elseif player.equipment.main == "Almace" then
        send_command('@input /ws "Chant du Cygne" <t>')
    else
        add_to_chat(122, "No WS set for this weapon")
    end    
end 

function handle_nuking()
    send_command('@input /ma "'..nukes[state.NukeTier.value][state.NukeElement.value]..'" <t>')
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_post_precast(spell, action, spellMap, eventArgs)

    local spell_recasts = windower.ffxi.get_spell_recasts()
    local element = state.NukeElement.value

    if spell.name:match(nukes.t1[element]) and spell_recasts[spell.recast_id] > 0 then
        cancel_spell()
        downgradenuke(spell)
        add_to_chat(8, '****** ['..spell.name..' CANCELED - Spell on Cooldown, Downgrading spell] ******')
        return
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.WeaponMode.value then
        
        mainhand = player.equipment.main
        offhand = player.equipment.sub

        if spell.skill == 'Enhancing Magic' then
            if state.CombatForm.value == 'DW' then
                if max_enhancing_skill:contains(spell.name) then
                    equip(sets.weapons.Enhancing.DW.Temper)
                else
                    equip(sets.weapons.Enhancing.DW)
                end
            else
                equip(sets.weapons.Enhancing)
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if state.CombatForm.value == 'DW' then
                equip(sets.weapons.Enfeebling.DW)
            else
                equip(sets.weapons.Enfeebling)
            end
        elseif spell.skill == 'Elemental Magic' then
            if state.CombatForm.value == 'DW' then
                equip(sets.weapons.Elemental.DW)
            else
                equip(sets.weapons.Elemental)
            end
        elseif spellMap == 'Cure' then
            if state.CombatForm.value == 'DW' then
                equip(sets.weapons.Cure.DW)
            else
                equip(sets.weapons.Cure)
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' then
        if buffactive['Saboteur'] then
            equip(sets.buff.Saboteur)
        elseif state.MACC.value and max_magic_accuracy:contains(spell.name) then 
            equip(sets.MACC)
        end
    elseif spell.skill == 'Enhancing Magic' then
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        elseif max_enhancing_skill:contains(spell.name) then
            equip(sets.midcast.MaxSkill)
        end
    elseif spellMap == 'Cure' then
        if spell.target.type == 'SELF' then
            equip(sets.midcast.CureSelf)
        else
            equip(sets.midcast.Cure)
        end
    elseif spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if state.WeaponMode.value then
        equip({main = mainhand, sub = offhand})
    end
end

function display_current_job_state(eventArgs)
    display_current_caster_state()

    local msg = ''
    if state.MACC.value then
        msg = msg ..'Max Magic Accuracy: On, '
    end
    if state.WeaponMode.value then
        msg = msg ..'Weapon swapping: On, '
    end
    if state.MagicBurst.value then
        msg = msg ..'Magic Burst: On, '
    end
    if state.TreasureMode.value ~= 'None' then
        msg = msg ..'Treasure Hunter: '..state.TreasureMode.value..', '
    end
    msg = msg ..'Current nuke element is '..state.NukeElement.value..' and initial Tier is '..state.NukeTier.index..'.'
    add_to_chat(121, msg)

    eventArgs.handled = true
end

function update_combat_form()    
    if cf_check then --checks if cf_check() exists
        cf_check() -- Check for 2H, Single or Duel Wield, function is defined in the Dagna-Globals.lua
    end
end

--------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- If the nuke casted is on cooldown, cast the next tier down of the same nuke.
function downgradenuke(spell)

    local element = state.NukeElement.value

    if spell.name:match(nukes.t1[element]) then   
        if spell.name == nukes.t5[element] then
            newspell = nukes.t4[element]
        elseif spell.name == nukes.t4[element] then
            newspell = nukes.t3[element]
        elseif spell.name == nukes.t3[element] then
            newspell = nukes.t2[element]
        elseif spell.name == nukes.t2[element] then
            newspell = nukes.t1[element]
        end
        send_command('@input /ma "'..newspell..'" <t>')
    end

end

-- Select default macro book on initial load or subjob change.
function on_job_change()
    set_macro_page(1, 5)
    send_command('wait 5;input /lockstyleset 17')
end