--olde and stinky, use ping_visual insteadles
local entity_id = GetUpdatedEntityID()

local pos_x, pos_y = EntityGetTransform( entity_id )
GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/stone_heretic/ping", pos_x, pos_y );