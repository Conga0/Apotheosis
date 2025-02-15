dofile_once("data/scripts/lib/utilities.lua")

function spawn_leggy( entity_item )
	local x, y = EntityGetTransform( entity_item )
	EntityLoad( "mods/Apotheosis/files/entities/particles/image_emitters/chest_clam_convert.xml", x, y )
	EntityLoad( "data/entities/animals/sunken_cave/chest_leggy.xml", x, y )
	EntityKill( entity_item )
end

function item_pickup( entity_item, entity_who_picked, name )
	spawn_leggy( entity_item )
	
end

function physics_body_modified( is_destroyed )
	local entity_item = GetUpdatedEntityID()
	spawn_leggy( entity_item )
end

function collision_trigger( colliding_entity_id )
	local entity_item = GetUpdatedEntityID()
	spawn_leggy( entity_item )
end