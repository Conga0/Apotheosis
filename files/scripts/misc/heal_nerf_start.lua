local entity_id = GetUpdatedEntityID()
local player_id = EntityGetParent( entity_id )
local x, y = EntityGetTransform( entity_id )

local dcomp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")
ComponentObjectSetValue(dcomp,"damage_multipliers","healing",0.2) --Just give the player 5 seconds of wounding when they take damage from any source instead?