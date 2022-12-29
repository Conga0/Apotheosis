dofile_once("data/scripts/lib/utilities.lua")

function material_area_checker_success( pos_x, pos_y )
	local entity_id = GetUpdatedEntityID()
	local x,y = EntityGetTransform(entity_id)

    
	EntityLoad("data/entities/particles/image_emitters/magical_symbol.xml", pos_x, pos_y)
	EntityLoad("mods/Apotheosis/files/entities/particle_generators/smoke_cloud_generator_nolua.xml", pos_x, pos_y)
	EntityLoad("mods/Apotheosis/files/entities/buildings/enable_wand_tinkering.xml", pos_x, pos_y)
    GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
    GameTriggerMusicEvent( "music/oneshot/heaven_03", true, pos_x, pos_y )
	GamePlaySound( "data/audio/Desktop/projectiles.snd", "player_projectiles/crumbling_earth/create", pos_x, pos_y)
    
    --Spawn the orb of Divine Knowledge
    if HasFlagPersistent( "apotheosis_card_unlocked_secret_knowledge_of_kings" ) ~= true then
        EntityLoad( "mods/Apotheosis/files/entities/items/orbs/orb_divine_cape_unlock.xml", pos_x - 1, pos_y )
        EntitySetComponentsWithTagEnabled(entity_id, "enabled_by_liquid", true)
        EntitySetComponentsWithTagEnabled(entity_id, "disabled_by_liquid", false)
    else
        EntityLoad( "mods/Apotheosis/files/entities/items/orbs/orb_divine_heart.xml", pos_x - 1, pos_y )
        EntitySetComponentsWithTagEnabled(entity_id, "enabled_by_liquid", true)
        EntitySetComponentsWithTagEnabled(entity_id, "disabled_by_liquid", false)
    end

    --Unnecessary to kill after finishing as the material conversion components will kill it after we're finished anyways
    --EntityKill( entity_id )
end