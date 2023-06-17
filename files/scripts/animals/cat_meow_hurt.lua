
function damage_received( damage, desc, entity_who_caused, is_fatal )

    local entity_id    = GetUpdatedEntityID()
    local pos_x, pos_y = EntityGetTransform( entity_id )

    SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

    local meowNum = Random( 1, 3)
    if (meowNum == 1) then
        GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/kittycat/sora_hurt_02", pos_x, pos_y );
    elseif (meowNum == 2) then
        GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/kittycat/sora_hurt_04", pos_x, pos_y );
    else
        GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/kittycat/sora_hurt_05", pos_x, pos_y );
    end

end
