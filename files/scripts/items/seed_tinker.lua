
local entity_id = GetUpdatedEntityID()
local matinvcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"MaterialInventoryComponent")
local fluid_count = 0
local vscomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local growth_state = ComponentGetValue2(vscomp,"value_int")
local x,y = EntityGetTransform(entity_id)

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

local growth_sizes = {
    {
        stage = 1,
        x_length = 32,
        y_length = 32,
    },
    {
        stage = 2,
        x_length = 64,
        y_length = 64,
    },
    {
        stage = 3,
        x_length = 128,
        y_length = 128,
    },
    {
        stage = 4,
        x_length = 256,
        y_length = 256,
    }
}

function updateHitboxArea(state)
    local hitboxcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"HitboxComponent")
    ComponentSetValue2(hitboxcomp,"aabb_max_x",growth_sizes[state].x_length)
    ComponentSetValue2(hitboxcomp,"aabb_min_x",growth_sizes[state].x_length * -1)
    ComponentSetValue2(hitboxcomp,"aabb_max_y",growth_sizes[state].y_length)
    ComponentSetValue2(hitboxcomp,"aabb_min_y",growth_sizes[state].y_length * -1)
end

if growth_state == 0 and fluid_count >= 1000 then
    --Update graphics to stage 1
    EntityAddTag(entity_id,"workshop")
    ComponentSetValue2(vscomp,"value_int",1)
    updateHitboxArea(growth_state+1)
    ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent"),"image_file","mods/Apotheosis/files/buildings_gfx/seed_tinker_stage_01.png")

elseif growth_state == 1 and fluid_count >= 3000 then
    --Update graphics to stage 2
    ComponentSetValue2(vscomp,"value_int",2)
    updateHitboxArea(growth_state+1)
    ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent"),"image_file","mods/Apotheosis/files/buildings_gfx/seed_tinker_stage_02.png")

elseif growth_state == 2 and fluid_count >= 6000 then
    --Update graphics to stage 3
    ComponentSetValue2(vscomp,"value_int",3)
    updateHitboxArea(growth_state+1)
    ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent"),"image_file","mods/Apotheosis/files/buildings_gfx/seed_tinker_stage_03.png")

elseif growth_state == 3 and fluid_count >= 9999 then
    --Update graphics to stage 4 (final stage)
    ComponentSetValue2(vscomp,"value_int",4)
    updateHitboxArea(growth_state+1)
    EntitySetComponentIsEnabled( entity_id, EntityGetFirstComponentIncludingDisabled(entity_id,"MaterialSuckerComponent"), false )
    ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"MaterialSuckerComponent"), "_tags","")
    ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent"),"image_file","mods/Apotheosis/files/buildings_gfx/seed_tinker_stage_04.png")

end
