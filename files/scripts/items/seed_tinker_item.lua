
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local parent_id = EntityGetParent(entity_id) or 0
local item_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"ItemComponent")
local has_been_taken = ComponentGetValue2(item_comp,"has_been_picked_by_player")

local children = EntityGetAllChildren(entity_id)
local sucker = children[1]
local matinvcomp = EntityGetFirstComponentIncludingDisabled(sucker,"MaterialInventoryComponent")
local fluid_count = 0

local mats = ComponentGetValue2(matinvcomp, "count_per_material_type")
for j = 0, #mats, 1 do
    if mats[j+1] ~= 0 and mats[j+1] ~= nil then
        if CellFactory_GetName(j) == "magic_liquid_mana_regeneration" then
            fluid_count = mats[j+1]
        elseif mats[j+1] > 0 then
            AddMaterialInventoryMaterial(entity_id,CellFactory_GetName(j),0)
        end
    end
end


if has_been_taken == true and parent_id == 0 then

    local comps = EntityGetAllComponents( sucker )
    for k=1,#comps do
        EntitySetComponentIsEnabled( sucker, comps[k], true )
    end

    if fluid_count > 1000 then
        EntityKill(entity_id)
        EntityLoad("mods/Apotheosis/files/entities/buildings/seed_tinker_plant.xml", pos_x, pos_y)
    end
end