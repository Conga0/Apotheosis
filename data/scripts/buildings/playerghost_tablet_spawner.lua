
function collision_trigger()
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )

	local eid = EntityLoad( "data/entities/animals/playerghost_apotheosis/temp/playerghost.xml", pos_x, pos_y )
	AddFlagPersistent("apotheosis_tablet_ghost_encounter")

	EntityKill( entity_id )
end
