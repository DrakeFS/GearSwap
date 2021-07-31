function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()
end

function user_setup()
    lockstyleset()
end

function init_gear_sets()
sets.precast.FC = {
    ammo="Impatiens",
    head="Nahtirah Hat",
    hands="Acad. Bracers +2",
    legs="Kaykaus Tights",
    feet="Navon Crackows",
    waist="Embla Sash",
    left_ring="Kishar Ring",
}

sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {})

sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
    body={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    legs="Doyen Pants",
    feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
})

sets.precast.WS = {}

sets.midcast.Cure = {
    main="Chatoyant Staff",
    head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
    body="Kaykaus Bliaut",
    hands="Kaykaus Cuffs",
    legs="Kaykaus Tights",
    feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}, 
    waist="Korin Obi",
    left_ring="Lebeche Ring",
    back="Solemnity Cape",
} 

sets.midcast.Regen = {
    main="Bolelabunga",
    head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
    body="Kaykaus Bliaut",
    hands="Kaykaus Cuffs",
    legs="Kaykaus Tights",
    feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}, 
    waist="Korin Obi",
    left_ring="Lebeche Ring",
    back="Solemnity Cape",
} 

sets.idle = {
    main="Bolelabunga",
    head="Acad. Mortar. +2",
    body="Jhakri Robe +1",
    neck="Sanctity Necklace",
    waist="Embla Sash",
    left_ring="Defending Ring",
}

sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})

sets.defense.PDT = {}  

sets.engaged = {} 

end

function job_post_precast(spell, action, spellMap, eventArgs)
    if ((buffactive['Addendum: White'] and spell.type == "WhiteMagic") or (buffactive['Addendum: Black'] and spell.type == "BlackMagic")) and not spell.name:contains("Cure") then
        equip({feet="Acad. Loafers +2",})
    end
end

function lockstyleset()
    send_command('wait 5;input /lockstyleset 7')
end