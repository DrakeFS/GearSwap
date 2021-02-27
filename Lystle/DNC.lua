function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()
    
end

function user_setup()
    on_job_change()
end

function init_gear_sets()
sets.precast.FC = {}  -- Fast Cast Set

sets.precast.WS = {
    ammo="Ginsen",
    head={ name="Herculean Helm", augments={'Accuracy+15','"Fast Cast"+4','Weapon skill damage +7%','Accuracy+16 Attack+16','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
    body="Meg. Cuirie +2",
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +2",
    feet="Mummu Gamash. +2",
    neck="Clotharius Torque",
    waist="Dynamic Belt",
    left_ear="Sherida Earring",
    right_ear="Steelflash Earring",
    left_ring="Begrudging Ring",
    right_ring="Mummu Ring",
    back="Atheling Mantle",
} 

sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
    ammo="Falcon Eye",
    hands="Mummu Wrists +2",
    legs="Mummu Kecks +2",
    waist="Soil Belt",
})

sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {
    waist = "Shadow Belt",
    right_ear = "Moonshade Earring",
})

sets.defense.PDT = {
    head="Meghanada Visor +1",
    body="Meg. Cuirie +2",
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +2",
    feet="Meg. Jam. +1",
    neck="Loricate Torque",
    left_ear="Odnowa Earring +1",
    right_ear="Eabani Earring",
    left_ring="Defending Ring",
    right_ring="Meghanada Ring",
    back="Solemnity Cape",
}

sets.idle = set_combine(sets.defense.PDT, {neck="Sanctity Necklace",})

sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})

sets.engaged = {
    ammo="Ginsen",
    head="Mummu Bonnet +2",
    body="Mummu Jacket +2",
    hands="Mummu Wrists +2",
    legs="Meg. Chausses +2",
    feet="Mummu Gamash. +2",
    neck="Clotharius Torque",
    waist="Dynamic Belt",
    left_ear="Sherida Earring",
    right_ear="Steelflash Earring",
    left_ring="Begrudging Ring",
    right_ring="Mummu Ring",
    back="Atheling Mantle",
}

end

-- Job Specific Functions

function on_job_change()
    set_macro_page(1,19)
    send_command('wait 5;input /lockstyleset 4')
end