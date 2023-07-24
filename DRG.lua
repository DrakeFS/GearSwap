-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()
    include('Mote-TreasureHunter')
    update_combat_form()
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
  
    on_job_change()

    send_command('bind ^= gs c cycle treasuremode')

end


-- Called when this job file is unloaded (eg: job change)
function file_unload()

    send_command('unbind ^= gs c cycle treasuremode')

end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    --JSE Gear definitions
    gear.DrgCTP = {name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}}
    gear.DrgCWS = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
    
    --TH Tag set
    sets.TreasureHunter = {
        ammo="Per. Lucky Egg",
        head="Wh. Rarab Cap +1",
        waist="Chaac Belt",
    }
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA['Angon'] = {ammo = "Angon"}
    
    sets.precast.JA.Jump = {
        body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
        hands="Vis. Fng. Gaunt. +2",
        feet="Ostro Greaves",
    }

    sets.precast.JA['Ancient Circle'] = {}

    sets.precast.JA['High Jump'] = set_combine(sets.precast.JA.Jump, {})
    sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA.Jump, {})
    sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA.Jump, {})
    sets.precast.JA['Super Jump'] = sets.precast.JA.Jump

    sets.precast.JA['Spirit Link'] = {}
    sets.precast.JA['Call Wyvern'] = {body="Ptero. Mail +3",}
    sets.precast.JA['Deep Breathing'] = {}
    sets.precast.JA['Spirit Surge'] = {}
        
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    
    -- Fast cast sets for spells
    sets.precast.FC = {}

    sets.precast.RA = {range="Trollbane",}
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Knobkierrie",
        head="Peltast's Mezail +2",
        body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
        hands={ name="Ptero. Fin. G. +2", augments={'Enhances "Angon" effect',}},
        legs="Vishap Brais +2",
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck="Shulmanu Collar",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Sherida Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Epaminondas's Ring",
        right_ring="Cornelia's Ring",
        back=gear.DrgCWS,
    }
           
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",
        waist="Fotia Belt",
    })
    
    sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",
        waist="Fotia Belt"
    })
    
    sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {})
    
    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
        neck="Fotia Gorget",
        waist="Fotia Belt"
    })

    -- Midcast Sets
    sets.midcast.FastRecast = {}    
    
    sets.midcast.Breath = set_combine(sets.midcast.FastRecast, {})

    sets.midcast.RA = {range="Trollbane",}

    -- Defense sets
    sets.defense.PDT = {
        ammo="Crepuscular Pebble",
        head="Nyame Helm",
        body="Nyame Mail",
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck="Loricate Torque +1",
        waist="Flume Belt",
        left_ear="Odnowa Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Defending Ring",
        right_ring="Vocane Ring",
        back=gear.DrgCTP,
        }

    -- Idle sets
    sets.idle = set_combine(sets.defense.PDT, {
        head="Gleti's Mask",
        body="Gleti's Cuirass",
        hands="Gleti's Gauntlets",
        legs="Carmine Cuisses +1",
        feet="Gleti's Boots",
        neck="Sanctity Necklace",
    })

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = set_combine(sets.idle, {
        body="Councilor's Garb",
    })

    -- Engaged sets
    sets.engaged = {
        ammo={ name="Coiste Bodhar", augments={'Path: A',}},
        head="Flam. Zucchetto +2",
        body="Flamma Korazin +2",
        hands="Flam. Manopolas +2",
        legs={ name="Ptero. Brais +2", augments={'Enhances "Strafe" effect',}},
        feet="Flam. Gambieras +2",
        neck={ name="Vim Torque +1", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Sherida Earring",
        right_ear="Cessance Earring",
        left_ring="Pernicious Ring",
        right_ring="Petrov Ring",
        back=gear.DrgCTP,
    }

    sets.engaged.THand = set_combine(sets.engaged, {})

    sets.engaged.DW = set_combine(sets.engaged, {})

end

function job_update(cmdParams, eventArgs)
    update_combat_form()
end

function update_combat_form()
    if cf_check then --checks if cf_check() exists
        cf_check() -- Check for 2H, Single or Duel Wield, function is defined in the Dagna-Globals.lua
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function on_job_change()
    set_macro_page(1, 14)
    send_command('wait 5;input /lockstyleset 41')
end
