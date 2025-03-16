dofile_once("data/scripts/lib/utilities.lua")

function open_chest()
	local entity_id = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform(entity_id)

	CreateItemActionEntity( "APOTHEOSIS_TERMINUS", pos_x, pos_y )
	
    GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", pos_x, pos_y)
	EntityKill(entity_id)
end

function item_pickup( entity_item, entity_who_picked, name )
	open_chest()
end

function physics_body_modified( is_destroyed )
	if is_destroyed then
		open_chest()
	end
end