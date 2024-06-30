function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()
    state.WSSelection = M{['description'] = 'Selected Weapon skill'}
    state.WSSelection:options('fudo','jinpu','shoha')
    state.WSSelection:set('fudo')
    WeaponSkills = {['fudo'] = 'Fudo',['jinpu']='jinpu',['shoha']='shoha'}
end

function user_setup()
    on_job_change()

    send_command('bind ^` gs c cycle WSSelection')
    send_command('bind ~^` gs c cycleback WSSelection')
end

function user_unload()
    send_command('unbind ^` gs c cycle WSSelection')
    send_command('unbind ~^` gs c cycleback WSSelection')
end

function init_gear_sets()
    gear.BackTP = { name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.BackPWS = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}

    sets.precast.FC = {}  -- Fast Cast Set

    -- sets.precast.RA = {}  -- Ranged delay reduction.  Ignore if uneeded, remove the first "--" to activate.

    sets.precast.JA["Warding Circle"] = {head="Wakido Kabuto +3"}
    sets.precast.JA["Third Eye"] = {legs="Sakonji Haidate +3"}
    sets.precast.JA["Meditate"] = {
        head="Wakido Kabuto +3",
        hands="Sakonji kote +3",
        back=gear.BackTP
    }
    sets.precast.JA["Seigan"] = {head="Kasuga Kabuto +3"}
    sets.precast.JA["Sekkanoki"] = {hands="Kasuga Kote +3"}
    sets.precast.JA["Blade Bash"] = {hands="Sakonji kote +3"}
    sets.precast.JA["Sengikori"] = {feet="Kas. Sune-Ate +3"}
    --sets.precast.JA["Meikyo Shisui"] = {feet="Sakonji sune-ate +3"}
        --[[sets.precast.JA["Hasso"] = { -- Must stay equiped to gain the benefit
        hands="Wakido Kote +3",
        legs="Kasuga Haidate +3",
        feet="Wakido Sune. +3"
    }]]

    sets.precast.WS = {
        ammo="Knobkierrie",
        head="Mpaca's Cap",
        body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
        hands="Kasuga Kote +3",
        legs="Wakido Haidate +3",
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        right_ear="Thrud Earring",
        left_ring="Cornelia's Ring",
        right_ring="Epaminondas's Ring",
        back=gear.BackPWS
    }

    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS,{
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
    })

    sets.precast.WS['Raiden Thrust'] = set_combine(sets.precast.WS,{
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
    })


    -- sets.midcast.RA = {} -- Ranged TP Set.  Ignore if uneeded, remove the first "--" to activate.

    sets.defense.PDT = {
        ammo="Amar Cluster",
        head="Mpaca's Cap",
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck="Loricate Torque +1",
        waist="Plat. Mog. Belt",
        left_ring="Defending Ring",
        right_ring="Shneddick Ring",
        back=gear.BackTP
    }

    sets.idle = {
        ammo="Amar Cluster",
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands={ name="Nyame Gauntlets", augments={'Path: B',}},
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet={ name="Nyame Sollerets", augments={'Path: B',}},
        neck="Loricate Torque +1",
        waist="Plat. Mog. Belt",
        left_ring="Defending Ring",
        right_ring="Shneddick Ring",
        back=gear.BackTP
    }

    sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})

    sets.engaged = {
        ammo={ name="Coiste Bodhar", augments={'Path: A',}},
        head="Kasuga Kabuto +3",
        body="Kasuga Domaru +3",
        hands="Flam. Manopolas +2",
        legs="Kasuga Haidate +3",
        feet="Flam. Gambieras +2",
        neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
        waist="Sarissapho. Belt",
        left_ear="Crep. Earring",
        right_ear="Cessance Earring",
        left_ring="Petrov Ring",
        right_ring="Ilabrat Ring",
        back=gear.BackTP
    }
end

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'ws' then
        if cmdParams[2]:lower() == 'use' then
            send_command('input /ws "Tachi: '..WeaponSkills[state.WSSelection.value]..'" <t>')
        elseif  cmdParams[2]:lower() == 'set' then
            if state.WSSelection:contains(cmdParams[3]:lower()) then
                state.WSSelection:set(cmdParams[3]:lower())
            else
                add_to_chat(123,"Not a selectable Weaponskill")
            end
        end
    end
end

function on_job_change()
    set_macro_page(1, 12)
    send_command('wait 5;input /lockstyleset 184')
end