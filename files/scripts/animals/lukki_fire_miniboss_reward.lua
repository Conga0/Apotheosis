dofile_once("data/scripts/lib/utilities.lua")

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id = GetUpdatedEntityID()
	local pos_x,pos_y = EntityGetTransform(entity_id)

    GameScreenshake(50, pos_x, pos_y)
    CreateItemActionEntity("APOTHEOSIS_UPGRADE_ALWAYSCAST", pos_x, pos_y)

    --Maybe a bit too dramatic?
    --GamePlaySound( "data/audio/Desktop/animals.bank", "animals/boss_centipede/destroy_face", pos_x, pos_y );
end