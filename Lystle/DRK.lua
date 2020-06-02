function get_sets()
    mote_include_version = 2
	include('Mote-Include.lua')
end

function job_setup()
end

function user_setup()
end

function init_gear_sets()

sets.engaged = {
    ammo="Seething Bomblet",
    head="Sulevia's Mask +1",
    body="Sulevia's Plate. +1",
    hands="Sulev. Gauntlets +1",
    legs="Sulevi. Cuisses +1",
    feet={ name="Founder's Greaves", augments={'VIT+10','Accuracy+15','"Mag.Atk.Bns."+15','Mag. Evasion+15',}},
    neck="Sanctity Necklace",
    waist="Dynamic Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Begrudging Ring",
    right_ring="Sulevia's Ring",
    back="Atheling Mantle",
}

end