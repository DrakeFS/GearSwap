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
gear.WSCape = {name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
gear.TPCape = {name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}

sets.precast.WS = {
    ammo="Oshasha's Treatise",
    head={ name="Herculean Helm", augments={'Accuracy+15','"Fast Cast"+4','Weapon skill damage +7%','Accuracy+16 Attack+16','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands="Meg. Gloves +2",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet="Mummu Gamash. +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Sherida Earring",
    right_ear="Crep. Earring",
    left_ring="Begrudging Ring",
    right_ring="Mummu Ring",
    back=gear.WSCape,
} 

sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
    ammo="Falcon Eye",
    hands="Mummu Wrists +2",
    legs="Mummu Kecks +2",
})

sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {
    right_ear = "Moonshade Earring",
})

sets.defense.PDT = {
    head="Nyame Helm",
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands="Malignance Gloves",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet="Nyame Sollerets",
    neck="Loricate Torque",
    left_ear="Odnowa Earring +1",
    right_ear="Eabani Earring",
    left_ring="Defending Ring",
    right_ring="Shneddick Ring",
    back=gear.TPCape,
}

sets.idle = set_combine(sets.defense.PDT, {neck="Sanctity Necklace",})

sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})

sets.engaged = {
    ammo="Coiste Bodhar",
    head="Mummu Bonnet +2",
    body="Mummu Jacket +2",
    hands="Mummu Wrists +2",
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Mummu Gamash. +2",
    neck="Clotharius Torque",
    waist="Dynamic Belt",
    left_ear="Sherida Earring",
    right_ear="Crep. Earring",
    left_ring="Lehko's Ring",
    right_ring="Mummu Ring",
    back=gear.TPCape,
}

end

-- Job Specific Functions

function on_job_change()
    set_macro_page(1,19)
    send_command('wait 5;input /lockstyleset 4')
end