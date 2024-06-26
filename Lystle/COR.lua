--[[
    Lua specific commands:
        rollcmd
            Modifiers:
            1 or 2
                cycle
                    forward or back 
                set
                    first part of the roll's name    
                roll

        qdraw

    Example macros:
        /console gs c rollcmd 1 roll
        /console gs c qdraw
        /console gs c rollcmd 2 cycle forward - (this is also bound to a hotkey, see below)
        /console gs c rollcmd 2 set Fighter's
        /console gs c rollcmd 1 set Puppet

    Lua specific binds
        ctrl + ` = roll 1 cycle forward
        ctrl + shift + ` = roll 1 cycle backwards
        alt + ` = roll 2 cycle forward
        alt + shift + ` = roll 2 cycle backwards
        windows key + ` = cycle quickdraw element forwards
        windows key + shift + ` = cycle quickdraw element backwards
]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- Initialize roll tracking states
    state.roll1 = M{['description'] = 'Roll 1'}
    state.roll2 = M{['description'] = 'Roll 2'}
    
    -- Initialize Quick Draw state
    state.QDrawElement = M{['description'] = 'Quick Draw Element'}

    -- Add Rolls to roll tracking state
    state.roll1:options("Corsair's Roll", "Ninja Roll", "Hunter's Roll", "Chaos Roll", "Magus's Roll", "Healer's Roll", "Puppet Roll",
    "Choral Roll", "Monk's Roll", "Beast Roll", "Samurai Roll", "Evoker's Roll", "Rogue's Roll", "Warlock's Roll", "Fighter's Roll", 
    "Drachen Roll", "Gallant's Roll", "Wizard's Roll", "Dancer's Roll", "Scholar's Roll", "Bolter's Roll", "Caster's Roll", 
    "Courser's Roll" ,"Blitzer's Roll", "Tactician's Roll", "Allies's Roll", "Miser's Roll", "Companion's Roll", "Avenger's Roll")
    state.roll2:options("Corsair's Roll", "Ninja Roll", "Hunter's Roll", "Chaos Roll", "Magus's Roll", "Healer's Roll", "Puppet Roll",
    "Choral Roll", "Monk's Roll", "Beast Roll", "Samurai Roll", "Evoker's Roll", "Rogue's Roll", "Warlock's Roll", "Fighter's Roll", 
    "Drachen Roll", "Gallant's Roll", "Wizard's Roll", "Dancer's Roll", "Scholar's Roll", "Bolter's Roll", "Caster's Roll", 
    "Courser's Roll" ,"Blitzer's Roll", "Tactician's Roll", "Allies's Roll", "Miser's Roll", "Companion's Roll", "Avenger's Roll")
        
    -- Add Quick Draw Element
    state.QDrawElement:options("Light", "Dark", "Fire", "Water", "Thunder", "Earth", "Wind", "Ice")

    -- Sets default roll states on lua load
    state.roll1:set("Chaos Roll")
    state.roll2:set("Samurai Roll")

    -- set default shot
    state.QDrawElement:set("Light")
    
    state.delayMod = M{'none', 'Samba'}
    state.delayMod:set('none')
    define_roll_values()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
    
    -- Additional local binds
    send_command('bind ^` gs c rollcmd 1 cycle forward')
    send_command('bind !` gs c rollcmd 2 cycle forward')
    send_command('bind @= gs c cycle delayMod')
    send_command('bind @` gs c cycle QDrawElement')
    send_command('bind ~^` gs c rollcmd 1 cycle back')
    send_command('bind ~!` gs c rollcmd 2 cycle back')
    send_command('bind ~@` gs c cycleback QDrawElement')

    on_job_change()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @=')
    send_command('unbind @`')
    send_command('unbind ~^`')
    send_command('unbind ~!`')
    send_command('unbind ~@`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    -- Define job specific gear
    
    --gear.TPAmmo = "Voluspa Bullet"
    --gear.PWSAmmo = gear.TPAmmo
    --gear.MWSAmmo = "Orichalc. Bullet"
    --gear.QDrawAmmo = "Hauksbok Bullet"
    --gear.CorAGI = {name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
    --gear.CorRTP = {name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    
    -- Precast sets to enhance JAs
    
    --sets.precast.JA['Triple Shot'] = {body="Navarch's Frac +2"}
    --sets.precast.JA['Snake Eye'] = {legs="Lanun Culottes"}
    --sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +2"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +1"}

    
    sets.precast.CorsairRoll = {
        --main="Lanun Knife",
        range="Compensator",
        ammo=empty,
        head={ name="Lanun Tricorne", augments={'Enhances "Winning Streak" effect',}},
        hands="Chasseur's Gants +2",
        left_ring="Luzaf's Ring",
        right_ring="Barataria Ring",
        back="Camulus's Mantle",
    }
    
    --sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Navarch's Culottes +2"})
    --sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Navarch's Bottes +2"})
    --sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Navarch's Tricorne +2"})
    --sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Navarch's Frac +2"})
    --sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Navarch's Gants +2"})
    
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +1"}
    
    sets.precast.CorsairShot = {head="Blood Mask"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

    sets.precast.RA = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        --ammo="Oshasha's Treatise",
        head="Mummu Bonnet +2",
        body="Mummu Jacket +2",
        hands="Chasseur's Gants +2",
        legs="Meg. Chausses +2",
        feet="Mummu Gamash. +2",
        neck="Clotharius Torque",
        waist="Dynamic Belt",
        left_ear="Bladeborn Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Begrudging Ring",
        right_ring="Rajas Ring",
    }


    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS,{})

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS,{})

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Last Stand'] = {}

    sets.precast.WS['Last Stand'].Acc = {}
       
    sets.precast.WS['Wildfire'] = {}

    sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], {head="Pixie Hairpin +1"})

    -- Midcast Sets
    sets.midcast.FastRecast = {}
        
    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.CorsairShot = {}

    sets.midcast.CorsairShot.Acc = {}

    sets.midcast.CorsairShot['Light Shot'] = set_combine(sets.midcast.CorsairShot, {})

    sets.midcast.CorsairShot['Dark Shot'] = set_combine(sets.midcast.CorsairShot['Light Shot'], {head="Pixie Hairpin +1"})


    -- Ranged gear
    sets.midcast.RA = {}

    sets.midcast.RA.Acc = {}

    --[[sets.midcast['Dia']={
        main="Tauret",
        ammo="Ghastly Tathlum",
        head={ name="Nyame Helm", augments={'Path: B',}},
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands="Nyame Gauntlets",
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet="Nyame Sollerets",
        neck="Sibyl Scarf",
        waist="Korin Obi",
        left_ear="Hermetic Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Crepuscular Ring",
        right_ring="Defending Ring",
        back="Camulus's Mantle",
    }]]

    
    -- Sets to return to when not performing an action.
    
    -- Idle sets
    sets.idle = {
        head="Nyame Helm",
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands="Malignance Gloves",
        legs="Carmine Cuisses +1",
        feet="Nyame Sollerets",
        neck="Loricate Torque",
        right_ring="Defending Ring",
        right_ring="Shneddick Ring",
    }

    sets.idle.Town = set_combine(sets.idle,{body="Councilor's Garb",})
    
    -- Defense sets
    sets.defense.PDT = {
        head="Nyame Helm",
        body={ name="Nyame Mail", augments={'Path: B',}},
        hands="Malignance Gloves",
        legs={ name="Nyame Flanchard", augments={'Path: B',}},
        feet="Nyame Sollerets",
        neck="Loricate Torque",
        right_ring="Defending Ring",
        right_ring="Shneddick Ring",
    }

    sets.defense.MDT = {}
    

    sets.Kiting = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head="Mummu Bonnet +2",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Meg. Chausses +2",
        feet="Mummu Gamash. +2",
        neck="Lissome Necklace",
        waist="Dynamic Belt",
        left_ear="Tripudio Earring",
        right_ear="Crep. Earring",
        left_ring="Lehko's Ring",
        right_ring="Rajas Ring",
        back="Atheling Mantle",
    }

    sets.engaged.MaxHaste = set_combine(sets.engaged, {})

    sets.engaged.HighHaste = set_combine(sets.engaged, {})

    sets.engaged.MidHaste = set_combine(sets.engaged, {})

    sets.engaged.LowHaste = set_combine(sets.engaged, {})
    
    sets.engaged.Acc = set_combine(sets.engaged, {})

    sets.engaged.DW = set_combine(sets.engaged, {})

    sets.engaged.DW.MaxHaste = set_combine(sets.engaged.DW, {
        waist='Shetal Stone',
        left_ear="Suppanomimi",
    })

    sets.engaged.DW.HighHaste = set_combine(sets.engaged.DW.MaxHaste, {})

    sets.engaged.DW.MidHaste = set_combine(sets.engaged.DW.HighHaste, {})

    sets.engaged.DW.LowHaste = set_combine(sets.engaged.DW.MidHaste, {})
    
    sets.engaged.Acc.DW = set_combine(sets.engaged.DW, {})
    
    sets.weatherbelt = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    
    if (spell.action_type == 'Ranged Attack' and player.equipment.ammo == "Hauksbok Bullet") or (spell.skill == 'Marksmanship'and player.equipment.ammo == "Hauksbok Bullet") then
        add_to_chat(104, 'Check ammo, trying to use Quick Draw ammunition for non-Quick Draw shot.  Cancelling.')
        eventArgs.cancel = true
    end
end

function job_post_precast(spell, action, spellMap)
    if world.weather_element == 'Dark'or world.day_element == 'Dark' then
        if spell.name == 'Leaden Salute' then
            equip(set_combine(sets.precast.WS["Leaden Salute"], sets.weatherbelt))
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
    if player.equipment.ammo == "Hauksbok Bullet" then
         equip({ammo=gear.TPAmmo})
    end    
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'qdraw' then
        handle_qdraw()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'rollcmd' then
        handle_roll(cmdParams[2],cmdParams[3],cmdParams[4])
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'sneaks' then
        if player.sub_job == 'WHM' then
            send_command('@input /ma sneak <me>')
        end
    elseif cmdParams[1]:lower() == 'invis' then
        if player.sub_job == 'WHM' then
            send_command('@input /ma invisible <me>')
        end
    end
end

function handle_qdraw()
    local element = state.QDrawElement.value
    
    send_command('@input /ja "'..element..' Shot" <t>')
end

function handle_roll(rollNumber, rollExecute, rollMod)
    if rollNumber == '1' then
        rollSelect = state.roll1
    elseif rollNumber == '2' then
        rollSelect = state.roll2
    else
        add_to_chat(167, 'Specify roll 1 or roll 2 by using "1" or "2"')
    end
   
    rollState = rollSelect.value
   
    if rollExecute:lower() == 'cycle' then
        if rollMod:lower() == 'back' then
            rollSelect:cycleback()
        elseif rollMod:lower() == 'forward' then
            rollSelect:cycle()
        else
            add_to_chat(167, 'Use "back" or "forward" to cycle through rolls')
        end

        rollState = rollSelect.value

        rollInfo = rolls[rollState]

        add_to_chat(122, 'Roll '..rollNumber..' set to '..rollState..' - Bonus Effect: '..rollInfo.bonus..'.')

    elseif rollExecute:lower() == 'roll' then
        local ability_recast = windower.ffxi.get_ability_recasts()
        
        if ability_recast[96] == 0 then
            send_command('@input /ja "Crooked Cards" <me>;wait 1;input /ja "'..rollState..'" <me>')
        else
            send_command('@input /ja "'..rollState..'" <me>')
        end

    elseif rollExecute:lower() == 'set' then
        if rollSelect:contains(''..rollMod..' Roll') then
            rollSelect:set(''..rollMod..' Roll')
            
            rollState = rollSelect.value

            rollInfo = rolls[rollState]
            
            add_to_chat(122, 'Roll '..rollNumber..' set to '..rollState..' - Bonus Effect: '..rollInfo.bonus..'.')
        else 
            add_to_chat(167, '"'..rollMod..' Roll" is an unkown roll')
        end
    else
        add_to_chat(167, 'Rollcmd options are: "roll", "cycle" or "set"')
    end
end

function display_states()
    roll1 = state.roll1.value
    roll2 = state.roll2.value

    rollinfo1 = rolls[roll1]
    rollinfo2 = rolls[roll2]

    add_to_chat(121, 'Roll 1 set to '..state.roll1.value..'.  Bonus effect: '..rollinfo1.bonus..'.')
    add_to_chat(121, 'Roll 2 set to '..state.roll2.value..'.  Bonus effect: '..rollinfo2.bonus..'.')
    add_to_chat(121, 'Quick Draw element set to '..state.QDrawElement.value..'.')
end
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    determine_haste_group()
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        state.Buff[buff] = gain
    elseif state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    
    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.QDrawElement.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(122, msg)

    display_states()

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    
    if rollinfo then
        add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.')
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end

function update_combat_form()
    if cf_check then --checks if cf_check() exists
        cf_check() -- Check for 2H, Single or Duel Wield, function is defined in the Lystle-Globals.lua
    end
end

function determine_haste_group()
    if buffactive['Haste Samba'] or state.delayMod.Value ~= 'none' then
        hasteSamba = 'Samba'
    else
        hasteSamba = false
    end

    classes.CustomMeleeGroups:clear()
    
    if (buffactive.haste and hasteSamba == 'Samba' and buffactive.march == 1) 
    or (buffactive.march == 2 and hasteSamba =='Samba') 
    or (buffactive.embrava and (buffactive.haste or buffactive.march) and hasteSamba) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif (buffactive.haste and buffactive.march) or (buffactive.march == 2) then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.haste and hasteSamba then
        classes.CustomMeleeGroups:append('MidHaste')
    elseif buffactive.haste then
        classes.CustomMeleeGroups:append('LowHaste')
    end
end

-- Select default macro book and lockstyle on initial load or subjob change.
function on_job_change()
    set_macro_page(1, 17)
    send_command('wait 5;input /lockstyleset 5')
end