-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
end


-- Setup vars that are user-independent.
function job_setup()
    include('Mote-TreasureHunter')
    state.Buff = {}
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.IdleMode:options('Normal')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    gear.DrgCTP = {name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+6','"Dbl.Atk."+10',}}
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Angon = {ammo = "Angon"}
    --sets.Berserker = {neck="Berserker's Torque"}
    --sets.WSDayBonus = {}
    --sets.Organizer = {}

    sets.precast.JA.Jump = {
    feet="Ostro Greaves",
    }

    sets.precast.JA['Ancient Circle'] = {}

    sets.TreasureHunter = {
        ammo="Per. Lucky Egg",
        waist="Chaac Belt",
        left_ring="Gorney Ring",
    }

    sets.precast.JA['High Jump'] = set_combine(sets.precast.JA.Jump, {})
    sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA.Jump, {})
    sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA.Jump, {})
    sets.precast.JA['Super Jump'] = sets.precast.JA.Jump

    sets.precast.JA['Spirit Link'] = {}
    sets.precast.JA['Call Wyvern'] = {
    body="Pteroslaver Mail",
    }
    sets.precast.JA['Deep Breathing'] = {}
    sets.precast.JA['Spirit Surge'] = {}
    
    -- Healing Breath sets
    sets.HB = {}

    sets.MadrigalBonus = {}
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    sets.precast.FC = {}
    
    -- Midcast Sets
    sets.midcast.FastRecast = {}    
    
    sets.midcast.Breath = set_combine(sets.midcast.FastRecast, {})
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Oshasha's Treatise",
        head="Flam. Zucchetto +2",
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands="Flam. Manopolas +2",
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet="Sulev. Leggings +2",
        neck="Rep. Plat. Medal",
        waist="Sailfi Belt",
        left_ear="Sherida Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Begrudging Ring",
        right_ring="Lehko's Ring",
        back=gear.DrgCTP,
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
        neck="Shadow Gorget",
        waist="Shadow Belt",
    })
    
    sets.precast.WS['Stardiver'].Mid = set_combine(sets.precast.WS['Stardiver'], {})
    
    sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, {})

    sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {})
    
    sets.precast.WS["Camlann's Torment"].Mid = set_combine(sets.precast.WS["Camlann's Torment"], {})
    
    sets.precast.WS["Camlann's Torment"].Acc = set_combine(sets.precast.WS["Camlann's Torment"].Mid, {})

    sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {})
    
    sets.precast.WS['Drakesbane'].Mid = set_combine(sets.precast.WS['Drakesbane'], {})
    
    sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS['Drakesbane'].Mid, {})
    
    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
    neck="Soil Gorget",
    waist="Soil Belt"
    })
    
    sets.precast.WS['Impulse Drive'].Mid = set_combine(sets.precast.WS['Impulse Drive'], {})
    
    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS['Impulse Drive'].Mid, {})
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    sets.idle = {
    legs="Carmine Cuisses +1",
    neck="Sanctity Necklace",
    left_ring="Defending Ring",
    back="Solemnity Cape",
    }

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = set_combine(sets.idle, {
    body="Councilor's Garb",
    })
    
    sets.idle.Field = set_combine(sets.idle, {
    })
    
    sets.idle.Regen = set_combine(sets.idle.Field, {
    neck="Sanctity Necklace",
    })

    sets.idle.Weak = set_combine(sets.idle.Field, {})
    
    -- Defense sets
    sets.defense.PDT = {
        head="Sulevia's Mask +2",
        body="Sulevia's Plate. +2",
        hands="Sulev. Gauntlets +2",
        legs="Sulevi. Cuisses +2",
        feet="Sulev. Leggings +2",
        neck="Loricate Torque",
        left_ring="Defending Ring",
        back="Solemnity Cape",
    }

    sets.defense.Reraise = set_combine(sets.defense.PDT, {})

    sets.defense.MDT = set_combine(sets.defense.PDT, {})

    sets.Kiting = {}

    sets.Reraise = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        ammo="Coiste Bodhar",
        head="Flam. Zucchetto +2",
        body="Flamma Korazin +2",
        hands="Sulev. Gauntlets +2",
        legs="Sulev. Cuisses +2",
        feet="Flam. Gambieras +2",
        neck="Clotharius Torque",
        waist="Dynamic Belt",
        left_ear="Sherida Earring",
        right_ear="Crep. Earring",
        left_ring="Rajas Ring",
        right_ring="Lehko's Ring",
        back=gear.DrgCTP,
    }

    sets.engaged.DW = set_combine(sets.engaged, {})

    sets.engaged.THand = set_combine(sets.engaged, {})

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

function job_update(cmdParams, eventArgs)
    if cf_check() then
        cf_check()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
            equip(sets.buff[buff_name] or {})
        eventArgs.handled = true
    end
end

-- Set a Style Lock
function lockstyleset()
    send_command('wait 5;input /lockstyleset 41')
end
