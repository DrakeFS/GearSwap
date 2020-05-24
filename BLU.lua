-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
	include('Mote-TreasureHunter')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	
	
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false

	determine_haste_group()

    blue_magic_maps = {}
    
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
    
    -- Physical Spells --
    
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm'
    }

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike',
    }

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Uppercut','Vertical Cleave'
    }
        
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive'
    }
        
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
    }
        
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray',
        'Diffusion Ray','Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
        'Ice Break','Leafstorm','Maelstrom','Rail Cannon','Regurgitation','Rending Deluge',
        'Retinal Glare','Subduction','Spectral Floe','Tem. Upheaval','Water Bomb','Entomb',
		'tenebral crush',
    }

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light'
    }

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{
        'Thermal Pulse'
    }

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Charged Whisker','Gates of Hades'
    }
            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'
    }
        
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }

    -- Stun spells
    blue_magic_maps.Stun = S{
        'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'
    }
        
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'
    }
    
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Plasma Charge',
        'Pyric Bulwark','Reactor Cool',
    }

    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Memento Mori','Nat. Meditation','Occultation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
        'Zephyr Mantle'
    }
    
    
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
        'Crashing Thunder','Droning Whirlwind','Gates of Hades','Harden Shell','Polar Roar',
        'Pyric Bulwark','Thunderbolt','Tourbillion','Uproot'
    }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Subtle', 'Refresh', 'Learning')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Learning')

    update_combat_form()
	lockstyleset()
    --select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()

    
end


-- Set up gear sets.
function init_gear_sets()
	--------------------------------------
    -- Start defining the sets
    --------------------------------------

	sets.TreasureHunter = {head="Wh. Rarab Cap +1",gear.HercBTH, legs=gear.HercLTH, waist="Chaac Belt",}
	sets.Kiting	 = {legs="Carmine Cuisses +1",}
	
    --sets.buff['Burst Affinity'] = {}
    --sets.buff['Chain Affinity'] = {}
    --sets.buff.Convergence = {}
    sets.buff.Diffusion = {feet="Luhlaza Charuqs +3"}
    sets.buff.Enchainment = {body="Luhlaza Jubbah"}
    --sets.buff.Efflux = {}

    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    --sets.precast.JA['Azure Lore'] = {}


    -- Waltz set (chr and vit)
    --sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    --sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
	ammo="Impatiens",
    head="Herculean Helm",
    body="Hashishin Mintan",
    hands="Jhakri Cuffs +2",
    legs=gear.LengoFC,
    feet="Jhakri Pigaches +2",
    left_ring="Jhakri Ring",
	right_ring="Kishar Ring",
	}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
    ammo="Ginsen",
    head="Malignance Chapeau",
    body="Assim. Jubbah +3",
    hands="Assim. Bazu. +2",
    legs={ name="Luhlaza Shalwar +3", augments={'Enhances "Assimilation" effect',}},
    feet="Aya. Gambieras +2",
    neck="Mirage Stole +2",
    left_ear="Steelflash Earring",
    right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    left_ring="Ayanmo Ring",
    right_ring="Jhakri Ring",
    back=gear.BluCDEX,
	}
    
    sets.precast.WS.acc = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
	neck="Soil Gorget",
	waist="Soil Belt",
	right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
	})

    sets.precast.WS['Sanguine Blade'] = {
	ammo="Ginsen",
    head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands=gear.HercMB,
    legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +2",
    neck="Mirage Stole +2",
    left_ear="Novio Earring",
    right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    left_ring="Jhakri Ring",
    right_ring="Ayanmo Ring",
    back="Cornflower Cape",
	}
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
    ammo="Ginsen",
    head="Jhakri Coronal +2",
    hands="Jhakri Cuffs +2",
    feet="Jhakri Pigaches +2",
    neck="Thunder Gorget",
    waist="Thunder Belt",
    left_ear="Odr Earring",
    right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    left_ring="Rajas Ring",
    right_ring="Apate Ring",
    back=gear.BluCSTR,
	})
	
	sets.precast.WS['Savage Blade'].Acc = {
	ammo="Honed Tathlum",
    head="Malignance Chapeau",
    body="Ayanmo Corazza +2",
    hands="Assim. Bazu. +2",
    legs="Jhakri Slops +2",
    feet="Aya. Gambieras +2",
    neck="Mirage Stole +2",
    waist="Anguinus Belt",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Ayanmo Ring",
    right_ring="Beeline Ring",
    back=gear.BluCDEX,
	}
	
	sets.precast.WS['Chant du Cygne'] = {
    ammo="Falcon Eye",
    head="Malignance Chapeau",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Light Gorget",
    waist="Light Belt",
    left_ear="Steelflash Earring",
    right_ear="Odr Earring",
    left_ring="Jhakri Ring",
    right_ring="Ayanmo Ring",
    back=gear.BluCDEX,
	}
	
	sets.precast.WS['Chant du Cygne'].Acc = {
    ammo="Falcon Eye",
    head="Malignance Chapeau",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Mirage Stole +2",
    waist="Light Belt",
    left_ear="Steelflash Earring",
    right_ear="Odr Earring",
    left_ring="Jhakri Ring",
    right_ring="Ayanmo Ring",
    back=gear.BluDEX,
	}

    -- Midcast Sets
    sets.midcast.FastRecast = {}
	
    sets.midcast['Blue Magic'] = {}
    
    -- Physical Spells --
    
    sets.midcast['Blue Magic'].Physical = {
	ammo="Ginsen",
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Mirage Stole +2",
    waist="Anguinus Belt",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Jhakri Ring",
    right_ring="Ayanmo Ring",
    back=gear.BluCTP,
	}

    sets.midcast['Blue Magic'].PhysicalAcc = {
    ammo="Ginsen",
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Mirage Stole +2",
    waist="Anguinus Belt",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Jhakri Ring",
    right_ring="Ayanmo Ring",
    back=gear.BluCTP,	
	}

    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {})

    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical, {})


    -- Magical Spells --
    
    sets.midcast['Blue Magic'].Magical = {
    ammo="Mavi Tathlum",
    head="Jhakri Coronal +2",
    body="Jhakri Robe +2",
    hands=gear.HercGMB,
    legs={ name="Luhlaza Shalwar +3", augments={'Enhances "Assimilation" effect',}},
    feet="Jhakri Pigaches +2",
    neck="Mirage Stole +2",
	waist={ name="Acuity Belt +1", augments={'Path: A',}},
	back=gear.BluCMB,
    left_ear="Hermetic Earring",
    right_ear="Novio Earring",
    left_ring="Jhakri Ring",
    right_ring="Ayanmo Ring",
	}

    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical, {})
    
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {})

    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {})
	
	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})

    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {})

    sets.midcast['Blue Magic'].MagicAccuracy = 
	{
	ammo="Mavi Tathlum",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Hashi. Bazu. +1",
    legs={ name="Luhlaza Shalwar +3", augments={'Enhances "Assimilation" effect',}},
    feet="Luhlaza Charuqs +3",
    neck={ name="Mirage Stole +2", augments={'Path: A',}},
    waist={ name="Acuity Belt +1", augments={'Path: A',}},
    left_ear="Njordr Earring",
    right_ear="Hermetic Earring",
    left_ring="Kishar Ring",
    right_ring="Ayanmo Ring",
    back=gear.BluCMAC,
	}

    -- Breath Spells --
    
    sets.midcast['Blue Magic'].Breath = {}

    -- Other Types --
    
    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})

    sets.midcast['Blue Magic']['White Wind'] = {}

    sets.midcast['Blue Magic'].Healing = {}

    sets.midcast['Blue Magic'].SkillBasedBuff = {
	ammo="Mavi Tathlum",
	--head="Luhlaza Keffiyeh",  
	body="Assim. Jubbah +3",
	legs="Hashishin Tayt",
	feet="Luhlaza Charuqs +3",
	neck="Mirage Stole +2",
	back=gear.BluCMAC,
	}

    sets.midcast['Blue Magic'].Buff = {}
    
    sets.midcast.Protect = {}
    sets.midcast.Protectra = {}
    sets.midcast.Shell = {}
    sets.midcast.Shellra = {}
    

    
    
    -- Sets to return to when not performing an action.

    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = {
	ammo="Mavi Tathlum",
	--head="Luhlaza Keffiyeh",  
	body="Assim. Jubbah +3",
	hands="Assimilator's Bazubands +2",
	legs="Hashishin Tayt",
	feet="Luhlaza Charuqs +3",
	neck="Mirage Stole +2",
	back="Cornflower Cape"
	}

	sets.Subtle = {
    neck="Bathy Choker",
	head={ name="Dampening Tam", augments={'DEX+6','Mag. Acc.+13',}},
    right_ear="Ouesk Pearl",
	left_ring="Beeline Ring",
    right_ring="Rajas Ring",
	}

    --[[sets.latent_refresh = {
	body="Jhakri Robe +2",
	legs={ name="Lengo Pants", augments={'INT+7','Mag. Acc.+7','"Mag.Atk.Bns."+3','"Refresh"+1',}},
	}]]

    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
    sets.idle = {
	ammo="Ginsen",
    head="Malignance Chapeau",
	body="Jhakri Robe +2",
    hands="Assim. Bazu. +2",
    legs="Carmine Cuisses +1",
    feet="Aya. Gambieras +2",
    neck="Sanctity Necklace",
    waist="Windbuffet belt +1",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
    back=gear.BluCTP,
	}

    sets.idle.PDT = {
	ammo="Ginsen",
    head="Malignance Chapeau",
    body="Ayanmo Corazza +2",
    hands="Assim. Bazu. +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Loricate Torque +1",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
    back=gear.BluCTP,
	}

    sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})

 	sets.idle.Learning = set_combine(sets.idle, sets.Learning)
    
    -- Defense sets
    sets.defense.PDT = {	
	ammo="Ginsen",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Assim. Bazu. +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Loricate Torque +1",
    waist="Windbuffet belt +1",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Defending Ring",
    right_ring="Vocane Ring",
    back=gear.BluCTP,
	}

    sets.defense.MDT = set_combine(sets.defense.PDT, {})

	sets.Kiting = {
	legs="Carmine Cuisses +1",
	}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
    ammo="Ginsen",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs=gear.SamTTP,
    feet=gear.HercFTP,
    neck="Mirage Stole +2", 
    waist="Windbuffet Belt +1",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Pernicious Ring",
    right_ring="Petrov Ring",
    back=gear.BluCTP,
	}

    sets.engaged.Acc = {
	ammo="Honed Tathlum",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Jhakri Slops +2",
    feet="Aya. Gambieras +2",
    neck="Mirage Stole +2",
    waist="Anguinus Belt",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Ayanmo Ring",
    right_ring="Beeline Ring",
    back=gear.BluCTP,
	}

	sets.engaged.Subtle = set_combine(sets.engaged, sets.Subtle)

    sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
	
	sets.engaged.DW = {
    ammo="Ginsen",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs=gear.SamTTP,
    feet=gear.HercFTP,
    neck="Mirage Stole +2",
    waist="Windbuffet Belt +1",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Pernicious Ring",
    right_ring="Petrov Ring",
    back=gear.BluCTP,
	}

	sets.engaged.DW.MaxHaste = set_combine(sets.engaged.DW, {})
	
	sets.engaged.DW.HighHaste = set_combine(sets.engaged.DW, {
    left_ear="Suppanomimi",
    right_ear="Eabani Earring",
	})
	
	sets.engaged.DW.MidHaste = set_combine(sets.engaged.DW.HighHaste, {})
	
	sets.engaged.DW.LowHaste = set_combine(sets.engaged.DW.MidHaste, {})

    sets.engaged.DW.Acc = {
    ammo="Falcon Eye",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Aya. Manopolas +2",
    legs="Jhakri Slops +2",
    feet="Aya. Gambieras +2",
    neck={ name="Mirage Stole +2", augments={'Path: A',}},
    waist="Anguinus Belt",
    left_ear="Steelflash Earring",
    right_ear="Odr Earring",
    left_ring="Ayanmo Ring",
    right_ring="Beeline Ring",
    back=gear.BluCTP,
	}
	
	sets.engaged.DW.Subtle = set_combine(sets.engaged.DW, sets.Subtle)

	sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.Learning)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
--[[function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
end]]

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end

    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

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

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
	determine_haste_group()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Genmei Shield" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end

--[[ Enables Capacity Mode
function customize_melee_set(meleeSet)
	if state.TreasureMode.value == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
	return meleeSet
end]]

-- Set a Haste Group

function determine_haste_group()
 
    -- Low haste DW required: 
	-- DW6: 19%
	-- DW5: 21%
	-- DW4: 26%
    -- DW3: 31%
	
	--Mid Haste DW required:
	-- DW6: 13% 
	-- DW5: 15%
	-- DW4: 20%
	-- DW3: 25%
	
	--High Haste DW required:
	-- DW6: -1% (potential minor TP loss if barely above a TP\Delay threshold)
	-- DW5: 1%
	-- DW4: 6%
	-- DW3: 11%
	
	-- Max haste DW Required:
	-- DW3 -1% (potential minor TP loss if barely above a TP\Delay threshold)
	-- DW2 9% (Sub Dancer only, no DW trait set)
	
	-- Sets assume DW3
    
    classes.CustomMeleeGroups:clear()
    
    if (buffactive.haste and buffactive['Haste Samba'] and buffactive.march) 
	or (buffactive.march == 2 and buffactive['Haste Samba']) 
	or (buffactive.embrava and (buffactive.haste or buffactive.march) and buffactive['Haste Samba']) then
		classes.CustomMeleeGroups:append('MaxHaste')
	elseif (buffactive.haste and buffactive.march) or (buffactive.march == 2) then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.haste and buffactive['Haste Samba'] then
        classes.CustomMeleeGroups:append('MidHaste')
    elseif buffactive.haste then
        classes.CustomMeleeGroups:append('LowHaste')
    end
end

	-- Select default macro book on initial load or subjob change.

--[[function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 16)
    else
        set_macro_page(1, 16)
    end
end ]]

	-- Set a Style Lock
function lockstyleset()
	send_command('wait 5;input /lockstyleset 20')
end
