-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    include('Mote-TreasureHunter')
    state.WeaponSwapMode= M(true)
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    
    send_command('bind ^q gs c toggle WeaponSwapMode')

    on_job_change()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^q gs c toggle WeaponSwapMode')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    
    gear.BrdTPN = {name="Bard's Charm", augments={'Path: A',}}
    gear.BrdCFC = {name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}
    gear.BrdTPC = {name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    
    sets.TreasureHunter = {
        ammo="Per. Lucky Egg",
        waist = "Chaac Belt",
    }
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast cast sets for spells
    sets.precast.FC = {
        head="Nahtirah Hat",
        body="Inyanga Jubbah +2",
        hands={ name="Leyline Gloves", augments={'Accuracy+7','Mag. Acc.+5',}},
        legs="Kaykaus Tights",
        feet="Navon Crackows",
        waist="Embla Sash",
        left_ring="Lebeche Ring",
        right_ring="Kishar Ring",
        back = gear.BrdCFC,
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC['Dispelga'] = set_combine(sets.precast.FC, {main="Daybreak"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        legs = "Doyen Pants",
        feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
    })

    sets.precast.FC.BardSong = set_combine(sets.precast.FC, {
        head="Fili Calot +3",
        legs="Doyen Pants",
        feet="Bihu Slippers +1",
    })

    sets.precast.FC['Honor March'] = set_combine(sets.precast.BardSong, {
        range="Marsyas",
    })

    

    sets.precast.JA.Nightingale = {feet="Bihu Slippers +1"}
    --sets.precast.JA.Troubadour = {body="Bihu Jstcorps. +3"}
    --sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------


    sets.precast.WS = {
        ammo="Ginsen",
        head="Aya. Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Aya. Manopolas +1",
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +1",
        neck="Clotharius Torque",
        waist="Shadow Belt",
        left_ear="Steelflash Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Begrudging Ring",
        right_ring="Ayanmo Ring",
        back="Atheling Mantle",
    }

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- General set for recast times.
    sets.midcast.FastRecast = set_combine(sets.precast.FC ,{})

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.BardSong = {
        range="Gjallarhorn",
        head="Fili Calot +3",
        body="Fili Hongreline +2",
        hands="Fili Manchettes +3",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        waist="Cornelia's Belt",
        right_ring="Lehko's Ring",
        back = gear.BrdCFC,
    }

    -- Gear to enhance certain classes of songs.
    sets.midcast.Ballad = set_combine(sets.midcast.BardSong, {legs="Fili Rhingrave +2"})
    --sets.midcast.Carol = {hands="Mousai Gages +1"}
    --sets.midcast.Etude = {head="Mousai Turban +1"}
    sets.midcast['Honor March'] = set_combine(sets.midcast.BardSong, {range="Marsyas", hands="Fili Manchettes +3"})
    sets.midcast.Madrigal = set_combine(sets.midcast.BardSong,{head="Fili Calot +3", back=gear.BrdCFC})
    sets.midcast.Mambo = set_combine(sets.midcast.BardSong,{feet="Mousai Crackows +1"})
    sets.midcast.March = set_combine(sets.midcast.BardSong,{hands="Fili Manchettes +3"})
    --sets.midcast.Minne = {legs="Mousai Seraweels"}
    sets.midcast.Minuet = set_combine(sets.midcast.BardSong,{body="Fili Hongreline +2"})
    sets.midcast.Paeon = set_combine(sets.midcast.BardSong,{head="Brioso Roundlet +2"})


    --sets.midcast['Adventurer\'s Dirge'] = {hands="Bihu Cuffs +3"}
    --sets.midcast['Foe Sirvente'] = {head="Bihu Roundlet +3"}
    --sets.midcast['Magic Finale'] = {legs="Fili Rhingrave +1"}
    sets.midcast['Sentinel\'s Scherzo'] = {feet="Fili Cothurnes +2"}
    
    --3rd/4th/5th dummy song sets
    
    sets.midcast['Army\'s Paeon'] = {range="Daurdabla",}
    sets.midcast['Knight\'s Minne'] = {range="Daurdabla",}
    sets.midcast['Valor Minuet'] = {range="Daurdabla",}
    
    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongDebuff = {
        range="Gjallarhorn",
        head="Brioso Roundlet +2",
        body="Brioso Justau. +2",
        hands="Brioso Cuffs +2",
        legs="Brioso Cannions +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        waist="Famine Sash",
        left_ear="Hermetic Earring",
        right_ear="Crep. Earring",
        left_ring="Kishar Ring",
        right_ring="Ayanmo Ring",
        back = gear.BrdCFC,
    }
    sets.midcast['Horde Lullaby'] = set_combine(sets.midcast.SongDebuff,{
        range="Daurdabla", 
        body="Fili Hongreline +2", 
        legs="Inyanga Shalwar +2"
    })
    sets.midcast['Horde Lullaby II'] = set_combine( sets.midcast.SongDebuff ,{
        range="Daurdabla",
        hands="Fili Manchettes +3",
        legs="Inyanga Shalwar +2",
        left_ear="Gersemi Earring",
    })

    sets.midcast.Threnody = set_combine(sets.midcast.SongDebuf, {body="Mou. Manteel"}) 

    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.SongEnfeebleAcc = set_combine(sets.midcast.SongDebuff, {})

    -- Other general spells and classes.
    sets.midcast.Cure = {
        head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
        body="Kaykaus Bliaut",
        hands="Inyan. Dastanas +2",
        legs="Brioso Cannions +2",
        feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
        neck="Loricate Torque",
        waist="Korin Obi",
        left_ring="Lebeche Ring",
        right_ring="Menelaus's Ring",
        back="Solemnity Cape",
    }

    sets.midcast.Curaga = sets.midcast.Cure

    --sets.midcast.StatusRemoval = {}

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
        hands="Inyan. Dastanas +2",
        feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
        right_ring="Menelaus's Ring",
    })

    sets.midcast['Enhancing Magic'] = {
        waist="Embla Sash",
    }
    
    sets.midcast['Enfeebling Magic'] = {
        head="Brioso Roundlet +2",
        body="Brioso Justau. +2",
        hands="Inyan. Dastanas +2",
        legs="Inyanga Shalwar +2",
        feet="Inyan. Crackows +1",
        neck="Mnbw. Whistle +1",
        waist="Famine Sash",
        left_ear="Hermetic Earring",
        left_ring="Ayanmo Ring",
        right_ring="Kishar Ring",
        back = gear.BrdCFC,
    }

    sets.midcast['Displega'] = set_combine(sets.midcast['Enfeebling Magic'], {main="Daybreak"})

    --[[sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head="Inyanga Tiara"})
    sets.midcast.Haste = sets.midcast['Enhancing Magic']
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {waist="Gishdubar Sash", back="Grapevine Cape"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget", waist="Siegel Sash"})
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {waist="Emphatikos Rope"})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell]]
   
    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        head="Fili Calot +3",
        body="Annoint. Kalasiris",
        hands="Fili Manchettes +3",
        legs="Aya. Cosciales +2",
        feet="Fili Cothurnes +2",
        neck="Loricate Torque",
        left_ring="Defending Ring",
        right_ring="Inyanga Ring",
        waist="Fucho-no-obi",
        back="Solemnity Cape",
    }

    sets.idle.DT = set_combine(sets.idle, {})

    sets.idle.MEva = {}

    sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})
    
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    sets.engaged = {
        ammo="Coiste Bodhar",
        head="Aya. Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Bunzi's Gloves",
        legs="Volte Tights",
        feet="Aya. Gambieras +1",
        neck=gear.BrdTPN,
        waist="Dynamic Belt",
        left_ear="Crep. Earring",
        right_ear="Brutal Earring",
        left_ring="Rajas Ring",
        right_ring="Begrudging Ring",
        back=gear.BrdTPC,
    }

    --sets.engaged.Acc = set_combine(sets.engaged, {})

    sets.engaged.DW = set_combine(sets.engaged, {
        waist="Shetal Stone",
        left_ear="Suppanomimi",
    })
    
    sets.weapons = {}
    sets.weapons.FC = {main='Kali'}
    sets.weapons.BardSong = {main='Kali'}
    sets.weapons.BardSong.DW = {main='Kali', sub='Tauret'}
    sets.weapons.Healing = {main='Daybreak'}
    sets.weapons.Healing.DW = {main='Daybreak', sub='Kali'}
    sets.weapons.Enhancing = {main='Kali'}
    sets.weapons.Enhancing.DW = {main='Kali'}
    sets.weapons.Enfeebling = {main='Tauret'}
    sets.weapons.Enfeebling.DW = {main='Tauret', sub='Daybreak'}
    sets.weapons.Dispelga = {main='Daybreak'}
    sets.weapons.Dispelga.DW = {main='Daybreak', sub='Tauret'}
    sets.weapons.Dispelga.FC = {}
    sets.weapons.Dispelga.FC.DW = {main='Daybreak', sub='Kali'}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if state.WeaponSwapMode.value then
        
        mainhand = player.equipment.main
        offhand = player.equipment.sub
        if state.CombatForm.value == 'DW' then
            if spell.type == "BardSong" then
                equip(sets.weapons.FC)
            elseif spellMap == "Cure" then
                equip(sets.weapons.FC)
            elseif spell.skill == "Enhancing Magic" then
                equip(sets.weapons.FC)
            elseif spell.name == 'Dispelga' then
                equip(sets.weapons.Dispelga.FC.DW)
            elseif spell.skill == "Enfeebling Magic" then
                equip(sets.weapons.FC)
            end
        else
            if spell.type == "BardSong" then
                equip(sets.weapons.FC)
            elseif spellMap == "Cure" then
                equip(sets.weapons.FC)
            elseif spell.skill == "Enhancing Magic" then
                equip(sets.weapons.FC)
            elseif spell.name == 'Dispelga' then
                equip(sets.weapons.Dispelga)
            elseif spell.skill == "Enfeebling Magic" then
                equip(sets.weapons.FC)
            end
        end
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.WeaponSwapMode.value then
        if state.CombatForm.value == 'DW' then
            if spell.type == "BardSong" then
                equip(sets.weapons.BardSong.DW)
            elseif spellMap == "Cure" then
                equip(sets.weapons.Healing.DW)
            elseif spell.skill == "Enhancing Magic" then
                equip(sets.weapons.Enhancing.DW)
            elseif spell.name == 'Dispelga' then
                equip(sets.weapons.Dispelga.DW)
            elseif spell.skill == "Enfeebling Magic" then
                equip(sets.weapons.Enfeebling.DW)
            end
        else
            if spell.type == "BardSong" then
                equip(sets.weapons.BardSong)
            elseif spellMap == "Cure" then
                equip(sets.weapons.Healing)
            elseif spell.skill == "Enhancing Magic" then
                equip(sets.weapons.Enhancing)
            elseif spell.name == 'Dispelga' then
                equip(sets.weapons.Dispelga)
            elseif spell.skill == "Enfeebling Magic" then
                equip(sets.weapons.Enfeebling)
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        -- layer general gear on first, then let default handler add song-specific gear.
        local generalClass = get_song_class(spell)
        if generalClass and sets.midcast[generalClass] and not spell.name:contains("Lullaby") then
            equip(sets.midcast[generalClass])
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if state.WeaponSwapMode.value then
        equip({main = mainhand, sub = offhand})
    end
end

function job_update(cmdParams, eventArgs)
    update_combat_form()
end

function update_combat_form()
    if cf_check then --checks if cf_check() exists
        cf_check() -- Check for 2H, Single or Duel Wield, function is defined in the Dagna-Globals.lua
    end 
end

function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'SongEnfeebleAcc'
        else
            return 'SongDebuff'
        end
    else
        return 'SongEnhancing'
    end
end


function on_job_change()
    set_macro_page(1, 10)
    send_command('wait 5;input /lockstyleset 3')
end