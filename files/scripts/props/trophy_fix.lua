dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()

local comp = EntityGetFirstComponentIncludingDisabled( entity_id, "VelocityComponent" )
EntityRemoveComponent( entity_id, comp )

comp = EntityGetFirstComponentIncludingDisabled( entity_id, "SimplePhysicsComponent" )
EntityRemoveComponent( entity_id, comp )