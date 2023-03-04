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
    ammo="Oshasha's Treatise",
    head="Flam. Zucchetto +2",
    body="Flamma Korazin +2",
    hands="Sulev. Gauntlets +2",
    legs="Sulev. Cuisses +2",
    feet="Sulev. Leggings +2",
    neck="Clotharius Torque",
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    left_ring="Begrudging Ring",
    right_ring="Sulevia's Ring",
}

sets.precast.WS['Entropy'] = set_combine(sets.precast.WS, {waist="Shadow Belt"})
sets.precast.WS['Spiral Hell'] = set_combine(sets.precast.WS, {waist="Soil Belt"})



sets.midcast['Dark Magic'] = {
    neck="Sanctity Necklace",
    left_ear="Hermetic Earring",
    right_ear="Gwati Earring",
}

sets.defense.PDT = {
    head="Sulevia's Mask +2",
    body="Sulevia's Plate. +2",
    hands="Sulev. Gauntlets +2",
    legs="Sulevi. Cuisses +2",
    feet="Sulev. Leggings +2",
    neck="Loricate Torque",
    left_ring="Defending Ring",
    right_ring="Sulevia's Ring",
    back="Solemnity Cape",
}

sets.engaged = {
    ammo="Coiste Bodhar",
    head="Flam. Zucchetto +2",
    body="Flamma Korazin +2",
    hands="Sulev. Gauntlets +2",
    legs="Sulev. Cuisses +2",
    feet="Flam. Gambieras +2",
    neck="Clotharius Torque",
    waist="Dynamic Belt",
    left_ear="Crep. Earring",
    right_ear="Brutal Earring",
    left_ring="Begrudging Ring",
    right_ring="Sulevia's Ring",
    back="Atheling Mantle",
}

end