
local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/angel/blast", pos_x, pos_y )
