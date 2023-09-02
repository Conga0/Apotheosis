local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 40

local targets = EntityGetInRadiusWithTag( x, y, r, "player_unit" )

if #targets >= 1 and GameGetGameEffectCount( targets[1], "BREATH_UNDERWATER" ) == 0 then
	--GamePrint("Player detected.. Playing sound effect.")
	GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/watermage/drown_sfx", x, y );
end