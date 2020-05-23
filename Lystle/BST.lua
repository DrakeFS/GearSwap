
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
end

function init_gear_sets()

sets.idle = {}
sets.idle.Town = {body="Councilor's Garb",}

sets.engaged = {    
    main="Kaja Axe",
    sub="Barbarity",
    ammo="Ginsen",
    head="Meghanada Visor +1",
    body="Meg. Cuirie +2",
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +1",
    feet="Meg. Jam. +1",
    neck="Sanctity Necklace",
    waist="Dynamic Belt",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Begrudging Ring",
    right_ring="Meghanada Ring",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+26%','Rng.Atk.+1','DEF+5',}},
}

end