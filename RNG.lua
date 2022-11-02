function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()
    unlimitedShotWS = S{"Trueflight", "Wildfire"}
    specialAmmoEquiped = false
end

function user_setup()

end

function user_unload()

end

function init_gear_sets()
    gear.TPAmmo = "Chrono Bullet"
    gear.PWSAmmo = gear.TPAmmo
    gear.MWSAmmo = "Orichalc. Bullet"
    gear.USMWSAmmo = "Hauksbok Bullet"
    gear.USPWSAmmo = "Hauksbok Arrow"

    sets.precast.FC = {}  -- Fast Cast Set

    sets.precast.RA = {
        ammo=gear.TPAmmo,
        hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
        legs={ name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}},
        feet="Meg. Jam. +2",
        waist="Yemaya Belt",
        left_ear="Crep. Earring",
        left_ring="Crepuscular Ring",
    }  -- Ranged delay reduction.  Ignore if uneeded, remove the first "--" to activate.

    sets.precast.WS = {}  -- General Weapon Skill Set

    sets.precast.WS['Wildfire'] = {
        ammo = gear.MWSAmmo,
        head = gear.HercHMWS,
        hands=gear.HercGMB,
        neck="Sanctity Necklace",
        waist="Yemaya Belt",
        left_ear="Friomisi Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Dingir Ring",
        right_ring="Ilabrat Ring",
    }

    sets.midcast = {} -- Casting Set

    sets.midcast.RA = {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Nyame Flanchard",
        feet="Meg. Jam. +2",
        neck="Sanctity Necklace",
        waist="Yemaya Belt",
        left_ear="Crep. Earring",
        right_ear="Volley Earring",
        left_ring="Dingir Ring",
        right_ring="Crepuscular Ring",
    } -- Ranged TP Set.  Ignore if uneeded, remove the first "--" to activate.

    -- sets.midcast['Spell Name or Magic Type'] = set_combine(sets.midcast, {gear goes here}) -- Specific casting set for a spell or magic type (ie. Enhancing Magic).  Ignore if uneeded, remove the first "--" to activate.

    sets.defense.PDT = {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Loricate Torque +1",
        left_ring="Defending Ring",
    }  -- Defense set, Press F10 to equip, Alt-F12 to unequip

    sets.idle = {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Carmine Cuisses +1",
        feet="Nyame Sollerets",
        neck="Sanctity Necklace",
        left_ring="Defending Ring",
        right_ring="Gelatinous Ring",
        back="Solemnity Cape",
    } -- Gear to stand around in.  Regen and\or Refresh sets work well here.  Ignore if uneeded, remove the first "--" to activate.

    sets.engaged = {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
        feet={ name="Herculean Boots", augments={'DEX+9','"Triple Atk."+3','Accuracy+11 Attack+11',}},
        neck="Lissome Necklace",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Crep. Earring",
        right_ear="Volley Earring",
        left_ring="Petrov Ring",
        right_ring="Hetairoi Ring",
        back="Solemnity Cape",
    } -- TP Set
 end

function job_precast(spell, action, spellMap, eventArgs)    
    if (spell.action_type == 'Ranged Attack' or spell.name == "Shadowbind" or spell.name == "Eagle Eye Shot" or spell.skill == 'Marksmanship') then
        if buffactive['Unlimited Shot'] and unlimitedShotWS:contains(spell.name) then
            add_to_chat(104, 'Unlimited Shot Active')
        elseif (player.equipment.ammo == "Hauksbok Bullet" or player.equipment.ammo == "Hauksbok Arrow") then
            add_to_chat(104, 'Check ammo, trying to use Special Ammo for normal shots.  Cancelling action and trying to equip TP ammo.')
            equip({ammo = gear.TPAmmo,})
            eventArgs.cancel = true
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if buffactive['Unlimited Shot'] and unlimitedShotWS:contains(spell.name) then
        equip({ammo = gear.USMWSAmmo,})
        specialAmmoEquiped = true
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if specialAmmoEquiped then
        equip({ammo = gear.TPAmmo,})
        specialAmmoEquiped = false
    end
end

-- Check for 2H, Single or Duel Wield
function update_combat_form()    
    if cf_check then --checks if cf_check() exists
        cf_check() -- Check for 2H, Single or Duel Wield, function is defined in the Dagna-Globals.lua
    end
end