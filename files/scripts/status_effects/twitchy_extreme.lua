dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local player_id = EntityGetRootEntity( entity_id )
local x, y = EntityGetTransform( entity_id )
SetRandomSeed( GameGetFrameNum(), x + y + entity_id )

if ( player_id ~= entity_id ) then
	edit_component( entity_id, "LuaComponent", function(comp,vars)
		ComponentSetValue2( comp, "execute_every_n_frame", Random( 1, 15 ) )
	end)
	
	edit_component( player_id, "PlatformShooterPlayerComponent", function(comp,vars)
		ComponentSetValue2( comp, "mForceFireOnNextUpdate", true )
	end)
end