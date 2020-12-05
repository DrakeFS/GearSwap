-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off
    
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    
    Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
--]]


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
    state.roll1 = M{['description'] = 'Roll 1'}
    state.roll2 = M{['description'] = 'Roll 2'}
    define_roll_values()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None','Ranged', 'Melee', 'Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
    
    state.roll1:options("Corsair's Roll", "Ninja Roll", "Hunter's Roll", "Chaos Roll", "Magus's Roll", "Healer's Roll", "Puppet Roll",
    "Choral Roll", "Monk's Roll", "Beast Roll", "Samurai Roll", "Evoker's Roll", "Rogue's Roll", "Warlock's Roll", "Fighter's Roll", 
    "Drachen Roll", "Gallant's Roll", "Wizard's Roll", "Dancer's Roll", "Scholar's Roll", "Bolter's Roll", "Caster's Roll", 
    "Courser's Roll" ,"Blitzer's Roll", "Tactician's Roll", "Allies's Roll", "Miser's Roll", "Companion's Roll", "Avenger's Roll")
    state.roll2:options("Corsair's Roll", "Ninja Roll", "Hunter's Roll", "Chaos Roll", "Magus's Roll", "Healer's Roll", "Puppet Roll",
    "Choral Roll", "Monk's Roll", "Beast Roll", "Samurai Roll", "Evoker's Roll", "Rogue's Roll", "Warlock's Roll", "Fighter's Roll", 
    "Drachen Roll", "Gallant's Roll", "Wizard's Roll", "Dancer's Roll", "Scholar's Roll", "Bolter's Roll", "Caster's Roll", 
    "Courser's Roll" ,"Blitzer's Roll", "Tactician's Roll", "Allies's Roll", "Miser's Roll", "Companion's Roll", "Avenger's Roll")
    state.roll1:set("Fighter's Roll")
    state.roll2:set("Samurai Roll")
    --gear.RAbullet = "Adlivun Bullet"
    --gear.WSbullet = "Adlivun Bullet"
    --gear.MAbullet = "Bronze Bullet"
    --gear.QDbullet = "Adlivun Bullet"
    --options.ammo_warning_limit = 15

    -- Additional local binds
    -- send_command('bind ^` input /ja "Double-up" <me>')
    -- send_command('bind !` input /ja "Bolter\'s Roll" <me>')
    send_command('bind ^` gs c cycle roll1')
    send_command('bind !` gs c cycle roll2')
    --select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    -- send_command('unbind ^`')
    -- send_command('unbind !`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    -- Define job specific gear
    
    gear.TPAmmo = "Corsair Bullet"
    gear.PWSAmmo = ""
    gear.MWSAmmo = "Orichalc. Bullet"
    gear.ShotAmmo = ""

    -- Precast sets to enhance JAs
    
    sets.precast.JA['Triple Shot'] = {body="Navarch's Frac +2"}
    sets.precast.JA['Snake Eye'] = {legs="Lanun Culottes"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac"}

    
    sets.precast.CorsairRoll = {head="Lanun Tricorne",hands="Navarch's Gants +2"}
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Navarch's Culottes +2"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Navarch's Bottes +2"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Navarch's Tricorne +2"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Navarch's Frac +2"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Navarch's Gants +2"})
    
    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants"}
    
    sets.precast.CorsairShot = {head="Blood Mask"}
    

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
        feet="Meg. Jam. +1",
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
        feet="Meg. Jam. +1",
        neck="Sanctity Necklace",
        waist="Windbuffet Belt +1",
        left_ear="Suppanomimi",
        right_ear="Steelflash Earring",
        left_ring="Cacoethic Ring",
        right_ring="Ilabrat Ring",
        back="Xucau Mantle",
    }
    
    --[[sets.precast.WS = {
        --ammo="Ginsen",
        head="Meghanada Visor +1",
        body="Meg. Cuirie +1",
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +1",
        feet="Meg. Jam. +1",
        neck="Fotia Gorget",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Odr Earring",
        right_ear="Bladeborn Earring",
        left_ring="Ilabrat Ring",
        right_ring="Begrudging Ring",
        back="Xucau Mantle",
    }]]


    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = {
        --ammo="Jukukik Feather",
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
    }

    sets.precast.WS['Savage Blade'] = {
        head={ name="Herculean Helm", augments={'Phys. dmg. taken -1%','Weapon skill damage +3%','"Treasure Hunter"+1','Accuracy+20 Attack+20',}},
        body="Laksa. Frac +2",
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +1",
        feet="Meg. Jam. +1",
        neck="Fotia Gorget",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Bladeborn Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Ilabrat Ring",
        right_ring="Apate Ring",
        back="Xucau Mantle",
    }

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Last Stand'] = {}

    sets.precast.WS['Last Stand'].Acc = {}

    sets.precast.WS['Leaden Salute'] = {
        ammo = gear.MWSAmmo,
        head="Pixie Hairpin +1",
        body="Rawhide Vest",
        hands={ name="Herculean Gloves", augments={'VIT+15','"Mag.Atk.Bns."+24','Accuracy+6 Attack+6','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
        legs={ name="Herculean Trousers", augments={'Accuracy+10','Mag. Acc.+11','Accuracy+19 Attack+19','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
        feet="Mummu Gamash. +1",
        neck="Sanctity Necklace",
        waist="Fotia Belt",
        left_ear="Novio Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Ilabrat Ring",
        right_ring="Petrov Ring",
    }
    
    sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS['Leaden Salute'], {})
    
    -- Midcast Sets
    sets.midcast.FastRecast = {}
        
    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.CorsairShot = {}

    sets.midcast.CorsairShot.Acc = {}

    sets.midcast.CorsairShot['Light Shot'] = {}

    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']


    -- Ranged gear
    sets.midcast.RA = {
        ammo=gear.TPAmmo,
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Meg. Gloves +2",
        legs="Meg. Chausses +1",
        feet="Meg. Jam. +1",
        neck="Sanctity Necklace",
        waist="Yemaya Belt",
        left_ear="Volley Earring",
        right_ear="Clearview Earring",
        left_ring="Cacoethic Ring",
        right_ring="Ilabrat Ring",
        back="Xucau Mantle",
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
    sets.defense.PDT = {}

    sets.defense.MDT = {}
    

    sets.Kiting = {legs="Carmine Cuisses +1",}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        range={ name="Holliday", augments={'"Snapshot"+2','INT+13','Rng.Acc.+22','Rng.Atk.+6','DMG:+23',}},
        ammo=gear.TPAmmo,
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        legs=gear.SamTTP,
        feet=gear.HercFTP,
        neck="Clotharius Torque",
        waist="Windbuffet Belt +1",
        left_ear="Suppanomimi",
        right_ear="Eabani Earring",
        left_ring="Pernicious Ring",
        right_ring="Petrov Ring",
        back="Xucau Mantle",
    }
    
    sets.engaged.Acc = {}

    sets.engaged.DW = set_combine(sets.engaged, {})
    
    sets.engaged.Acc.DW = {}

    sets.engaged.Ranged = {}

    sets.weatherbelt = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
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
    if cmdParams[1]:lower() == 'roll1' then
        handle_roll_1()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'roll2' then
        handle_roll_2()
        eventArgs.handled = true
    end
end

function handle_roll_1()
    local roll = state.roll1.value

    send_command('@input /ja "'..roll..'" <me>')
end

function handle_roll_2()
    local roll = state.roll2.value

    send_command('@input /ja "'..roll..'" <me>')
end
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    if newStatus == 'Engaged' and player.equipment.main == 'Chatoyant Staff' then
        state.OffenseMode:set('Ranged')
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
    local bullet_name
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
    end
end

-- Select default macro book on initial load or subjob change.
--[[function select_default_macro_book()
    set_macro_page(1, 19)
end]]