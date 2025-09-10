dofile_once("data/scripts/lib/utilities.lua")
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local comp = EntityGetFirstComponent( GetUpdatedEntityID(), "VariableStorageComponent", "ghost_id" )
	
	if ( comp ~= nil ) then
		local ghost_id = ComponentGetValue2( comp, "value_int" )
		local x = EntityGetTransform( ghost_id )
		
		if ( x ~= nil ) then
			StatsLogPlayerKill( ghost_id )
		end
	end
end