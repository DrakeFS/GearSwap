--[[
    Lua specific commands:
        rollcmd
            Modifiers:
            1 or 2
                cycle
                    forward or back 
                roll
            qdraw

    Example macros:
        /console gs c rollcmd 1 roll
        /console gs c qdraw
        /console gs c rollcmd 2 cycle forward - (this is also bound to a hotkey)

    Lua specific binds
        ctrl + ` = roll 1 cycle forward
        ctrl + shift + ` = roll 1 cycle backwards
        alt + ` = roll 2 cycle forward
        alt + shift + ` = roll 2 cycle backwards
        windows key + ` = cycle quickdraw element
]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")
    
    -- Whether a warning has been given for low ammo
    state.warned = M(false)
    
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
    state.roll1:set("Samurai Roll")
    state.roll2:set("Fighter's Roll")

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
    send_command('bind ~@` gs c cycle QDrawElement')

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
    
    gear.TPAmmo = "Voluspa Bullet"
    gear.PWSAmmo = gear.TPAmmo
    gear.MWSAmmo = "Orichalc. Bullet"
    gear.QDrawAmmo = "Hauksbok Bullet"
    gear.CorAGI = {name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
    gear.CorRTP = {name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    
    -- Precast sets to enhance JAs
    
    sets.precast.JA['Triple Shot'] = {body="Navarch's Frac +2"}
    sets.precast.JA['Snake Eye'] = {legs="Lanun Culottes"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +2"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac"}

    
    sets.precast.CorsairRoll = {
        head={ name="Lanun Tricorne", augments={'Enhances "Winning Streak" effect',}},
        hands="Chasseur's Gants +1",
        left_ring="Luzaf's Ring",
        right_ring="Barataria Ring",
        back=gear.CorRTP,
    }
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Navarch's Culottes +2"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Navarch's Bottes +2"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Navarch's Tricorne +2"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Navarch's Frac +2"})
    --sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Navarch's Gants +2"})
    
    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +1"}
    
    --sets.precast.CorsairShot = {head="Blood Mask"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    sets.precast.RA = {
        ammo=gear.TPAmmo,
        head="Chass. Tricorne +1",
        body="Laksa. Frac +2",
        hands="Carmine Fin. Ga. +1",
        legs={ name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}},
        feet="Meg. Jam. +2",
        waist="Yemaya Belt",
    }

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo=gear.TPAmmo,
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +1",
        feet="Meg. Jam. +2",
        neck="Sanctity Necklace",
        waist="Windbuffet Belt +1",
        left_ear="Suppanomimi",
        right_ear="Steelflash Earring",
        left_ring="Cacoethic Ring",
        right_ring="Ilabrat Ring",
        back=gear.CorWSD,
    }
    
    --[[sets.precast.WS = {
        --ammo="Ginsen",
        head="Meghanada Visor +1",
        body="Meg. Cuirie +1",
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +1",
        feet="Meg. Jam. +2",
        neck="Fotia Gorget",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Odr Earring",
        right_ear="Bladeborn Earring",
        left_ring="Ilabrat Ring",
        right_ring="Begrudging Ring",
        back="Xucau Mantle",
    }]]


    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS,{
        head="Mummu Bonnet +1",
        body="Abnoba Kaftan",
        hands="Mummu Wrists +1",
        legs="Mummu Kecks +1",
        feet="Mummu Gamash. +1",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Cessance Earring",
        right_ear="Odr Earring",
        left_ring="Begrudging Ring",
        right_ring="Ilabrat Ring",
    })

    sets.precast.WS['Savage Blade'] = {
        head={ name="Herculean Helm", augments={'Phys. dmg. taken -1%','Weapon skill damage +3%','"Treasure Hunter"+1','Accuracy+20 Attack+20',}},
        body="Laksa. Frac +2",
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +1",
        feet="Lanun Bottes +2",
        neck="Fotia Gorget",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Bladeborn Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Ilabrat Ring",
        right_ring="Apate Ring",
        back=gear.CorWSD,
    }

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Last Stand'] = {
        ammo = gear.PWSAmmo,
        head="Meghanada Visor +1",
        body="Laksa. Frac +2",
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +1",
        feet={ name="Lanun Bottes +2", augments={'Enhances "Wild Card" effect',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        right_ear="Clearview Earring",
        left_ring="Ilabrat Ring",
        right_ring="Apate Ring",
        back=gear.CorAGI,
    }

    sets.precast.WS['Last Stand'].Acc = {}
       
    sets.precast.WS['Wildfire'] = {        
        ammo = gear.MWSAmmo,
        head = gear.HercHMWS,
        body="Laksa. Frac +2",
        hands=gear.HercGMB,
        legs=gear.HercLMB,
        feet="Lanun Bottes +2",
        neck="Sanctity Necklace",
        waist="Yemaya Belt",
        left_ear="Friomisi Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Ilabrat Ring",
        right_ring="Apate Ring",
        back=gear.CorAGI,
    }

sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], {head="Pixie Hairpin +1"})

    -- Midcast Sets
    sets.midcast.FastRecast = {}
        
    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.CorsairShot = {
        ammo=gear.QDrawAmmo,
        head={ name="Herculean Helm", augments={'MND+5','"Mag.Atk.Bns."+23','"Treasure Hunter"+1','Accuracy+5 Attack+5',}},
        body={ name="Herculean Vest", augments={'Pet: INT+1','Accuracy+5','"Treasure Hunter"+1','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
        hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
        legs={ name="Herculean Trousers", augments={'Sklchn.dmg.+4%','Attack+10','Magic burst dmg.+10%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
        feet={ name="Lanun Bottes +2", augments={'Enhances "Wild Card" effect',}},
        neck="Sanctity Necklace",
        left_ear="Novio Earring",
        right_ear="Friomisi Earring",
        left_ring="Ilabrat Ring",
        right_ring="Apate Ring",
        back=gear.CorAGI,
    }

    sets.midcast.CorsairShot.Acc = {}

    sets.midcast.CorsairShot['Light Shot'] = set_combine(sets.midcast.CorsairShot, {})

    sets.midcast.CorsairShot['Dark Shot'] = set_combine(sets.midcast.CorsairShot['Light Shot'], {head="Pixie Hairpin +1"})


    -- Ranged gear
    sets.midcast.RA = {
        ammo=gear.TPAmmo,
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +1",
        feet="Meg. Jam. +2",
        neck="Sanctity Necklace",
        waist="Yemaya Belt",
        left_ear="Volley Earring",
        right_ear="Clearview Earring",
        left_ring="Cacoethic Ring",
        right_ring="Ilabrat Ring",
        back=gear.CorRTP,
    }

    sets.midcast.RA.Acc = {}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {neck="Wiglen Gorget",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    

    -- Idle sets
    sets.idle = {
        legs="Carmine Cuisses +1",
        neck="Sanctity Necklace",
    }

    sets.idle.Town = set_combine(sets.idle,{
        body="Councilor's Garb",
    })
    
    -- Defense sets
    sets.defense.PDT = {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs="Mummu Kecks +1",
        feet={ name="Herculean Boots", augments={'DEX+9','"Triple Atk."+3','Accuracy+11 Attack+11',}},
        neck="Loricate Torque +1",
        waist="Windbuffet Belt +1",
        left_ear="Odr Earring",
        right_ear="Cessance Earring",
        left_ring="Defending Ring",
        right_ring="Vocane Ring",
        back="Solemnity Cape",
    }

    sets.defense.MDT = {}
    

    sets.Kiting = {legs="Carmine Cuisses +1",}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands=gear.AdhGTP,
        legs=gear.SamTTP,
        feet=gear.HercFTP,
        neck="Lissome Necklace",
        waist="Windbuffet Belt +1",
        left_ear="Odr Earring",
        right_ear="Cessance Earring",
        left_ring="Ilabrat Ring",
        right_ring="Petrov Ring",
        back=gear.CorRTP,
    }

    sets.engaged.MaxHaste = set_combine(sets.engaged, {})

    sets.engaged.HighHaste = set_combine(sets.engaged, {})

    sets.engaged.MidHaste = set_combine(sets.engaged, {})

    sets.engaged.LowHaste = set_combine(sets.engaged, {})
    
    sets.engaged.Acc = {}

    sets.engaged.DW = set_combine(sets.engaged, {}
)
    sets.engaged.DW.MaxHaste = set_combine(sets.engaged.DW, {
        left_ear="Odr Earring",
        right_ear="Cessance Earring",
    })

    sets.engaged.DW.HighHaste = set_combine(sets.engaged.DW.MaxHaste, {   
        left_ear="Eabani Earring",
        right_ear="Suppanomimi",
    })

    sets.engaged.DW.MidHaste = set_combine(sets.engaged.DW.HighHaste, {})

    sets.engaged.DW.LowHaste = set_combine(sets.engaged.DW.MidHaste, {})
    
    sets.engaged.Acc.DW = {}
    
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

    --[[if (spell.action_type == 'Ranged Attack' and player.equipment.ammo == "Orichalc. Bullet") or (spell.skill == 'Marksmanship'and player.equipment.ammo == "Orichalc. Bullet") then
        add_to_chat(104, 'Check ammo, trying to use Quick Draw ammunition for non-Quick Draw shot.  Cancelling.')
        eventArgs.cancel = true
    end]]
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    --[[if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end]]

    -- gear sets
    --[[if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end]]
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
--[[function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end]]
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'qdraw' then
        handle_qdraw()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'rollcmd' then
            handle_roll(cmdParams[2],cmdParams[3],cmdParams[4])
            eventArgs.handled = true
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

    --[[elseif rollExecute:lower() == 'set' then
        rollSelect:set(rollMod)]]
    else
        add_to_chat(167, 'Rollcmd options are: "roll" or "cycle"')
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
    msg = msg .. ', QD.: '..state.CastingMode.current

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

    msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    
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
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    --[[local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end
    
    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
    
    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end
        
        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end]]
end

function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Nusku Shield" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
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
    send_command('wait 5;input /lockstyleset 24')
end