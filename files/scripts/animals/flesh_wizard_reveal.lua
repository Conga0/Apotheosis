if GameHasFlagRun("apotheosis_flesh_boss_armor") then
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

	local wlist = {"manaeater","neutral","swapper","twitchy","wands"}
	rnd = Random( 1, #wlist )
	local wiz = wlist[rnd]

	EntityLoad( "data/entities/particles/blood_explosion.xml", pos_x, pos_y )
	EntityLoad( "data/entities/animals/flesh_wizard_" .. wiz .. ".xml", pos_x, pos_y )
	EntityKill(entity_id)
end
