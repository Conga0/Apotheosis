
local entity_id = GetUpdatedEntityID()
local parent = EntityGetRootEntity(entity_id)

EntitySetComponentsWithTagEnabled( parent, "player_hat2", false )
