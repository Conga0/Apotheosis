local entity_id = GetUpdatedEntityID()
local player_id = EntityGetRootEntity(entity_id)
EntitySetComponentIsEnabled(player_id,"hardcore_healing",true)