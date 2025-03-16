
function item_pickup( entity_item, entity_who_picked, name )
	local entity_id = GetUpdatedEntityID()
    local svcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VelocityComponent")
    ComponentSetValue2(svcomp,"gravity_y",400)
end
