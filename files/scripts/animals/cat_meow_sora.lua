dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )


if (Random( 1, 13) == 13) then
    
    if (Random( 1, 30) == 30) then
        GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/kittycat/sora_sneeze_01", pos_x, pos_y );
    else
        local meowNum = Random( 1, 8)
        if (meowNum == 8) then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/kittycat/sora_meow_01", pos_x, pos_y );
        elseif (meowNum == 7) then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/kittycat/sora_meow_02", pos_x, pos_y );
        elseif (meowNum == 6) then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/kittycat/sora_meow_03", pos_x, pos_y );
        elseif (meowNum == 5) then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/kittycat/sora_meow_04", pos_x, pos_y );
        elseif (meowNum == 4) then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/kittycat/voc_attack_purr_01", pos_x, pos_y );
        elseif (meowNum == 3) then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/kittycat/meow_01", pos_x, pos_y );
        elseif (meowNum == 2) then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/kittycat/meow_02", pos_x, pos_y );
        else
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/kittycat/meow_03", pos_x, pos_y );
        end
    end
end