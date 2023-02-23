
function item_pickup( entity_item, entity_who_picked, item_name )
    GamePrint("$log_apotheosis_flesh_boss_warning")

    local targets = EntityGetWithTag( "pitcheck_b" )
	
	for k=1,#targets
    do local v = targets[k]
		EntitySetComponentsWithTagEnabled( v, "disabled", true )
	end
end