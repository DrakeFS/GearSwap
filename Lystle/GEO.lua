function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()
    state.WeaponSwapMode= M(true)
end

function user_setup()
    send_command('bind ^q gs c toggle WeaponSwapMode')
    on_job_change()
end

function user_unload()
    send_command('unbind ^q gs c toggle WeaponSwapMode')
end

function init_gear_sets()
    sets.precast.FC = {
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head="Nahtirah Hat",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Geomancy Pants",
        feet="Navon Crackows",
        waist="Embla Sash",
        right_ear="Malignance Earring",
        left_ring="Kishar Ring",
        right_ring="Jhakri Ring",
    }

    sets.precast.JA['Bolster'] = {body="Bagua Tunic"}
    sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic"}
    sets.precast.JA['Full Circle'] = {head="Azimuth Hood"}

    sets.precast.WS = {}

    sets.midcast.Cure ={
        head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
        body={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
        hands="Nyame Gauntlets",
        legs="Geomancy Pants",
        feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
        waist="Emphatikos Rope",
        right_ear="Malignance Earring",
        left_ring="Menelaus's Ring",
        right_ring="Lebeche Ring",
        back="Solemnity Cape",
    }

    sets.midcast['Elemental Magic'] = {
        ammo="Ghastly Tathlum",
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +1",
        neck="Sibyl Scarf",
        waist="Famine Sash",
        left_ear="Malignance Earring",
        right_ear="Hermetic Earring",
        left_ring="Metamorph Ring",
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

    sets.defense.PDT = {
        head="Nyame Helm",
        body="Adamantite Armor",
        hands="Nyame Gauntlets",
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet="Nyame Sollerets",
        neck="Loricate Torque",
        waist="Plat. Mog. Belt",
        left_ring="Defending Ring",
        right_ring="Shneddick Ring",
        back="Solemnity Cape",
    }

    sets.idle = set_combine(sets.defense.PDT,{
        body="Jhakri Robe +2",
        feet="Geo. Sandals +3",
        right_ring="Shneddick Ring",
    })

    sets.idle.Pet = set_combine(sets.idle, { -- Pet DT Caps @ 38%
        head="Azimuth Hood",
        hands="Geomancy Mitaines",
        legs="Psycloth Lappas",
        feet={ name="Bagua Sandals", augments={'Enhances "Radial Arcana" effect',}},
    })

    sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})

    sets.engaged = {
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +1",
        neck="Sanctity Necklace",
        waist="Famine Sash",
        left_ear="Eabani Earring",
        right_ear="Suppanomimi",
        left_ring="Begrudging Ring",
        right_ring="Jhakri Ring",
        back="Solemnity Cape",
    }

    sets.weapons = {}
    sets.weapons.FC = {main="Solstice", sub="Chanter's Shield",}
    sets.weapons.FC.Dispelga = {main="Daybreak",}
    sets.weapons.Healing = {main="Daybreak", sub="Sors Shield",}
    sets.weapons.Enhancing = {main="Gada",}
    sets.weapons.Enfeebling = {main='Daybreak',}
    sets.weapons.Elemental ={main='Daybreak',}
    sets.weapons.Dispelga = {main='Daybreak',}
    sets.weapons.Geomancy = {main="Solstice",}

end

function job_precast(spell, action, spellMap, eventArgs)
    if state.WeaponSwapMode.value then
        
        mainhand = player.equipment.main
        offhand = player.equipment.sub

        if spellMap == "Cure" then
            equip(sets.weapons.FC)
        elseif spell.skill == "Enhancing Magic" then
            equip(sets.weapons.FC)
        elseif spell.skill == "Geomancy" then
            equip(sets.weapons.FC)
        elseif spell.name == 'Dispelga' then
            equip(sets.weapons.Dispelga)
        elseif spell.skill == "Enfeebling Magic" then
            equip(sets.weapons.FC)
        elseif spell.skill == "Elemental Magic" then
            equip(sets.weapons.FC)
        end
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.WeaponSwapMode.value then
        if spellMap == "Cure" then
            equip(sets.weapons.Healing)
        elseif spell.skill == "Enhancing Magic" then
            equip(sets.weapons.Enhancing)
        elseif spell.skill == "Geomancy" then
            equip(sets.weapons.Geomancy)
        elseif spell.name == 'Dispelga' then
            equip(sets.weapons.Dispelga)
        elseif spell.skill == "Enfeebling Magic" then
            equip(sets.weapons.Enfeebling)
        elseif spell.skill == "Elemental Magic" then
            equip(sets.weapons.Elemental)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if state.WeaponSwapMode.value then
        equip({main = mainhand, sub = offhand})
    end
end

function on_job_change()
    set_macro_page(6, 19)
    send_command('wait 5;input /lockstyleset 81')
end

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'sneaks' then
        send_command('@input /ma sneak <me>')
    elseif cmdParams[1]:lower() == 'invis' then
        send_command('@input /ma invisible <me>')
    end
end