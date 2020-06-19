function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()
end

function user_setup()
end

function init_gear_sets()
sets.precast.FC = {
    ammo="Impatiens",
    left_ring="Lebeche Ring",
}

sets.precast.WS = {
    ammo="Seething Bomblet", 
    feet="Sulev. Leggings +1",
}

sets.precast.WS['Entropy'] = set_combine(sets.precast.WS, {waist="Shadow Belt"})

sets.midcast['Dark Magic'] = {
    neck="Sanctity Necklace",
    left_ear="Hermetic Earring",
    right_ear="Gwati Earring",
}

sets.defense.PDT = {
    head="Sulevia's Mask +1",
    body="Sulevia's Plate. +1",
    hands="Sulev. Gauntlets +1",
    legs="Sulevi. Cuisses +1",
    feet="Sulev. Leggings +1",
    neck="Loricate Torque",
    left_ring="Defending Ring",
    right_ring="Sulevia's Ring",
    back="Solemnity Cape",
}

sets.engaged = {
    ammo="Ginsen",
    head="Sulevia's Mask +1",
    body={ name="Found. Breastplate", augments={'Accuracy+5','Attack+3','"Mag.Atk.Bns."+1',}},
    hands="Sulev. Gauntlets +1",
    legs="Odyssean Cuisses",
    feet={ name="Founder's Greaves", augments={'VIT+10','Accuracy+15','"Mag.Atk.Bns."+15','Mag. Evasion+15',}},
    neck="Clotharius Torque",
    waist="Sailfi Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Begrudging Ring",
    right_ring="Sulevia's Ring",
    back="Atheling Mantle",
}

end