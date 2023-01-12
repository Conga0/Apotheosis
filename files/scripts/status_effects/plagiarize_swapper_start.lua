
dofile("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID() 
local player = EntityGetRootEntity( entity_id ) 
local x,y = EntityGetTransform(player)

--Adds swapper effect to player
EntityAddComponent2(
	player,
	"LuaComponent",
	{
		execute_on_added = false,
		execute_every_n_frame=-1,
		script_damage_received="mods/Apotheosis/files/scripts/status_effects/plagiarize_swapper.lua",
		remove_after_executed = false,
		execute_times=-1
	}
)
GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/megalaser/launch", x, y )

local start_frame = GameGetFrameNum()
GlobalsSetValue( "apotheosis_swapper_curse", tostring(start_frame) )