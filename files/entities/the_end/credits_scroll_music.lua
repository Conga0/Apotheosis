dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

GameTriggerMusicFadeOutAndDequeueAll()
GamePlaySound( "data/audio/Desktop/music.bank", "music/credits/02", pos_x, pos_y );
