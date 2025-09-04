local storage = require("openmw.storage")
local types = require("openmw.types")
local self = require("openmw.self")
local I = require('openmw.interfaces')
require("scripts.Headshots.headshotData")

local sectionToggles = storage.globalSection("SettingsHeadshots_toggles")
local sectionValues = storage.globalSection("SettingsHeadshots_values")
local sectionDebug = storage.globalSection("SettingsHeadshots_debug")
local selfIsPlayer = self.type == types.Player
local headShotLevel = 0.85

function UpdatePlayerSneakStatus(currentSneakStatus)
    PlayerIsSneaking = currentSneakStatus
end

local function isHeadshotSuccessful(attack)
    -- basic attack check
    if not (attack.successful and attack.sourceType == "ranged") then return false end

    if sectionDebug:get("alwaysHeadshot") then return true end

    -- weapon type check
    local weaponRecord = types.Weapon.record(attack.weapon.recordId)
    if not WeaponTypes[weaponRecord.type]() then return false end

    -- check if hit was in the head
    -- code from Ranged Headshot mod by SkyHasCats
    -- https://modding-openmw.gitlab.io/ranged-headshot/
    local bbox = self:getBoundingBox()
    local half = bbox.halfSize
    local center = bbox.center
    -- Local hit position relative to center
    local rel = attack.hitPos - center
    -- Convert to 0..1 along vertical axis
    -- bottom = -half.z, top = +half.z
    local normalizedHeight = (rel.z + half.z) / (2 * half.z)
    --print(string.format("Hit height ratio: %.2f", normalizedHeight))
    if normalizedHeight > headShotLevel then
        return true
    else
        return false
    end
end

local function getHeadshotMultiplier(attack)
    -- initial damage mult calculation
    local mode = Modes[sectionValues:get("mode")]
    local damageMult = mode(attack.attacker)

    -- distance multiplier calculation
    local distance = (attack.attacker.position - self.position):length()
    if distance <= sectionValues:get("distanceMin") then
        damageMult = damageMult / 2
    elseif distance <= sectionValues:get("distanceMax") then
        local relDistance = distance - sectionValues:get("distanceMin")
        local diff = sectionValues:get("distanceMax") - sectionValues:get("distanceMin")
        local distanceScale = relDistance / diff
        damageMult = damageMult / (2 * distanceScale)
    end

    if sectionDebug:get("printToConsole") then
        print("Headshots multiplier debug message!" ..
            "\nAttacker:        " .. attack.attacker.recordId ..
            "\nVictim:          " .. self.recordId ..
            "\nWeapon used:     " .. attack.weapon.recordId ..
            "\nDamage modifier: x" .. tostring(damageMult))
    end

    -- you shouldn't be able to hit for less damage
    damageMult = math.max(damageMult, 1)

    return damageMult
end

function DoHeadshot(attack)
    if not sectionToggles:get("modEnabled") then return end

    if not isHeadshotSuccessful(attack) then return end

    local damageMult = getHeadshotMultiplier(attack)
    if damageMult == 1 then return end

    local initDamage = attack.damage.health
    attack.damage.health = attack.damage.health * damageMult
    local msg = ""

    if sectionDebug:get("printToConsole") then print(msg) end
    attack.attacker:sendEvent("onHeadshot", damageMult)
end
