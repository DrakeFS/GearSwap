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
sets.precast.FC = {
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head="Nahtirah Hat",
    body="Jhakri Robe +1",
    hands="Jhakri Cuffs +1",
    legs="Geomancy Pants",
    feet="Navon Crackows",
    waist="Embla Sash",
    left_ring="Kishar Ring",
    right_ring="Jhakri Ring",
}

sets.precast.JA['Bolster'] = {body="Bagua Tunic"}
sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic"}
sets.precast.JA['Full Circle'] = {head="Azimuth Hood"}

sets.precast.WS = {}

sets.midcast['Elemental Magic'] = {
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head="Jhakri Coronal +1",
    body="Jhakri Robe +1",
    hands="Jhakri Cuffs +1",
    legs="Jhakri Slops +1",
    feet="Jhakri Pigaches +1",
    neck="Sanctity Necklace",
    waist="Famine Sash",
    left_ear="Hermetic Earring",
    right_ear="Gwati Earring",
    left_ring="Kishar Ring",
    right_ring="Jhakri Ring",
}

sets.midcast.Geomancy = {
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head="Azimuth Hood",
    body={ name="Bagua Tunic", augments={'Enhances "Bolster" effect',}},
    hands="Geomancy Mitaines",
    neck="Deceiver's Torque",
    left_ear="Gna Earring",
    right_ear="Fulla Earring",
    left_ring="Defending Ring",
    back="Solemnity Cape",
}

sets.defense.PDT = {}

sets.idle = {
    body="Jhakri Robe +1",
    hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
    feet="Geomancy Sandals",
    neck="Loricate Torque",
    waist="Fucho-no-Obi",
    left_ring="Defending Ring",
    back="Solemnity Cape",
}

sets.idle.Pet = set_combine(sets.idle, { -- Pet DT Caps @ 38%
    head="Azimuth Hood",
    hands="Geomancy Mitaines",
    legs="Psycloth Lappas",
    feet={ name="Bagua Sandals", augments={'Enhances "Radial Arcana" effect',}},
})

sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})

sets.engaged = {
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head="Jhakri Coronal +1",
    body="Jhakri Robe +1",
    hands="Jhakri Cuffs +1",
    legs="Jhakri Slops +1",
    feet="Jhakri Pigaches +1",
    neck="Sanctity Necklace",
    waist="Famine Sash",
    left_ear="Eabani Earring",
    right_ear="Suppanomimi",
    left_ring="Begrudging Ring",
    right_ring="Jhakri Ring",
    back="Solemnity Cape",
}

end

function on_job_change()
    set_macro_page(6, 19)
    send_command('wait 5;input /lockstyleset 81')
end