
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

if GameHasFlagRun( "greed_curse" ) and ( GameHasFlagRun( "greed_curse_gone" ) == false ) and (EntityGetParent(entity_id) == 0) then
    EntityKill(entity_id)
    EntityLoad("mods/Apotheosis/files/entities/items/pickups/orb_affluence.xml", pos_x, pos_y)
end
