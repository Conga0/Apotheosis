
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
EntitySetComponentsWithTagEnabled(entity_id,"enabled_by_liquid",false)
EntitySetComponentsWithTagEnabled(entity_id,"magic_music",true)

--Death Laser sound effect
GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/magic/heretic_deathlaser", pos_x, pos_y )
