function death()
	local entity_id = GetUpdatedEntityID()
	local x,y = EntityGetTransform( entity_id )
	
	local file = EntityGetFilename( entity_id )
	
	if ( file ~= nil ) and ( #file > 0 ) then
		local eid = EntityLoad( "mods/apotheosis/files/entities/misc/necrobot_revive_gold.xml", x, y )
		local comp = EntityGetFirstComponent( eid, "VariableStorageComponent", "necrobot_entity_file" )
		
		if ( comp ~= nil ) then
			ComponentSetValue2( comp, "value_string", file )
		end
	end
end