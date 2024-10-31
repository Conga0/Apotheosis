
function item_pickup( entity_item, entity_who_picked, name )
	local entity_id    = GetUpdatedEntityID()

    local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"ItemComponent")
    ComponentSetValue2(comp,"play_hover_animation",false)
    local comp_id = GetUpdatedComponentID()
    EntityRemoveComponent(entity_id, comp_id)
end
