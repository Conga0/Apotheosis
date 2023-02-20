local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 40

local targets = EntityGetInRadiusWithTag( x, y, r, "player_unit" )

if #targets >= 1 then
	--GamePrint("Player detected.. Playing sound effect.")
	GamePlaySound( "data/audio/Desktop/player.bank", "player/land_water", x, y );
end