dofile_once("data/scripts/lib/utilities.lua")

function collision_trigger()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

    local did_hit = RaytraceSurfaces(pos_x, pos_y - 2, pos_x, pos_y - 4)
  
    if not did_hit then
        EntityLoad("mods/Apotheosis/files/entities/items/books/book_fire_lukki.xml", pos_x, pos_y)
        --EntityLoad("data/entities/items/pickup/brimstone.xml", pos_x + 15, pos_y)
    end
    EntityKill(entity_id)
end