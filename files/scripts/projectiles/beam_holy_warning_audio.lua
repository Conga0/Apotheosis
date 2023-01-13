dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/angel/warning", pos_x, pos_y );