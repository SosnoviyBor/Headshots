local types = require("openmw.types")

function IntDiv(a, b)
    if b == 0 then error("division by zero") end
    local q = a / b
    if q >= 0 then
        return math.floor(q)
    else
        return math.ceil(q)
    end
end

function TryGetActorMarksman(actor)
    local sneak = types.NPC.stats.skills.marksman(actor)
    if sneak then
        return sneak.modified
    else
        return 0
    end
end

function UnitsToMeters(distance)
    -- its scuffed, ok?
    local unitsToFeetScale = 22.1
    local feetToMetersScale = 3.281
    return distance / unitsToFeetScale / feetToMetersScale
end