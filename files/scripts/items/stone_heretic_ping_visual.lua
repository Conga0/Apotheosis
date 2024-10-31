local entity_id = GetUpdatedEntityID()

local pos_x, pos_y = EntityGetTransform( entity_id )
GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/stone_heretic/ping", pos_x, pos_y );
EntityLoad( "mods/apotheosis/files/entities/particles/stone_heretic_ping.xml", pos_x, pos_y )