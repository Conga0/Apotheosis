dofile_once("data/scripts/lib/utilities.lua")
	
	local comp = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "ghost_id" )
	
	if ( comp ~= nil ) then
		local ghost_id = ComponentGetValue2( comp, "value_int" )
		local x = EntityGetTransform( ghost_id )
		
		if ( x ~= nil ) then
			StatsLogPlayerKill( ghost_id )
		end
	end