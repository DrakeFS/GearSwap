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

sets.precast.WS = {}  -- General Weapon Skill Set

-- sets.precast.WS['WS_Name'] = set_combine(sets.precast.WS, {gear goes here}) -- Specific Weapon Skill Set.  Ignore if uneeded, remove the first "--" to activate.

sets.midcast = {} -- Casting Set

-- sets.midcast['Spell Name or Magic Type'] = set_combine(sets.midcast,{gear goes here}) -- Specific casting set for a spell or magic type (ie. Enhancing Magic).  Ignore if uneeded, remove the first "--" to activate.

sets.defense.PDT = {}  -- Defense set, Press F10 to equip, Alt-F12 to unequip

sets.engaged = {} -- TP Set

end
