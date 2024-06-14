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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
    state.WeaponMode = M(true)
    WHMspellMap()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    send_command('bind ^q gs c toggle WeaponMode')

    select_default_macro_book()
    lockstyleset()
end

function user_unload()
    send_command('unbind ^q gs c toggle WeaponMode')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    gear.WhmCFC = {name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Damage taken-5%',}}
    gear.WhmCEM = {name="Mending Cape", augments={'Healing magic skill +3','Enha.mag. skill +10',}}
    
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Impatiens",
        head="Bunzi's Hat",
        body="Inyanga Jubbah +2",
        hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
        legs="Aya. Cosciales +2",
        feet="Navon Crackows",
        neck={ name="Cleric's Torque", augments={'Path: A',}},
        waist="Embla Sash",
        left_ear="Malignance Earring",
        left_ring="Kishar Ring",
        right_ring="Lebeche Ring",
        back=gear.WhmCFC,
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,{})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Doyen Pants",})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC,{legs="Ebers Pant. +3",})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {right_ear={ name="Nourish. Earring +1", augments={'Path: A',}}})
    
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    -- sets.precast.JA.Benediction = {body="Piety Briault"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Oshasha's Treatise",
        head="Aya. Zucchetto +2",
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands="Bunzi's Gloves",
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet="Aya. Gambieras +1",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Crep. Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Epaminondas's Ring",
        right_ring="Lehko's Ring",
    }

    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS, {
        head="Nyame Helm",
        feet="Nyame Sollerets",
    })

    -- Midcast Sets
    
    sets.midcast.FastRecast = {}
    
    -- Cure sets
    sets.midcast.Cure = {
        --main={ name="Queller Rod", augments={'MND+15','Mag. Acc.+15','"Cure" potency +15%',}},
        --sub="Sors Shield",
        head="Theo. Cap +1",
        body="Kaykaus Bliaut",
        hands="Theophany Mitts",
        legs="Ebers Pant. +3",
        feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
        neck={ name="Cleric's Torque", augments={'Path: A',}},
        waist="Korin Obi",
        left_ear="Glorious Earring",
        right_ear="Malignance Earring",
        left_ring="Menelaus's Ring",
        right_ring="Lebeche Ring",
        back=gear.WhmCFC,
    }
    
    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.StatusRemoval = set_combine(sets.precast.FC,{})

    sets.midcast["Erase"] = sets.midcast.StatusRemoval
    
    sets.midcast.Cursna = {
        head="Ebers Cap",
        body="Ebers Bliaut",
        hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
        legs="Theo. Pantaloons",
        feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
        neck="Sanctity Necklace",
        waist="Famine Sash",
        left_ear="Hermetic Earring",
        right_ear="Malignance Earring",
        left_ring="Menelaus's Ring",
        back=gear.WhmCFC,
    }

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {
        head="Umuthi Hat",
        body="Adamantite Armor",
        hands="Dynasty Mitts",
        legs={ name="Piety Pantaln. +3", augments={'Enhances "Afflatus Misery" effect',}},
        feet="Theo. Duckbills +3",
        neck="Melic Torque",
        waist="Embla Sash",
        left_ear="Mimir Earring",
        right_ear="Andoaa Earring",
        back=gear.WhmCEM
    }
     sets.midcast['Auspice'] = set_combine(sets.midcast['Enhancing Magic'], {feet="Ebers Duckbills +2",})

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
        head="Ebers Cap",
        body="Ebers Bliaut",
        hands="Ebers Mitts",
        legs={ name="Piety Pantaln. +3", augments={'Enhances "Afflatus Misery" effect',}},
        feet="Ebers Duckbills +2",
    })

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast['Divine Magic'] = {}

    sets.midcast['Enfeebling Magic'] = {
        head="Aya. Zucchetto +2",
        body="Theo. Bliaut +1",
        hands="Inyan. Dastanas +2",
        legs="Inyanga Shalwar +2",
        feet="Theo. Duckbills +3",
        neck="Sanctity Necklace",
        waist="Famine Sash",
        left_ear="Hermetic Earring",
        right_ear="Malignance Earring",
        left_ring="Ayanmo Ring",
        right_ring="Kishar Ring",
    }

    sets.midcast['Dark Magic'] = {}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})

    sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = set_combine(sets.idle, {})
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
        head="Aya. Zucchetto +2",
        body="Annoint. Kalasiris",
        hands="Aya. Manopolas +1",
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +1",
        neck="Sanctity Necklace",
        waist="Fucho-no-Obi",
        left_ear="Glorious Earring",
        right_ear="Nourish. Earring +1",
        left_ring="Inyanga Ring",
        right_ring="Shneddick Ring",
        back=gear.WhmCFC,
    }

    sets.idle.PDT = {
        ammo="Amar Cluster",
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands="Nyame Gauntlets",
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet="Nyame Sollerets",
        neck="Sanctity Necklace",
        waist="Plat. Mog. Belt",
        left_ear="Glorious Earring",
        right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
        left_ring="Defending Ring",
        right_ring="Shneddick Ring",
        back=gear.WhmCFC
    }

    sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})
    
    sets.idle.Weak = {}
    
    -- Defense sets

    sets.defense.PDT = {
        ammo="Amar Cluster",
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands="Nyame Gauntlets",
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet="Nyame Sollerets",
        neck="Sanctity Necklace",
        waist="Plat. Mog. Belt",
        left_ear="Glorious Earring",
        right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
        left_ring="Defending Ring",
        right_ring="Shneddick Ring",
        back=gear.WhmCFC
    }

    sets.defense.MDT = {}

    sets.Kiting = {}

    sets.latent_refresh = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
        ammo="Amar Cluster",
        head="Aya. Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Bunzi's Gloves",
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +1",
        neck="Clotharius Torque",
        waist="Cornelia's Belt",
        left_ear="Crep. Earring",
        right_ear="Brutal Earring",
        left_ring="Crepuscular Ring",
        right_ring="Lehko's Ring",
    }

    sets.engaged.DW = set_combine(sets.engaged, {
        waist="Shetal Stone",
        left_ear="Suppanomimi",
    })

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {}
    sets.Sublimation = {waist = "Embla Sash",}

    sets.weapons = {}
    sets.weapons.FC = {main="Yagrush",sub="Chanter's Shield"}
    sets.weapons.Enfeebling = {}
    sets.weapons.Enhancing = {main="Gada"}
    sets.weapons.Elemental = {}
    sets.weapons.Cure = {main="Queller Rod", sub="Sors Shield"}
    sets.weapons.Cure.SCH = {main={name="Chatoyant Staff",priority=10}, sub="Enki Strap",}
    sets.weapons.NA = {main="Yagrush"}
    sets.weapons.Bar = {main="Beneficus"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
   if cmdParams[1]:lower() == 'sneaks' then
        if player.sub_job == 'SCH' and buffactive['Light Arts'] then
            send_command('input /ja accession <me>;wait 2;input /ma sneak <me>')
        else
            send_command('@input /ma sneak <me>')
        end
    elseif cmdParams[1]:lower() == 'invis' then
        if player.sub_job == 'SCH' and buffactive['Light Arts'] then
            send_command('input /ja accession <me>;wait 2;input /ma invisible <me>')
        else
            send_command('@input /ma invisible <me>')
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if state.WeaponMode.value then
        mainhand = player.equipment.main
        offhand = player.equipment.sub
        equip(sets.weapons.FC)
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.WeaponMode.value then
        if whmBARelemental:contains(spell.english) then
            equip(sets.weapons.Bar)
        elseif whmNAspells:contains(spell.english) then
            equip(sets.weapons.NA)
        elseif spell.skill == 'Enhancing Magic' then
            equip(sets.weapons.Enhancing)
        elseif spell.skill == 'Enfeebling Magic' then
            equip(sets.weapons.Enfeebling)
        elseif spell.skill == 'Elemental Magic' then
            equip(sets.weapons.Elemental)
        elseif spellMap == 'Cure' then
            if player.sub_job == 'SCH' then
                equip(sets.weapons.Cure.SCH)
            else
                equip(sets.weapons.Cure)
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if state.WeaponMode.value then
        equip({main = mainhand, sub = offhand})
    end
end

-- Forces an update on 
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        send_command('gs c update')
    end
end

function update_combat_form()    
    if cf_check() then --checks if cf_check() exists
        cf_check() -- Check for 2H, Single or Duel Wield, function is defined in the Dagna-Globals.lua
    end
end

function job_update()
    update_combat_form()
end



-- Custom spell mapping.
--[[function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end]]

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

function WHMspellMap()
    whmNAspells = S{"Cursna","Blindna","Esuna","Paralyna","Poisona","Silena","Stona","Viruna","Erase"}
    whmBARelemental =S{"Barfira","Barblizzra","Baraera","Barstonra","Barthundra","Barwatera"}
    whmBARstatus = S{'Barpoison','Barparalyze','Barvirus','Barsilence','Barpetrify','Barblind','Baramnesia','Barsleep','Barpoisonra','Barparalyzra','Barvira','Barsilencera','Barpetra','Barblindra','Baramnesra','Barsleepra'}
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 3)
end

function lockstyleset()
    send_command('wait 5;input /lockstyleset 2')
end