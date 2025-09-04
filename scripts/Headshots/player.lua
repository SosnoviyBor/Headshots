local storage = require("openmw.storage")
local ambient = require("openmw.ambient")
local nearby = require("openmw.nearby")
local input = require("openmw.input")
local async = require("openmw.async")
local core = require("openmw.core")
local self = require("openmw.self")
local ui = require("openmw.ui")
local I = require('openmw.interfaces')
require("scripts.Headshots.headshotLogic")

local l10n = core.l10n("Headshots")
local sectionOnHeadshot = storage.playerSection("SettingsHeadshots_onHeadshots")
local sectionToggles = storage.globalSection("SettingsHeadshots_toggles")

input.registerActionHandler(input.actions.Sneak.key, async:callback(function()
    if sectionToggles:get("requireCrouching") then
        for _, actor in pairs(nearby.actors) do
            actor:sendEvent("playerSneaking", not self.controls.sneak)
        end
    end
end))

I.Combat.addOnHitHandler(function(attack)
    if not sectionToggles:get("playerCanBeHeadshot") then return end
    DoHeadshot(attack)
end)

local function onLoad()
    -- always check your API version
    if core.API_REVISION < 87 then
        ui.showMessage(l10n("messageOutdatedLuaAPI"), { showInDualogue = true })
    end
end

local function onHeadshot(damageMult)
    if sectionOnHeadshot:get("playSFX") then ambient.playSound("critical damage") end
    if sectionOnHeadshot:get("showMessage") then
        if damageMult == math.huge then
            ui.showMessage(l10n("messageInstakill"))
        else
            ui.showMessage(
                l10n("messageSuccessfulHeadshots1") ..
                tostring(damageMult) ..
                l10n("messageSuccessfulHeadshots2"))
        end
    end
end

return {
    engineHandlers = {
        onLoad = onLoad
    },
    eventHandlers = {
        onHeadshot = onHeadshot
    }
}
