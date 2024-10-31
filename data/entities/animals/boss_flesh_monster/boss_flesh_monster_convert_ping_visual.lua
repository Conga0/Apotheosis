local entity_id = GetUpdatedEntityID()

local pos_x, pos_y = EntityGetTransform( entity_id )
GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/animals/boss_flesh_monster/ping", pos_x, pos_y );
EntityLoad( "data/entities/animals/boss_flesh_monster/particles/convert_flesh_ping.xml", pos_x, pos_y )