
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)

local y_value = math.abs(y)
if y_value > 60000 then
    local nectar = EntityLoad("mods/Apotheosis/files/entities/projectiles/circle_hell_nectar.xml",x,y)
    EntityAddComponent2(
        nectar,
        "LifetimeComponent",
        {
            lifetime = math.min(math.min((y_value - 60000)/200,10),260) * 10,
        }
    )
end
EntityKill(entity_id)
