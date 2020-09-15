------------------------------------------------    Warrior = WAR     Monk = MNK      White Mage = WHM    Black Mage = BLM   Red Mage = RDM
-- Rename JOB.lua to the job you wish to use  --    Theif = THF       Paladin = PLD   Dark Knight = DRK   Beastmaster = BST  Bard = BRD
-- this lua on.  ie. rename to BLU.lua to     --    Ranger = RNG      Samurai = SAM   Ninja = NIN         Dragoon = DRG      Summoner = SMN
-- load it for Blue Mage                      --    Blue Mage = BLU   Corsair = COR   Puppetmaster = PUP  Dancer = DNC       Scholar = SCH
------------------------------------------------    Geomancer = GEO   Rune Fencer = RUN

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()
end

function user_setup()
end

function init_gear_sets()
sets.precast.FC = {}  -- Fast Cast Set

sets.precast.WS = {
    ammo="Falcon Eye",
    head="Mummu Bonnet +2",
    body="Mummu Jacket +2",
    hands="Meg. Gloves +2",
    legs="Mummu Kecks +2",
    feet="Mummu Gamash. +2",
    neck="Clotharius Torque",
    waist="Shadow Belt",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Begrudging Ring",
    right_ring="Mummu Ring",
    back="Atheling Mantle",
}  -- General Weapon Skill Set

-- sets.precast.WS['WS_Name'] = set_combine(sets.precast.WS, {gear goes here}) -- Specific Weapon Skill Set.  Ignore if uneeded, remove the first "--" to activate.

sets.midcast = {} -- Casting Set

-- sets.midcast['Spell Name or Magic Type'] = set_combine(sets.midcast,{gear goes here}) -- Specific casting set for a spell or magic type (ie. Enhancing Magic).  Ignore if uneeded, remove the first "--" to activate.

sets.idle = set_combine(sets.defense.PDT, {neck="Sanctity Necklace",})

sets.idle.Town = set_combine(sets.idle, {body="Councilor's Garb",})

sets.defense.PDT = {
    head="Meghanada Visor +1",
    body="Meg. Cuirie +2",
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +2",
    feet="Meg. Jam. +1",
    neck="Loricate Torque",
    left_ear="Odnowa Earring +1",
    right_ear="Eabani Earring",
    left_ring="Defending Ring",
    right_ring="Meghanada Ring",
    back="Solemnity Cape",
}  

sets.engaged = {
    ammo="Ginsen",
    head="Mummu Bonnet +2",
    body=gear.HercBTP,
    hands="Mummu Wrists +2",
    legs="Meg. Chausses +2",
    feet="Mummu Gamash. +2",
    neck="Clotharius Torque",
    waist="Dynamic Belt",
    left_ear="Steelflash Earring",
    right_ear="Bladeborn Earring",
    left_ring="Begrudging Ring",
    right_ring="Meghanada Ring",
    back="Atheling Mantle",
}

end
