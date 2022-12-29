dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

EntityLoad( "mods/Apotheosis/files/entities/particle_generators/smoke_cloud_generator_nolua.xml", pos_x, pos_y )
