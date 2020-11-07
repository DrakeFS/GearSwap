------------------------------------------------    Warrior = WAR     Monk = MNK      White Mage = WHM    Black Mage = BLM   Red Mage = RDM
-- Rename JOB.lua to the job you wish to use  --    Theif = THF       Paladin = PLD   Dark Knight = DRK   Beastmaster = BST  Bard = BRD
-- this lua on.  ie. rename to BLU.lua to     --    Ranger = RNG      Samurai = SAM   Ninja = NIN         Dragoon = DRG      Summoner = SMN
-- load it for Blue Mage                      --    Blue Mage = BLU   Corsair = COR   Puppetmaster = PUP  Dancer = DNC       Scholar = SCH
------------------------------------------------    Geomancer = GEO   Rune Fencer = RUN
--[[
    Microsoft Visual Studio Code or Notepad++ are the recommended editors for editing LUA files.

    You can use 
        //gs export 
    in game (or just "gs export" from the Windower Console) to export your currently equiped gear to the \Windower\addons\GearSwap\data\export folder, in a file named
        YourCharactername CurrentDate-CurrentTime.lua
    from which you can copy into the sets in this lua.  
    
    If you want to make changes to existing sets, you can use
        //gs equip sets.SetName.ModName 
    for example 
        //gs equip sets.engaged
    which will equip yout engaged set (TP set).  At which point you can make any gear changes and then export the new set to update this lua.


    An example gear set is provided below to show how a "melee gear set" (you do not want to swap anything that resets TP) is built, .

    sets.engaged = {
        ammo="Ginsen",
        head="Sulevia's Mask +2",
        body="Flamma Korazin +2",
        hands="Sulev. Gauntlets +2",
        legs="Flamma Dirs +2",
        feet="Flam. Gambieras +2",
        neck="Clotharius Torque",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Steelflash Earring",
        right_ear="Bladeborn Earring",
        left_ring="Pernicious Ring",
        right_ring="Petrov Ring",
        back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
    }


    Another example gear set is provided below to show how a "casting gear set" (where you may want to swap weapons and other gear that will reset your tp) is built.
    
    sets.midcast['Healing Magic'] = {
        main={ name="Queller Rod", augments={'MND+15','Mag. Acc.+15','"Cure" potency +15%',}},
        sub="Sors Shield",
        head="Theo. Cap +1",
        body="Theo. Briault +1",
        hands="Theophany Mitts",
        legs="Ebers Pantaloons",
        feet={ name="Piety Duckbills +1", augments={'Enhances "Afflatus Solace" effect',}},
        neck={ name="Cleric's Torque", augments={'Path: A',}},
        waist="Friar's Rope",
        left_ear="Glorious Earring",
        right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
        left_ring="Lebeche Ring",
        back="Solemnity Cape",
    }
]]


function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()
end

function user_setup()
end

function init_gear_sets()
sets.precast.FC = {
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head="Nahtirah Hat",
    body="Jhakri Robe +1",
    hands="Jhakri Cuffs +1",
    legs="Jhakri Slops +1",
    feet="Navon Crackows",
    waist="Embla Sash",
    left_ring="Kishar Ring",
    right_ring="Jhakri Ring",
}  -- Fast Cast Set

-- sets.precast.RA = {}  -- Ranged delay reduction.  Ignore if uneeded, remove the first "--" to activate.

sets.precast.WS = {}  -- General Weapon Skill Set

-- sets.precast.WS['WS Name'] = set_combine(sets.precast.WS, {gear goes here}) -- Specific Weapon Skill Set.  Ignore if uneeded, remove the first "--" to activate.

sets.midcast["Elemental Magic"] = {
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head="Jhakri Coronal +1",
    body="Jhakri Robe +1",
    hands="Jhakri Cuffs +1",
    legs="Jhakri Slops +1",
    feet="Jhakri Pigaches +1",
    neck="Sanctity Necklace",
    waist="Famine Sash",
    left_ear="Hermetic Earring",
    right_ear="Gwati Earring",
    left_ring="Begrudging Ring",
    right_ring="Jhakri Ring",
} -- Casting Set

sets.midcast["Geomancy Magic"] = {
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    hands="Geomancy Mitaines",
    neck="Loricate Torque",
    left_ring="Defending Ring",
    back="Solemnity Cape",
}

-- sets.midcast.RA = {} -- Ranged TP Set.  Ignore if uneeded, remove the first "--" to activate.

-- sets.midcast['Spell Name or Magic Type'] = set_combine(sets.midcast,{gear goes here}) -- Specific casting set for a spell or magic type (ie. Enhancing Magic).  Ignore if uneeded, remove the first "--" to activate.

sets.defense.PDT = {}  -- Defense set, Press F10 to equip, Alt-F12 to unequip

sets.idle = {
    neck="Sanctity Necklace",
    body="Jhakri Robe +1",
    feet="Geomancy Sandals"
}

sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})

sets.engaged = {
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head="Jhakri Coronal +1",
    body="Jhakri Robe +1",
    hands="Jhakri Cuffs +1",
    legs="Jhakri Slops +1",
    feet="Jhakri Pigaches +1",
    neck="Sanctity Necklace",
    waist="Famine Sash",
    left_ear="Eabani Earring",
    right_ear="Suppanomimi",
    left_ring="Begrudging Ring",
    right_ring="Jhakri Ring",
    back="Solemnity Cape",
} -- TP Set

end
