
function item_pickup( entity_item, entity_who_picked, item_name )
if GameHasFlagRun("apotheosis_new_runny") then
    local entity_id = GetUpdatedEntityID()
    local comp_id = GetUpdatedComponentID()
    EntityRemoveComponent(entity_id,comp_id)
else
--Since Heretic now has a new spawn incase people are in old runs then Heretic will spawn how he normally does
--We also activate the stone grabbed flag so he actually drops the stone seeing as it wouldn't exist
    GamePrint("$log_apotheosis_flesh_boss_warning")
    GameAddFlagRun("apotheosis_flesh_boss_released")
    GameAddFlagRun("apotheosis_miniboss_boss_flesh_monster_stone")

    local targets = EntityGetWithTag( "pitcheck_b" )
	
	for k=1,#targets
    do local v = targets[k]
		EntitySetComponentsWithTagEnabled( v, "disabled", true )
	end
end
end