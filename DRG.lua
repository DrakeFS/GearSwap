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
    gear.DrgCTP = {name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
    
    --TH Tag set
    sets.TreasureHunter = {
        ammo="Per. Lucky Egg",
        head="Wh. Rarab Cap +1",
        waist="Chaac Belt",
    }
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA['Angon'] = {ammo = "Angon"}
    
    sets.precast.JA.Jump = {feet="Ostro Greaves",}

    sets.precast.JA['Ancient Circle'] = {}

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
        
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    
    -- Fast cast sets for spells
    sets.precast.FC = {}
    
    -- Midcast Sets
    sets.midcast.FastRecast = {}    
    
    sets.midcast.Breath = set_combine(sets.midcast.FastRecast, {})
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Knobkierrie",
        head="Sulevia's Mask +2",
        body="Sulevia's Plate. +1",
        hands="Sulev. Gauntlets +2",
        legs="Vishap Brais +2",
        feet="Sulev. Leggings +2",
        neck="Shulmanu Collar",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Cessance Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Pernicious Ring",
        right_ring="Petrov Ring",
        back=gear.DrgCTP,
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
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    sets.idle = {
    legs="Carmine Cuisses +1",
    neck="Sanctity Necklace",
    }

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = set_combine(sets.idle, {
    body="Councilor's Garb",
    })
    
    -- Defense sets
    sets.defense.PDT = {
        ammo="Ginsen",
        head="Sulevia's Mask +2",
        body="Flamma Korazin +2",
        hands="Sulev. Gauntlets +2",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Loricate Torque +1",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Steelflash Earring",
        right_ear="Bladeborn Earring",
        back=gear.DrgCTP,
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
        ammo="Ginsen",
        head="Sulevia's Mask +2",
        body="Flamma Korazin +2",
        hands="Sulev. Gauntlets +2",
        legs="Flamma Dirs +2",
        feet="Ostro Greaves",
        neck="Shulmanu Collar",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Sherida Earring",
        right_ear="Cessance Earring",
        left_ring="Dreki Ring",
        right_ring="Petrov Ring",
        back=gear.DrgCTP,
    }

    sets.engaged.THand = sets.engaged

    sets.engaged.DW = {
        ammo="Ginsen",
        head="Sulevia's Mask +2",
        body="Flamma Korazin +2",
        hands="Sulev. Gauntlets +2",
        legs="Flamma Dirs +2",
        feet="Ostro Greaves",
        neck="Shulmanu Collar",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Sherida Earring",
        right_ear="Cessance Earring",
        left_ring="Dreki Ring",
        right_ring="Petrov Ring",
        back=gear.DrgCTP,
    }        

end

function job_update(cmdParams, eventArgs)
    update_combat_form()
end

function update_combat_form()
    -- Check for 2H, Single or Duel Wield 
    cf_check() -- function is defined in the Dagna-Globals.lua
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function on_job_change()
    set_macro_page(1, 14)
    send_command('wait 5;input /lockstyleset 41')
end
