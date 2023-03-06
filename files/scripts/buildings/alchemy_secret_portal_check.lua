local opened = false
local twwegiven = false

function material_area_checker_failed( pos_x, pos_y )
	EntitySetComponentsWithTagEnabled(GetUpdatedEntityID(), "enabled_by_liquid", false)
end

function material_area_checker_success( pos_x, pos_y )
	EntitySetComponentsWithTagEnabled(GetUpdatedEntityID(), "enabled_by_liquid", true)
	if opened == false then
        GamePlaySound( "data/audio/Desktop/projectiles.snd", "projectiles/magic/create", egg_x, egg_y)
		opened = true
		AddFlagPersistent( "apotheosis_card_unlocked_lost_alchemy" )
		AddFlagPersistent( "apotheosis_card_unlocked_lost_alchemy_spell" )
	end
end

function portal_teleport_used( entity_teleported, from_x, from_y, to_x, to_y )
	if( IsPlayer( entity_teleported ) ) then
		if twwegiven == false then
			local x,y = EntityGetTransform(entity_teleported)
			local c = EntityLoad("data/entities/buildings/teleport_meditation_cube_playereffect.xml", x, y)
			EntityAddChild( entity_teleported, c )
			twwegiven = true
		end
	end
end