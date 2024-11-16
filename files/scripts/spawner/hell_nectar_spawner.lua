
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)

local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
local hp = ComponentGetValue2(comp,"max_hp")
local worm_count = EntityGetInRadiusWithTag(x,y,800,"boss") or {}

local y_value = math.abs(y)
GamePrint(y_value)
if y_value > 100000 then
    local nectar = EntityLoad("mods/Apotheosis/files/entities/projectiles/circle_hell_nectar.xml",x,y)
    EntityAddComponent2(
        nectar,
        "LifetimeComponent",
        {
            lifetime = math.min(math.min((y_value - 100000)/200,10),260) * 10,
        }
    )
    GamePrint("lifetime is " .. math.min(math.max((y_value - 100000)/200,10),260) * 10)
    GamePrint("Loading Nectar at pos_x: " .. x .. " pos_y: " .. y)
end
EntityKill(entity_id)
