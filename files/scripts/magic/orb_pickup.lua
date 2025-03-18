local item_pickup_old = item_pickup
function item_pickup(entity_item, entity_who_picked, item_name)
	-- Do evil orb
	local orbcomp = EntityGetComponent( entity_item, "OrbComponent" )
	local orb_id = -1
	for key,comp_id in pairs(orbcomp) do orb_id = ComponentGetValueInt( comp_id, "orb_id" ) end
	if orb_id >= 100 then
		GameAddFlagRun("apotheosis_evil_knowledge")
	end
	item_pickup_old(entity_item, entity_who_picked, item_name)
end