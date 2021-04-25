-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    --res = require 'resources'
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    include('Mote-TreasureHunter')
    --state.SongMode = M{['description']='Song Mode', 'None', 'Placeholder'}
    --state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'MEva')

    --state.LullabyMode = M{['description']='Lullaby Instrument', 'Harp', 'Horn'}

    state.Carol = M{['description']='Carol',
        'Fire Carol', 'Fire Carol II', 'Ice Carol', 'Ice Carol II', 'Wind Carol', 'Wind Carol II',
        'Earth Carol', 'Earth Carol II', 'Lightning Carol', 'Lightning Carol II', 'Water Carol', 'Water Carol II',
        'Light Carol', 'Light Carol II', 'Dark Carol', 'Dark Carol II',
        }

    state.Threnody = M{['description']='Threnody',
        'Fire Threnody II', 'Ice Threnody II', 'Wind Threnody II', 'Earth Threnody II',
        'Ltng. Threnody II', 'Water Threnody II', 'Light Threnody II', 'Dark Threnody II',
        }

    state.Etude = M{['description']='Etude', 'Sinewy Etude', 'Herculean Etude', 'Learned Etude', 'Sage Etude',
        'Quick Etude', 'Swift Etude', 'Vivacious Etude', 'Vital Etude', 'Dextrous Etude', 'Uncanny Etude',
        'Spirited Etude', 'Logical Etude', 'Enchanting Etude', 'Bewitching Etude'}

    state.WeaponLock = M(false, 'Weapon Lock')

    -- Adjust this if using the Terpander Daurdabla (new +song instrument)
    --info.ExtraSongInstrument = 'Terpander'
    -- How many extra songs we can keep from Daurdabla/Terpander
    --info.ExtraSongs = 1

    on_job_change()

end


-- Called when this job file is unloaded (eg: job change)
function user_unload()

end


-- Define sets and vars used by this job file.
function init_gear_sets()
    
    sets.TreasureHunter = {
        ammo="Per. Lucky Egg",
        --head = gear.HercHTH,
        --body = gear.HercBTH, 
        --legs = gear.HercLTH,
        waist = "Chaac Belt",
    }
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast cast sets for spells
    sets.precast.FC = {
        main='Kali',
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
        --range={ name="Linos", augments={'All Songs+2','Song spellcasting time -6%','Singing skill +10',}},
        head="Fili Calot +1",
        legs = "Doyen Pants",
        feet = "Bihu Slippers +1",
    })

    sets.precast.FC['Honor March'] = set_combine(sets.precast.FC, {
        range="Marsyas",
        head="Fili Calot +1",
        legs = "Doyen Pants",
        feet = "Bihu Slippers +1",
    })

    --sets.precast.FC.SongPlaceholder = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})

    -- Precast sets to enhance JAs

    sets.precast.JA.Nightingale = {feet="Bihu Slippers +1"}
    --sets.precast.JA.Troubadour = {body="Bihu Jstcorps. +3"}
    --sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Ginsen",
        head="Aya. Zucchetto +1",
        body="Ayanmo Corazza +1",
        hands="Aya. Manopolas +1",
        legs="Aya. Cosciales +1",
        feet="Aya. Gambieras +1",
        neck="Clotharius Torque",
        waist="Shadow Belt",
        left_ear="Steelflash Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Begrudging Ring",
        right_ring="Ayanmo Ring",
        back="Atheling Mantle",
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- General set for recast times.
    sets.midcast.FastRecast = {}

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.BardSong = {
        main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
        range="Gjallarhorn",
        head="Fili Calot +1",
        body="Fili Hongreline",
        hands="Fili Manchettes +1",
        legs="Inyanga Shalwar +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
    }

    -- Gear to enhance certain classes of songs.
    --sets.midcast.Ballad = {legs="Fili Rhingrave +1"}
    --sets.midcast.Carol = {hands="Mousai Gages +1"}
    --sets.midcast.Etude = {head="Mousai Turban +1"}
    sets.midcast['Honor March'] = set_combine(sets.midcast.BardSong, {range="Marsyas", hands="Fili Manchettes +1"})
    sets.midcast.Lullaby = set_combine(sets.midcast.SongDebuff,{hands="Brioso Cuffs +2",body="Fili Hongreline"})
    sets.midcast.Madrigal = set_combine(sets.midcast.BardSong,{head="Fili Calot +1", back=gear.BrdCFC})
    sets.midcast.Mambo = set_combine(sets.midcast.BardSong,{feet="Mousai Crackows +1"})
    sets.midcast.March = set_combine(sets.midcast.BardSong,{hands="Fili Manchettes +1"})
    --sets.midcast.Minne = {legs="Mousai Seraweels"}
    sets.midcast.Minuet = set_combine(sets.midcast.BardSong,{body="Fili Hongreline"})
    sets.midcast.Paeon = set_combine(sets.midcast.BardSong,{head="Brioso Roundlet +2"})
    --sets.midcast.Threnody = sets.midcast.SongDebuff  --, {}) --{body="Mou. Manteel +1"}) -- GS does not see this set?

    --sets.midcast['Adventurer\'s Dirge'] = {hands="Bihu Cuffs +3"}
    --sets.midcast['Foe Sirvente'] = {head="Bihu Roundlet +3"}
    --sets.midcast['Magic Finale'] = {legs="Fili Rhingrave +1"}
    sets.midcast['Sentinel\'s Scherzo'] = {feet="Fili Cothurnes +1"}
    
    --3rd/4th/5th dummy song sets
    
    sets.midcast['Army\'s Paeon'] = {range="Terpander",}
    sets.midcast['Knight\'s Minne'] = {range="Terpander",}
    sets.midcast['Valor Minuet'] = {range="Terpander",}
    
    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongDebuff = {
        main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
        range="Gjallarhorn",
        head="Brioso Roundlet +2",
        body="Brioso Justau. +2",
        hands="Brioso Cuffs +2",
        legs="Brioso Cannions +2",
        feet="Brioso Slippers +3",
        neck="Mnbw. Whistle +1",
        waist="Famine Sash",
        left_ear="Hermetic Earring",
        left_ring="Kishar Ring",
        right_ring="Inyanga Ring",
        back = gear.BrdCFC,
    }
    -- For song defbuffs (accuracy primary, duration secondary)
    --sets.midcast.SongEnfeebleAcc = set_combine(sets.midcast.SongEnfeeble, {})

    -- Placeholder song; minimize duration to make it easy to overwrite.
    --sets.midcast.SongPlaceholder = set_combine(sets.midcast.SongEnhancing, {range=info.ExtraSongInstrument})

    -- Other general spells and classes.
    sets.midcast.Cure = {
        main="Daybreak",
        sub="Genmei Shield",
        head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
        body="Kaykaus Bliaut",
        hands="Inyan. Dastanas +1",
        legs="Brioso Cannions +2",
        feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
        neck="Loricate Torque",
        waist="Korin Obi",
        left_ring="Lebeche Ring",
        right_ring="Menelaus's Ring",
        back="Solemnity Cape",
    }

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.StatusRemoval = {}

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
        hands="Inyan. Dastanas +1",
        feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
        right_ring="Menelaus's Ring",
    })

    sets.midcast['Enhancing Magic'] = {
        waist="Embla Sash",
    }
    
    sets.midcast['Enfeebling Magic'] = {
        main="Daybreak",
        head="Brioso Roundlet +2",
        body="Brioso Justau. +2",
        hands="Inyan. Dastanas +1",
        legs="Inyanga Shalwar +2",
        feet="Inyan. Crackows +1",
        neck="Mnbw. Whistle +1",
        waist="Famine Sash",
        left_ear="Hermetic Earring",
        left_ring="Ayanmo Ring",
        right_ring="Kishar Ring",
        back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
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

    sets.midcast['Enfeebling Magic'] = {}

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        head="Aya. Zucchetto +1",
        body="Annoint. Kalasiris",
        hands="Aya. Manopolas +1",
        legs="Inyanga Shalwar +2",
        feet="Fili Cothurnes +1",
        neck="Loricate Torque",
        left_ring="Defending Ring",
        right_ring="Inyanga Ring",
        waist="Fucho-no-obi",
        back="Solemnity Cape",
    }

    sets.idle.DT = {
        head="Aya. Zucchetto +1",
        hands="Aya. Manopolas +1",
        neck="Loricate Torque",
        left_ring="Defending Ring",
        back="Solemnity Cape",
    }

    sets.idle.MEva = {}

    sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})
    
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        ammo="Ginsen",
        head="Aya. Zucchetto +1",
        body="Ayanmo Corazza +1",
        hands="Aya. Manopolas +1",
        legs="Aya. Cosciales +1",
        feet="Aya. Gambieras +1",
        neck="Clotharius Torque",
        waist="Dynamic Belt",
        left_ear="Steelflash Earring",
        right_ear="Bladeborn Earring",
        left_ring="Begrudging Ring",
        right_ring="Ayanmo Ring",
        back="Atheling Mantle",
    }

    --sets.engaged.Acc = set_combine(sets.engaged, {})

    sets.engaged.DW = set_combine(sets.engaged, {
        left_ear="Suppanomimi",
        right_ear="Eabani Earring",
    })

    --sets.buff.Doom = {}
    --sets.Obi = {}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    
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

--[[function job_post_midcast(spell, action, spellMap, eventArgs)
    
end

function job_aftercast(spell, action, spellMap, eventArgs)
    
end

function job_buff_change(buff,gain)

end]]

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    update_combat_form()
end

function job_update(cmdParams, eventArgs)
    
end

function update_combat_form()
    --checks for Single, Two Handed or Dual Weilding
    cf_check() -- function is defined in the Lystle-Globals.lua
end

-- Called for direct player commands.
--[[function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'etude' then
        send_command('@input /ma '..state.Etude.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'carol' then
        send_command('@input /ma '..state.Carol.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'threnody' then
        send_command('@input /ma '..state.Threnody.value..' <stnpc>')
    end    
end]]

-- Modify the default melee set after it was constructed.
--[[function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Carnwenhan" then
        meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
    end

    return meleeSet
end]]

-- Modify the default idle set after it was constructed.
--[[function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end]]

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
--[[function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end]]

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
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

--[[function get_lullaby_duration(spell)
    local self = windower.ffxi.get_player()

    local troubadour = false
    local clarioncall = false
    local soulvoice = false
    local marcato = false

    for i,v in pairs(self.buffs) do
        if v == 348 then troubadour = true end
        if v == 499 then clarioncall = true end
        if v == 52 then soulvoice = true end
        if v == 231 then marcato = true end
    end

    local mult = 1

    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
    if player.equipment.range == "Marsyas" then mult = mult + 0.5 end

    if player.equipment.main == "Carnwenhan" then mult = mult + 0.5 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.main == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
    if player.equipment.neck == "Mnbw. Whistle" then mult = mult + 0.2 end
    if player.equipment.neck == "Mnbw. Whistle +1" then mult = mult + 0.3 end
    if player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.12 end
    if player.equipment.legs == "Inyanga Shalwar +2 +1" then mult = mult + 0.15 end
    if player.equipment.legs == "Inyanga Shalwar +2 +2" then mult = mult + 0.17 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
    if player.equipment.feet == "Brioso Slippers +2" then mult = mult + 0.13 end
    if player.equipment.feet == "Brioso Slippers +3" then mult = mult + 0.15 end
    if player.equipment.hands == 'Brioso Cuffs +1' then mult = mult + 0.1 end
    if player.equipment.hands == 'Brioso Cuffs +3' then mult = mult + 0.1 end
    if player.equipment.hands == 'Brioso Cuffs +3' then mult = mult + 0.2 end

    --JP Duration Gift
    if self.job_points.brd.jp_spent >= 1200 then
        mult = mult + 0.05
    end

    if troubadour then
        mult = mult * 2
    end

    if spell.en == "Foe Lullaby II" or spell.en == "Horde Lullaby II" then
        base = 60
    elseif spell.en == "Foe Lullaby" or spell.en == "Horde Lullaby" then
        base = 30
    end

    totalDuration = math.floor(mult * base)

    -- Job Points Buff
    totalDuration = totalDuration + self.job_points.brd.lullaby_duration
    if troubadour then
        totalDuration = totalDuration + self.job_points.brd.lullaby_duration
        -- adding it a second time if Troubadour up
    end

    if clarioncall then
        if troubadour then
            totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2 * 2)
            -- Clarion Call gives 2 seconds per Job Point upgrade.  * 2 again for Troubadour
        else
            totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2)
            -- Clarion Call gives 2 seconds per Job Point upgrade.
        end
    end

    if marcato and not soulvoice then
        totalDuration = totalDuration + self.job_points.brd.marcato_effect
    end

    -- Create the custom timer
    if spell.english == "Foe Lullaby II" or spell.english == "Horde Lullaby II" then
        send_command('@timers c "Lullaby II ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00377.png')
    elseif spell.english == "Foe Lullaby" or spell.english == "Horde Lullaby" then
        send_command('@timers c "Lullaby ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00376.png')
    end
end]]

-- Select default macro book and lockstyle on initial load or subjob change.
function on_job_change()
    set_macro_page(1, 10)
    send_command('wait 5;input /lockstyleset 3')
end