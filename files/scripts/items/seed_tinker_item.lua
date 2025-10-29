
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local parent_id = EntityGetParent(entity_id) or 0
local item_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"ItemComponent")
local has_been_taken = ComponentGetValue2(item_comp,"has_been_picked_by_player")

if has_been_taken == true and parent_id == 0 then
    EntityKill(entity_id)
    EntityLoad("mods/Apotheosis/files/entities/buildings/seed_tinker_plant.xml", pos_x, pos_y)
end