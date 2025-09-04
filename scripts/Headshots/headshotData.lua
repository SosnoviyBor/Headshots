local storage = require("openmw.storage")
local types = require("openmw.types")
local self = require("openmw.self")
require("scripts.Headshots.utils")
require("scripts.Headshots.instakillBlacklist")

local sectionValues = storage.globalSection("SettingsHeadshots_values")
local swt = storage.globalSection("SettingsHeadshots_weaponTypes")

Modes = {
    ["Linear"] = function(attacker)
        local fm = sectionValues:get("flatMult")
        local am = TryGetActorMarksman(attacker)
        local mm = sectionValues:get("marksmanMult")
        return fm + am * mm
    end,
    ["Threshold"] = function(attacker)
        local fm = sectionValues:get("flatMult")
        local am = TryGetActorMarksman(attacker)
        local step = sectionValues:get("thresholdStep")
        local mm = sectionValues:get("marksmanMult")
        return fm + IntDiv(am, step) * mm
    end,
    ["Instakill"] = function(attacker)
        if InInstakillBlacklist(self) then return 1
        else return math.huge end
    end
}

WeaponTypes = {
    [types.Weapon.TYPE.Arrow] =             function() return swt:get("marksmanBowEnabled") end,
    [types.Weapon.TYPE.Bolt] =              function() return swt:get("marksmanCrossbowEnabled") end,
    [types.Weapon.TYPE.MarksmanBow] =       function() return swt:get("marksmanBowEnabled") end,
    [types.Weapon.TYPE.MarksmanCrossbow] =  function() return swt:get("marksmanCrossbowEnabled") end,
    [types.Weapon.TYPE.MarksmanThrown] =    function() return swt:get("marksmanThrownEnabled") end,
}
