local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 40

local targets = EntityGetInRadiusWithTag( x, y, r, "player_unit" )

if #targets >= 1 and (GameGetGameEffectCount( targets[1], "PROTECTION_RADIOACTIVITY" ) == 0 or EntityHasTag( targets[1], "vulnerable") == true) then
	--GamePrint("Player detected.. Playing sound effect.")
	GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/watermage/drown_sfx", x, y );
end
