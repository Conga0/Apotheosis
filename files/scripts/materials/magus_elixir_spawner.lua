
local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local tbl = EntityGetInRadiusWithTag( x, y, 25, "wand" ) or {}

if #tbl < 5 then
    local filepath = "data/entities/items/wand_level_03.xml"
    local eid = EntityLoad( filepath, x, y )
    
    local comp = EntityGetFirstComponentIncludingDisabled(eid,"SpriteParticleEmitterComponent")
    ComponentSetValue2(comp,"emission_interval_min_frames",30)
    ComponentSetValue2(comp,"emission_interval_max_frames",60)

--Debug Data
--    GamePrint("Generating wand at " .. x .. ", " .. y)
--    print("Generating wand at " .. x .. ", " .. y)
--else
--    GamePrint("Wand Blocked at " .. x .. ", " .. y)
--    print("Wand Blocked at " .. x .. ", " .. y)
end
    
EntityKill( entity_id )
