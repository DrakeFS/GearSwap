-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Also, you'll need the Shortcuts addon to handle the auto-targetting of the custom pact commands.

--[[
    Custom commands:
    
    gs c petweather
        Automatically casts the storm appropriate for the current avatar, if possible.
    
    gs c siphon
        Automatically run the process to: dismiss the current avatar; cast appropriate
        weather; summon the appropriate spirit; Elemental Siphon; release the spirit;
        and re-summon the avatar.
        
        Will not cast weather you do not have access to.
        Will not re-summon the avatar if one was not out in the first place.
        Will not release the spirit if it was out before the command was issued.
        
    gs c pact [PactType]
        Attempts to use the indicated pact type for the current avatar.
        PactType can be one of:
            cure
            curaga
            buffOffense
            buffDefense
            buffSpecial
            debuff1
            debuff2
            sleep
            nuke2
            nuke4
            bp70
            bp75 (merits and lvl 75-80 pacts)
            astralflow

--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff["Avatar's Favor"] = buffactive["Avatar's Favor"] or false
    state.Buff["Astral Conduit"] = buffactive["Astral Conduit"] or false

    spirits = S{"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"}

    avatars = S{"Carbuncle", "Fenrir", "Diabolos", "Ifrit", "Titan", "Leviathan", "Garuda", "Shiva", "Ramuh", "Odin", "Alexander", "Cait Sith", "Siren"}
  
    bp_magical = S{'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust','Judgment Bolt','Searing Light','Howling Moon',
        'Ruinous Omen','Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II','Thunderspark','Somnolence','Meteorite',
        'Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV','Nether Blast','Meteor Strike','Geocrush','Grand Fall',
        'Wind Blade','Heavenly Strike','Thunderstorm','Level ? Holy','Holy Mist','Lunar Bay','Night Terror','Conflag Strike','Sonic Buffet','Tornado II'
    }
    
    bp_physical=S{'Punch','Rock Throw','Barracuda Dive','Claw','Axe Kick','Shock Strike','Camisado','Regal Scratch','Poison Nails',
        'Moonlit Charge','Crescent Fang','Rock Buster','Tail Whip','Double Punch','Megalith Throw','Double Slap','Eclipse Bite','Mountain Buster',
        'Spinning Dive','Predator Claws','Rush','Chaotic Strike','Crag Throw','Volt Strike','Hysteric Assault','Welt','Roundhouse'
    }
    
    bp_hybrid=S{'Burning Strike','Flaming Crush'}
    
    enticersRagePacts = S{
        'Impact','Conflag Strike', 'Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II',
        'Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV'
    }
    physicalEnticersRagePacts = S{
        'Mountain Buster','Rock Buster','Crescent Fang','Eclipse Bite','Blindside'
    }
    meritPacts = S{
        'Heavenly Strike','Wind Blade','Geocrush','Thunderstorm','Meteor Strike','Grand Fall'
    }
    enticersWardPacts = S{
        'HealingRuby II','Healing Ruby'
    }
    healingWardPacts = S{
        'HealingRuby II','Healing Ruby'
    }
    hybridPacts = S{
        'Flaming Crush'
    }

    pacts = {}
    pacts.cure = {['Carbuncle']='Healing Ruby'}
    pacts.curaga = {['Carbuncle']='Healing Ruby II', ['Garuda']='Whispering Wind', ['Leviathan']='Spring Water'}
    pacts.buffoffense = {['Carbuncle']='Glittering Ruby', ['Ifrit']='Crimson Howl', ['Garuda']='Hastega', ['Garuda']='Hastega II', ['Ramuh']='Rolling Thunder',
        ['Fenrir']='Ecliptic Growl', ['Siren']='Katabatic Blades'}
    pacts.buffdefense = {['Carbuncle']='Shining Ruby', ['Shiva']='Frost Armor', ['Garuda']='Aerial Armor', ['Titan']='Earthen Ward',
        ['Ramuh']='Lightning Armor', ['Fenrir']='Ecliptic Howl', ['Diabolos']='Noctoshield', ['Cait Sith']='Reraise II',['Siren']='Chinook'}
 
    pacts.buffspecial = {['Ifrit']='Inferno Howl', ['Garuda']='Fleet Wind', ['Titan']='Earthen Armor', ['Diabolos']='Dream Shroud',
        ['Carbuncle']='Soothing Ruby',['Carbuncle']='Pacifying ruby', ['Shiva']='Crystal blessing',['Fenrir']='Heavenward Howl', ['Leviathan']='Soothing current',['Cait Sith']='Raise II',['Siren']='Wind\'s Blessing'}
 
    pacts.debuff1 = {['Shiva']='Diamond Storm', ['Ramuh']='Shock Squall', ['Leviathan']='Tidal Roar', ['Fenrir']='Lunar Cry',
        ['Diabolos']='Pavor Nocturnus', ['Cait Sith']='Eerie Eye',['Carbuncle']='Soothing Ruby', ['Siren']='Lunatic Voice'}
    pacts.debuff2 = {['Leviathan']='Slowga', ['Fenrir']='Lunar Roar', ['Diabolos']='Somnolence',['Siren']='Bitter Elegy'}
    pacts.sleep = {['Shiva']='Sleepga', ['Diabolos']='Nightmare', ['Cait Sith']='Mewing Lullaby'}
    pacts.nuke2 = {['Ifrit']='Fire II', ['Shiva']='Blizzard II', ['Garuda']='Aero II', ['Titan']='Stone II',
        ['Ramuh']='Thunder II', ['Leviathan']='Water II',['Siren']='Welt'}
    pacts.nuke4 = {['Ifrit']='Fire IV', ['Shiva']='Blizzard IV', ['Garuda']='Aero IV', ['Titan']='Stone IV',
        ['Ramuh']='Thunder IV', ['Leviathan']='Water IV',['Fenrir']='Crescent Fang',['Siren']='Roundhouse'}
    pacts.bp70 = {
        ['Ifrit']='Flaming Crush', ['Shiva']='Rush', ['Garuda']='Predator Claws', ['Titan']='Mountain Buster',
        ['Ramuh']='Chaotic Strike', ['Leviathan']='Spinning Dive', ['Carbuncle']='Meteorite', ['Fenrir']='Eclipse Bite',
        ['Diabolos']='Nether Blast',['Cait Sith']='Regal Scratch',['Siren']='Sonic Buffet'
    }
    pacts.bp75 = {['Ifrit']='Meteor Strike', ['Shiva']='Heavenly Strike', ['Garuda']='Wind Blade', ['Titan']='Geocrush',
        ['Ramuh']='Thunderstorm', ['Leviathan']='Grand Fall', ['Carbuncle']='Holy Mist', ['Fenrir']='Lunar Bay',
        ['Diabolos']='Night Terror', ['Cait Sith']='Level ? Holy',['Siren']='Tornado II'}
    pacts.astralflow = {['Ifrit']='Inferno', ['Shiva']='Diamond Dust', ['Garuda']='Aerial Blast', ['Titan']='Earthen Fury',
        ['Ramuh']='Judgment Bolt', ['Leviathan']='Tidal Wave', ['Carbuncle']='Searing Light', ['Fenrir']='Howling Moon',
        ['Diabolos']='Ruinous Omen', ['Cait Sith']="Altana's Favor",['Siren']='Clarsach Call'}
    pacts.bprage1 = {['Fenrir']='Impact',['Ramuh']='Volt Strike',['Cait Sith']='Regal Gash',['Carbuncle']='Poison Nails',['Ifrit']='Conflag Strike',['Titan']='Crag Throw',['Diabolos']='Blindside',['Leviathan']='Tail Whip',['Siren']='Hysteric Assault'}



    -- Wards table for creating custom timers   
    wards = {}
    -- Base duration for ward pacts.
    wards.durations = {
        ['Crimson Howl'] = 60, ['Earthen Armor'] = 60, ['Inferno Howl'] = 60, ['Heavenward Howl'] = 60,
        ['Rolling Thunder'] = 120, ['Fleet Wind'] = 120,
        ['Shining Ruby'] = 180, ['Frost Armor'] = 180, ['Lightning Armor'] = 180, ['Ecliptic Growl'] = 180,
        ['Glittering Ruby'] = 180, ['Hastega'] = 180, ['Noctoshield'] = 180, ['Ecliptic Howl'] = 180,
        ['Dream Shroud'] = 180,
        ['Reraise II'] = 3600
    }
    -- Icons to use when creating the custom timer.
    wards.icons = {
        ['Earthen Armor']   = 'spells/00299.png', -- 00299 for Titan
        ['Shining Ruby']    = 'spells/00043.png', -- 00043 for Protect
        ['Dream Shroud']    = 'spells/00304.png', -- 00304 for Diabolos
        ['Noctoshield']     = 'spells/00106.png', -- 00106 for Phalanx
        ['Inferno Howl']    = 'spells/00298.png', -- 00298 for Ifrit
        ['Hastega']         = 'spells/00358.png', -- 00358 for Hastega
        ['Rolling Thunder'] = 'spells/00104.png', -- 00358 for Enthunder
        ['Frost Armor']     = 'spells/00250.png', -- 00250 for Ice Spikes
        ['Lightning Armor'] = 'spells/00251.png', -- 00251 for Shock Spikes
        ['Reraise II']      = 'spells/00135.png', -- 00135 for Reraise
        ['Fleet Wind']      = 'abilities/00074.png', -- 
    }
    -- Flags for code to get around the issue of slow skill updates.
    wards.flag = false
    wards.spell = ''

    on_job_change()
        
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    gear.perp_staff = {name=""}
    
    --select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast Sets
    --------------------------------------

    gear.SmnCPHY = {name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20',}}
    gear.SmnBPD = {name="Conveyance Cape", augments={'Summoning magic skill +2','Pet: Enmity+14','Blood Pact ab. del. II -3',}}
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Astral Flow'] = {}
    
    sets.precast.JA['Elemental Siphon'] = {right_ring="Zodiac Ring",}

    sets.precast.JA['Mana Cede'] = {}

    -- Pact delay reduction gear
    sets.precast.BloodPactWard = {
    main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
    sub="Vox Grip",
    ammo="Sancus Sachet",
    neck="Incanter's Torque",
    head="Beckoner's Horn +1",
    body="Con. Doublet +2",
    hands="Lamassu Mitts +1",
    legs={ name="Glyphic Spats +1", augments={'Increases Sp. "Blood Pact" accuracy',}},
    feet={ name="Glyph. Pigaches +1", augments={'Inc. Sp. "Blood Pact" magic crit. dmg.',}},
    waist="Lucidity Sash",
    left_ear="Lodurr Earring",
    right_ear="Andoaa Earring",
    left_ring="Evoker's Ring",
    back=gear.SmnBPD,
    }

    sets.precast.BloodPactRage = sets.precast.BloodPactWard

    -- Fast cast sets for spells
    
    sets.precast.FC = {
    main={ name="Malevolence", augments={'INT+10','Mag. Acc.+10','"Mag.Atk.Bns."+10','"Fast Cast"+5',}},
    ammo="Sancus Sachet",
    head="Nahtirah Hat",
    legs={ name="Lengo Pants", augments={'INT+7','Mag. Acc.+7','"Mag.Atk.Bns."+3','"Refresh"+1',}},
    feet=gear.MerlFFC,
    waist="Embla Sash",
    left_ear="Malignance Earring",
    left_ring="Kishar Ring",
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
    legs="Tali'ah Seraweels",
    feet="Battlecast Gaiters",
    neck="Sanctity Necklace",
    waist="Life Belt",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Apate Ring",
    right_ring="Beeline Ring",
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {}

    sets.midcast.Cure = {}

    sets.midcast.Stoneskin = {}

    sets.midcast['Elemental Magic'] = {}

    sets.midcast['Dark Magic'] = {}


    -- Avatar pact sets.  All pacts are Ability type.
    
    sets.midcast.Pet.BloodPactWard = {}

    sets.midcast.Pet.DebuffBloodPactWard = {}

    sets.midcast.Pet.DebuffBloodPactWard.Acc = set_combine(sets.midcast.Pet.DebuffBloodPactWard, {})

    sets.midcast.Pet.PhysicalBP = {
    main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
    sub="Elan Strap",
    ammo="Sancus Sachet",
    head={ name="Apogee Crown", augments={'MP+60','Pet: Attack+30','Blood Pact Dmg.+7',}},
    body="Con. Doublet +2",
    hands=gear.MerlGPBP,
    legs={ name="Apogee Slacks", augments={'Pet: STR+15','Blood Pact Dmg.+13','Pet: "Dbl. Atk."+3',}},
    feet={ name="Apogee Pumps", augments={'MP+60','Pet: Attack+30','Blood Pact Dmg.+7',}},
    neck="Adad Amulet",
    waist="Incarnation Sash",
    left_ear="Esper Earring",
    right_ear="Lugalbanda Earring",
    left_ring="Varar Ring",
    right_ring="Varar Ring",
    back=gear.SmnCPHY,
    }

    sets.midcast.Pet.PhysicalBP.Acc = sets.midcast.Pet.PhysicalBP

    sets.midcast.Pet.HybridBP = {
    main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
    sub="Elan Strap",
    ammo="Sancus Sachet",
    head={ name="Apogee Crown", augments={'MP+60','Pet: Attack+30','Blood Pact Dmg.+7',}},
    body="Con. Doublet +2",
    hands=gear.MerlGPBP,
    legs={ name="Apogee Slacks", augments={'Pet: STR+15','Blood Pact Dmg.+13','Pet: "Dbl. Atk."+3',}},
    feet={ name="Apogee Pumps", augments={'MP+60','Pet: Attack+30','Blood Pact Dmg.+7',}},
    neck="Adad Amulet",
    waist="Regal Belt",
    left_ear="Esper Earring",
    right_ear="Lugalbanda Earring",
    left_ring="Varar Ring",
    right_ring="Varar Ring",
    back=gear.SmnCPHY,
    }
    
    sets.midcast.Pet.HybridBP.Acc = sets.midcast.Pet.HybridBP
    
    sets.midcast.Pet.MagicalBP = {
    main={name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
    sub="Elan Strap",
    ammo="Sancus Sachet",
    head="Con. Horn +1",
    body="Con. Doublet +2",
    hands="Lamassu Mitts +1",
    legs=gear.EnticeMBP,
    feet="Con. Pigaches +1",
    neck="Adad Amulet",
    waist="Regal Belt",
    left_ear="Esper Earring",
    right_ear="Lugalbanda Earring",
    left_ring="Varar Ring",
    right_ring="Varar Ring",
    back=gear.SmnCPHY,
    }

    sets.midcast.Pet.MagicalBP.Acc = sets.midcast.Pet.MagicalBP

    -- Spirits cast magic spells, which can be identified in standard ways.
    
    sets.midcast.Pet.WhiteMagic = {}
    
    sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.BloodPactRage, {})

    sets.midcast.Pet['Elemental Magic'].Resistant = {}
    

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {}

    -- Idle sets
    sets.idle = {}

    sets.idle.PDT = {}

    -- perp costs:
    -- spirits: 7
    -- carby: 11 (5 with mitts)
    -- fenrir: 13
    -- others: 15
    -- avatar's favor: -4/tick
    
    -- Max useful -perp gear is 1 less than the perp cost (can't be reduced below 1)
    -- Aim for -14 perp, and refresh in other slots.
    
    -- -perp gear:
    -- Gridarvor: -5
    -- Glyphic Horn: -4
    -- Caller's Doublet +2/Glyphic Doublet: -4
    -- Evoker's Ring: -1
    -- Convoker's Pigaches: -4
    -- total: -18
    
    -- Can make due without either the head or the body, and use +refresh items in those slots.
    
    sets.idle.Avatar = {
    main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
    ammo="Sancus Sachet",
    head="Con. Horn +1",
    body="Con. Doublet +2",
    hands="Lamassu Mitts +1",
    legs="Assid. Pants +1",
    feet="Apogee Pumps",
    neck="Caller's Pendant",
    waist="Lucidity Sash",
    left_ear="Evans Earring",
    right_ear="Lugalbanda Earring",
    left_ring="Evoker's Ring",
    right_ring="Kishar Ring",
    back=gear.SmnCPHY,
    }
    
    sets.idle.AvatarCP = set_combine(sets.idle.Avatar, {back=gear.CPCape,})
    sets.idle.PDT.Avatar = set_combine(sets.idle.Avatar, {main="Malignance Pole",neck="Loricate Torque +1",})

    sets.idle.Spirit = {}
    
    sets.idle.SpiritCP = {back=gear.CPCape,}

    sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})

    -- Favor uses Caller's Horn instead of Convoker's Horn for refresh
    sets.idle.Avatar.Favor = set_combine(sets.idle.Avatar, {})
    
    sets.idle.Avatar.Melee = {
    main={ name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}},
    ammo="Sancus Sachet",
    head="Con. Horn +1",
    body="Con. Doublet +2",
    hands="Lamassu Mitts +1",
    legs="Assid. Pants +1",
    feet="Con. Pigaches +1",
    neck="Caller's Pendant",
    waist="Lucidity Sash",
    left_ear="Evans Earring",
    right_ear="Lugalbanda Earring",
    left_ring="Evoker's Ring",
    right_ring="Kishar Ring",
    back=gear.SmnCPHY,
    }
    
    sets.idle.Avatar.MeleeCP = set_combine(sets.idle.Avatar.Melee, {back=gear.CPCape,})
    
    sets.perp = {}
    -- Caller's Bracer's halve the perp cost after other costs are accounted for.
    -- Using -10 (Gridavor, ring, Conv.feet), standard avatars would then cost 5, halved to 2.
    -- We can then use Hagondes Coat and end up with the same net MP cost, but significantly better defense.
    -- Weather is the same, but we can also use the latent on the pendant to negate the last point lost.
    sets.perp.Day = {}
    sets.perp.Weather = {}
    -- Carby: Mitts+Conv.feet = 1/tick perp.  Everything else should be +refresh
    sets.perp.Carbuncle = {}
    -- Diabolos's Rope doesn't gain us anything at this time
    --sets.perp.Diabolos = {waist="Diabolos's Rope"}
    sets.perp.Alexander = sets.midcast.Pet.BloodPactWard

    sets.perp.staff_and_grip = {}
    
    -- Defense sets
    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.Kiting = {}
    
    sets.latent_refresh = {}
    

    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    -- Normal melee group
    sets.engaged = {
    ammo="Sancus Sachet",
    head="Con. Horn +1",
    body="Con. Doublet +2",
    hands="Lamassu Mitts +1",
    legs="Assid. Pants +1",
    feet="Con. Pigaches +1",
    neck="Caller's Pendant",
    waist="Lucidity Sash",
    left_ear="Evans Earring",
    right_ear="Lugalbanda Earring",
    left_ring="Evoker's Ring",
    right_ring="Kishar Ring",
    back=gear.SmnCPHY,
    }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

-- Runs when pet completes an action.
function job_pet_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.type == 'BloodPactWard' and spellMap ~= 'DebuffBloodPactWard' then
        wards.flag = true
        wards.spell = spell.english
        send_command('wait 4; gs c reset_ward_flag')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    elseif storms:contains(buff) then
        handle_equipping_gear(player.status)
    end
end


-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
        handle_equipping_gear(player.status, newStatus)
    end
end


-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    classes.CustomIdleGroups:clear()
    if gain then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    else
        --select_default_macro_book('reset')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell)
    if spell.type == 'BloodPactRage' then
        --[[if magicalRagePacts:contains(spell.english) then
            return 'MagicalBloodPactRage'
        else
            return 'PhysicalBloodPactRage'
        end]]
        if bp_physical:contains(spell.name) then
            return 'PhysicalBP'
        elseif bp_hybrid:contains(spell.name) then
            return 'HybridBP'
        elseif bp_magical:contains(spell.name) then
            return 'MagicalBP'
        end
    elseif spell.type == 'BloodPactWard' and spell.target.type == 'MONSTER' then
        return 'DebuffBloodPactWard'
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if pet.isvalid then
        if pet.element == world.day_element then
            idleSet = set_combine(idleSet, sets.perp.Day)
        end
        if pet.element == world.weather_element then
            idleSet = set_combine(idleSet, sets.perp.Weather)
        end
        if sets.perp[pet.name] then
            idleSet = set_combine(idleSet, sets.perp[pet.name])
        end
        gear.perp_staff.name = elements.perpetuance_staff_of[pet.element]
        if gear.perp_staff.name and (player.inventory[gear.perp_staff.name] or player.wardrobe[gear.perp_staff.name]) then
            idleSet = set_combine(idleSet, sets.perp.staff_and_grip)
        end
        if state.Buff["Avatar's Favor"] and avatars:contains(pet.name) then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Favor)
        end
        if pet.status == 'Engaged' and state.CapacityMode.value then
            idleSet = set_combine(idleSet, sets.idle.Avatar.MeleeCP)
        elseif pet.status == 'Engaged' then
            idleSet = set_combine(idleSet, sets.idle.Avatar.Melee)
        end
    end
    
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'petweather' then
        handle_petweather()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'siphon' then
        handle_siphoning()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'bprc' then
        handle_bprc()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'bpwc' then
        handle_bpwc()
        eventArgs.handled = true
    elseif cmdParams[1] == 'reset_ward_flag' then
        wards.flag = false
        wards.spell = ''
        eventArgs.handled = true
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Cast BP based on summon. Grouped most common BPs together
function handle_bprc()
    if pet.isvalid and avatars:contains(pet.name) then
        if pet.name == "Ifrit" then
            send_command('@input /pet "Flaming Crush" <t>')
        elseif pet.name == "Ramuh" then
            send_command('@input /pet "Volt Strike" <t>')
        elseif pet.name == "Siren" then
            send_command('@input /pet "Hysteric Assault" <t>')
        elseif pet.name == "Garuda" then
            send_command('@input /pet "Predator Claws" <t>')
        elseif pet.name == "Carbuncle" then
            send_command('@input /pet "Meteorite" <t>')
        elseif pet.name == "Cait Sith" then
            send_command('@input /pet "Regal Scratch" <t>')
        elseif pet.name == "Fenrir" then
            send_command('@input /pet "Eclipse Bite" <t>')
        elseif pet.name == "Titan" then
            send_command('@input /pet "Mountain Buster" <t>')
        elseif pet.name == "Leviathan" then
            send_command('@input /pet "Spinning Dive" <t>')
        elseif pet.name == "Shiva" then
            send_command('@input /pet "Rush" <t>')
        elseif pet.name == "Diabolos" then
            send_command('@input /pet "Night Terror" <t>')
        else
            add_to_chat(122, "No Blood Pact: Rage set for this summon")
        end
    else
        add_to_chat(122, 'No pet summoned.')
    end
end

function handle_bpwc()
    if pet.isvalid and avatars:contains(pet.name) then
        if pet.name == "Ifrit" then
            send_command('@input /pet "Crimson Howl" <me>')
        elseif pet.name == "Ramuh" then
            send_command('@input /pet "Lightning Armor" <me>')
        elseif pet.name == "Siren" then
            send_command('@input /pet "Wind\'s Blessing" <me>')
        elseif pet.name == "Garuda" then
            send_command('@input /pet "Hastega II" <me>')
        elseif pet.name == "Carbuncle" then
            send_command('@input /pet "Shining Ruby" <me>')
        elseif pet.name == "Cait Sith" then
            send_command('@input /pet "Mewing Lulaby" <t>')
        elseif pet.name == "Fenrir" then
            send_command('@input /pet "Ecliptic Growl" <me>')
        elseif pet.name == "Titan" then
            send_command('@input /pet "Earthen Armor" <me>')
        elseif pet.name == "Leviathan" then
            send_command('@input /pet "Soothing Current" <me>')
        elseif pet.name == "Shiva" then
            send_command('@input /pet "Crystal Blessing" <me>')
        elseif pet.name == "Diabolos" then
            send_command('@input /pet "Noctoshield" <me>')
        else
            add_to_chat(122, "No Blood Pact: Ward set for this summon")
        end
    else
        add_to_chat(122, 'No pet summoned.')
    end
end

-- Cast the appopriate storm for the currently summoned avatar, if possible.
function handle_petweather()
    if player.sub_job ~= 'SCH' then
        add_to_chat(122, "You can not cast storm spells")
        return
    end
        
    if not pet.isvalid then
        add_to_chat(122, "You do not have an active avatar.")
        return
    end
    
    local element = pet.element
    if element == 'Thunder' then
        element = 'Lightning'
    end
    
    if S{'Light','Dark','Lightning'}:contains(element) then
        add_to_chat(122, 'You do not have access to '..elements.storm_of[element]..'.')
        return
    end 
    
    local storm = elements.storm_of[element]
    
    if storm then
        send_command('@input /ma "'..elements.storm_of[element]..'" <me>')
    else
        add_to_chat(123, 'Error: Unknown element ('..tostring(element)..')')
    end
end


-- Custom uber-handling of Elemental Siphon
function handle_siphoning()
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'Cannot use Elemental Siphon in a city area.')
        return
    end

    local siphonElement
    local stormElementToUse
    local releasedAvatar
    local dontRelease
    
    -- If we already have a spirit out, just use that.
    if pet.isvalid and spirits:contains(pet.name) then
        siphonElement = pet.element
        dontRelease = true
        -- If current weather doesn't match the spirit, but the spirit matches the day, try to cast the storm.
        if player.sub_job == 'SCH' and pet.element == world.day_element and pet.element ~= world.weather_element then
            if not S{'Light','Dark','Lightning'}:contains(pet.element) then
                stormElementToUse = pet.element
            end
        end
    -- If we're subbing /sch, there are some conditions where we want to make sure specific weather is up.
    -- If current (single) weather is opposed by the current day, we want to change the weather to match
    -- the current day, if possible.
    elseif player.sub_job == 'SCH' and world.weather_element ~= 'None' then
        -- We can override single-intensity weather; leave double weather alone, since even if
        -- it's partially countered by the day, it's not worth changing.
        if get_weather_intensity() == 1 then
            -- If current weather is weak to the current day, it cancels the benefits for
            -- siphon.  Change it to the day's weather if possible (+0 to +20%), or any non-weak
            -- weather if not.
            -- If the current weather matches the current avatar's element (being used to reduce
            -- perpetuation), don't change it; just accept the penalty on Siphon.
            if world.weather_element == elements.weak_to[world.day_element] and
                (not pet.isvalid or world.weather_element ~= pet.element) then
                -- We can't cast lightning/dark/light weather, so use a neutral element
                if S{'Light','Dark','Lightning'}:contains(world.day_element) then
                    stormElementToUse = 'Wind'
                else
                    stormElementToUse = world.day_element
                end
            end
        end
    end
    
    -- If we decided to use a storm, set that as the spirit element to cast.
    if stormElementToUse then
        siphonElement = stormElementToUse
    elseif world.weather_element ~= 'None' and (get_weather_intensity() == 2 or world.weather_element ~= elements.weak_to[world.day_element]) then
        siphonElement = world.weather_element
    else
        siphonElement = world.day_element
    end
    
    local command = ''
    local releaseWait = 0
    
    if pet.isvalid and avatars:contains(pet.name) then
        command = command..'input /pet "Release" <me>;wait 1.1;'
        releasedAvatar = pet.name
        releaseWait = 10
    end
    
    if stormElementToUse then
        command = command..'input /ma "'..elements.storm_of[stormElementToUse]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    if not (pet.isvalid and spirits:contains(pet.name)) then
        command = command..'input /ma "'..elements.spirit_of[siphonElement]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    command = command..'input /ja "Elemental Siphon" <me>;'
    releaseWait = releaseWait - 1
    releaseWait = releaseWait + 0.1
    
    if not dontRelease then
        if releaseWait > 0 then
            command = command..'wait '..tostring(releaseWait)..';'
        else
            command = command..'wait 1.1;'
        end
        
        command = command..'input /pet "Release" <me>;'
    end
    
    if releasedAvatar then
        command = command..'wait 1.1;input /ma "'..releasedAvatar..'" <me>'
    end
    
    send_command(command)
end


-- Handles executing blood pacts in a generic, avatar-agnostic way.
-- cmdParams is the split of the self-command.
-- gs c [pact] [pacttype]
--[[function handle_pacts(cmdParams)
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'You cannot use pacts in town.')
        return
    end

    if not pet.isvalid then
        add_to_chat(122,'No avatar currently available. Returning to default macro set.')
        select_default_macro_book('reset')
        return
    end

    if spirits:contains(pet.name) then
        add_to_chat(122,'Cannot use pacts with spirits.')
        return
    end

    if not cmdParams[2] then
        add_to_chat(123,'No pact type given.')
        return
    end
    
    local pact = cmdParams[2]:lower()
    
    if not pacts[pact] then
        add_to_chat(123,'Unknown pact type: '..tostring(pact))
        return
    end
    
    if pacts[pact][pet.name] then
        if pact == 'astralflow' and not buffactive['astral flow'] then
            add_to_chat(122,'Cannot use Astral Flow pacts at this time.')
            return
        end
        
        -- Leave out target; let Shortcuts auto-determine it.
        send_command('@input /pet "'..pacts[pact][pet.name]..'"')
    else
        add_to_chat(122,pet.name..' does not have a pact of type ['..pact..'].')
    end
end]]


-- Event handler for updates to player skill, since we can't rely on skill being
-- correct at pet_aftercast for the creation of custom timers.
windower.raw_register_event('incoming chunk',
    function (id)
        if id == 0x62 then
            if wards.flag then
                create_pact_timer(wards.spell)
                wards.flag = false
                wards.spell = ''
            end
        end
    end)

-- Function to create custom timers using the Timers addon.  Calculates ward duration
-- based on player skill and base pact duration (defined in job_setup).
function create_pact_timer(spell_name)
    -- Create custom timers for ward pacts.
    if wards.durations[spell_name] then
        local ward_duration = wards.durations[spell_name]
        if ward_duration < 181 then
            local skill = player.skills.summoning_magic
            if skill > 300 then
                skill = skill - 300
                if skill > 200 then skill = 200 end
                ward_duration = ward_duration + skill
            end
        end
        
        local timer_cmd = 'timers c "'..spell_name..'" '..tostring(ward_duration)..' down'
        
        if wards.icons[spell_name] then
            timer_cmd = timer_cmd..' '..wards.icons[spell_name]
        end

        send_command(timer_cmd)
    end
end


-- Select default macro book on initial load or subjob change.
function on_job_change()
    set_macro_page(1, 15)
    send_command('wait 5;input /lockstyleset 98')
end
