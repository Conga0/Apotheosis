
function damage_received( damage, desc, entity_who_caused, is_fatal )

    local entity_id    = GetUpdatedEntityID()
    local pos_x, pos_y = EntityGetTransform( entity_id )

    SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

    local meowNum = Random( 1, 5)
    
    --17/01/2024 Conga: Ancient janky code
    --60% chance for no sound on hit
    --40% chance to hiss

    if (meowNum == 1) then
        --Hiss
        GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/kittycat/sora_hurt_06", pos_x, pos_y );
    elseif (meowNum == 2) then
        --Hiss
        GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/kittycat/sora_hurt_07", pos_x, pos_y );
    end

end