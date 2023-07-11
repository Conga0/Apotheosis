
--I'll be honest, you caught me lackin
--These should be done through their own unique individual pixel scenes.. but there was so much code and I was tired, I just.. ugh..
--It'll only break if some other mod hijacks mountain_hall.lua and also hijacks the spawn_music_trigger function
--...No way anyone would *ever* use function spawn_music_trigger though.... right?

--PRANKED, check this code out, hijack it all you want nerds!!!

function collision_trigger()
	local entity_id = GetUpdatedEntityID()

    --Luring a Master of Trolling to his statue outline
    if HasFlagPersistent( "apotheosis_card_unlocked_rage_aura" ) then
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_master_of_trolling.xml", 4288, 2150 )
    else
        EntityLoad( "mods/Apotheosis/files/entities/props/statue_empty.xml", 4288, 2150 )
        EntityLoad( "data/entities/buildings/trophy_room_trolling_check.xml", 4308, 2155 )
    end


    EntityLoad( "data/entities/buildings/statue_room_fairy_populator.xml", 4256, 2100 ) -- North
    EntityLoad( "data/entities/buildings/statue_room_fairy_populator.xml", 4256, 2261 ) -- South

    EntityLoad( "data/entities/buildings/rat_unlock.xml", 4064, 2320 )
    EntityLoad( "data/entities/buildings/rat_create.xml", 4064, 2320 )

    EntityLoad( "data/entities/buildings/trophy_room_trolling_spawner.xml", 5318, 2037 )

    EntityKill(entity_id)
end
