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
    main="Iridal Staff",
    head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
    body="Annoint. Kalasiris",
    hands="Kaykaus Cuffs",
    legs="Kaykaus Tights",
    feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}, 
    left_ring="Lebeche Ring",
    back="Solemnity Cape",
} 

sets.idle = {}

sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})

sets.defense.PDT = {}  

sets.engaged = {} 

end

function lockstyleset()
    send_command('wait 5;input /lockstyleset 7')
end