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
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    select_default_macro_book()
    lockstyleset()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Impatiens",
        body="Inyanga Jubbah +2",
        neck={ name="Cleric's Torque", augments={'Path: A',}},
        hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
        waist="Embla Sash",
        left_ring="Lebeche Ring",
        back=gear.WhmCFC,
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC,{})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'],{legs="Doyen Pants",})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC,{legs="Ebers Pantaloons",})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'],{
        main="Ababinili",
        ammo="Impatiens",
        head="Theo. Cap +1",
        left_ear="Nourish. Earring",
        right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
    })
    
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    -- sets.precast.JA.Benediction = {body="Piety Briault"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    sets.precast.WS['Flash Nova'] = {}

    -- Midcast Sets
    
    sets.midcast.FastRecast = {}
    
    -- Cure sets
    sets.midcast.CureSolace = {}

    sets.midcast.Cure = {
        main={ name="Queller Rod", augments={'MND+15','Mag. Acc.+15','"Cure" potency +15%',}},
        sub="Sors Shield",
        head="Theo. Cap +1",
        body="Theo. Briault +1",
        hands="Theophany Mitts",
        legs="Ebers Pantaloons",
        feet={ name="Piety Duckbills +1", augments={'Enhances "Afflatus Solace" effect',}},
        neck={ name="Cleric's Torque", augments={'Path: A',}},
        waist="Friar's Rope",
        left_ear="Glorious Earring",
        right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
        left_ring="Lebeche Ring",
        back="Solemnity Cape",
    }

    sets.midcast.Curaga = {}

    sets.midcast.CureMelee = {}

    sets.midcast.Cursna = {}

    sets.midcast.StatusRemoval = {}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {
        main="Ababinili",
        hands="Inyan. Dastanas +1",
        feet={ name="Piety Duckbills +1", augments={'Enhances "Afflatus Solace" effect',}},
        neck="Sanctity Necklace",
        waist="Embla Sash",
    }

    sets.midcast.Stoneskin = {}

    sets.midcast.Auspice = {}

    sets.midcast.BarElement = {}

    sets.midcast.Regen = {}

    sets.midcast.Protectra = {}

    sets.midcast.Shellra = {}


    sets.midcast['Divine Magic'] = {}

    sets.midcast['Dark Magic'] = {}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {}

    sets.midcast.IntEnfeebles = {}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = set_combine(sets.idle, {})
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
        main={ name="Queller Rod", augments={'MND+15','Mag. Acc.+15','"Cure" potency +15%',}},
        sub="Sors Shield",
        head="Aya. Zucchetto +1",
        body="Annoint. Kalasiris",
        hands="Aya. Manopolas +1",
        legs="Aya. Cosciales +1",
        feet="Aya. Gambieras +1",
        neck="Sanctity Necklace",
        waist="Fucho-no-Obi",
        left_ear="Glorious Earring",
        right_ear="Nourish. Earring +1",
        left_ring="Inyanga Ring",
        right_ring="Ayanmo Ring",
        back=gear.WhmCFC,
    }

    sets.idle.PDT = {
        head="Aya. Zucchetto +1",
        body="Ayanmo Corazza +1",
        hands="Aya. Manopolas +1",
        legs="Aya. Cosciales +1",
        feet="Aya. Gambieras +1",
        left_ring="Inyanga Ring",
        right_ring="Ayanmo Ring",
        back=gear.WhmCFC
    }

    sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})
    
    sets.idle.Weak = {}
    
    -- Defense sets

    sets.defense.PDT = {
        head="Aya. Zucchetto +1",
        body="Ayanmo Corazza +1",
        hands="Aya. Manopolas +1",
        legs="Aya. Cosciales +1",
        feet="Aya. Gambieras +1",
        left_ring="Inyanga Ring",
        right_ring="Ayanmo Ring",
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
        head="Aya. Zucchetto +1",
        hands="Aya. Manopolas +1",
        body="Ayanmo Corazza +1",
        legs="Aya. Cosciales +1",
        feet="Aya. Gambieras +1",
        neck="Sanctity Necklace",
        waist="Life Belt",
        left_ear="Steelflash Earring",
        right_ear="Bladeborn Earring",
        left_ring="Begrudging Ring",
        right_ring="Ayanmo Ring",
    }


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {}
    sets.Sublimation = {waist = "Embla Sash",}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
--[[function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
    
    if spell.skill == 'Healing Magic' then
        gear.default.obi_back = "Mending Cape"
    else
        gear.default.obi_back = "Toro Cape"
    end
end]]

-- Forces an update on 
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        send_command('gs c update')
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
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
end


function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if buffactive['Sublimation: Activated'] then
        idleSet = set_combine(idleSet, sets.Sublimation)
    end
    
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
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