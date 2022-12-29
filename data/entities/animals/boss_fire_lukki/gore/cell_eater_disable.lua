dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local lukki_id = EntityGetRootEntity(entity_id)

local comp = EntityGetComponentIncludingDisabled(lukki_id, "CellEaterComponent")[1]
ComponentSetValue2( comp, "eat_probability", 0)


local pos_x, pos_y = EntityGetTransform( lukki_id )
local rockgore = EntityLoad( "data/entities/animals/boss_fire_lukki/gore/rock_chunks.xml", pos_x, pos_y)
PhysicsApplyForce( rockgore, 0, -600)
PhysicsApplyTorque( rockgore, 200)
GameCreateParticle( "lava", pos_x+20, pos_y, 250, 0, -20, true, false )