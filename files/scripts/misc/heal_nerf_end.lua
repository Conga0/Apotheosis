local entity_id = GetUpdatedEntityID()
local player_id = EntityGetParent( entity_id )
local x, y = EntityGetTransform( entity_id )

local dcomp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")
ComponentObjectSetValue(dcomp,"damage_multipliers","healing",1.0)