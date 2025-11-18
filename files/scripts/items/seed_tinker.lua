dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)
local matinvcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"MaterialInventoryComponent")
local fluid_count = 0
local vscomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local growth_state = ComponentGetValue2(vscomp,"value_int")
local is_seed_present = ComponentGetValue2(vscomp,"value_bool")
local last_decay_frame = tonumber(ComponentGetValue2(vscomp,"value_string"))
local frames_between_decay_updates = 600
local curr_frame = GameGetFrameNum()

local sprite_comps = EntityGetComponentIncludingDisabled(entity_id,"SpriteComponent")
local sprite_comp_tree = sprite_comps[1]
local sprite_comp_leaves = sprite_comps[2]

local player_inventory_states = {
    slot_is_open = 1,
    inventory_is_open = 2,
    inventory_is_full = 3,
}

function get_player_inventory_state(player_id)
    if GameIsInventoryOpen() then return 2 end

    local player_items = GameGetAllInventoryItems( player_id ) or {}
    local items = getItemTypeFromTable(player_items)
    if #items >= 4 then return 3 end

    return 1
end

local player_tbl = EntityGetWithTag("player_unit") or {}
local tinker_seedslot_id = EntityGetAllChildren(entity_id)[1]
local interactable_comp = EntityGetFirstComponentIncludingDisabled(tinker_seedslot_id,"InteractableComponent")
if #player_tbl > 0 and is_seed_present == false then
    local inventory = EntityGetFirstComponentIncludingDisabled(player_tbl[1], "Inventory2Component")
    local active_item = ComponentGetValue2(inventory, "mActualActiveItem") or 0
    if active_item ~= 0 and EntityGetName(active_item) == "Seed Tinker Apotheosis" then
        EntitySetComponentIsEnabled( tinker_seedslot_id, interactable_comp, true )
    else
        EntitySetComponentIsEnabled( tinker_seedslot_id, interactable_comp, false )
    end
else
    EntitySetComponentIsEnabled( tinker_seedslot_id, interactable_comp, true )
end
EntitySetComponentsWithTagEnabled(tinker_seedslot_id,"enabled_by_script",false)

local mats = ComponentGetValue2(matinvcomp, "count_per_material_type")
for j = 0, #mats, 1 do
    if mats[j+1] ~= 0 and mats[j+1] ~= nil then
        if CellFactory_GetName(j) == "magic_liquid_mana_regeneration" then
            if is_seed_present == false then
                local drained_fluid_count = math.max(0,(growth_state-2) * 2000)
                AddMaterialInventoryMaterial(entity_id,CellFactory_GetName(j),drained_fluid_count)
                fluid_count = drained_fluid_count
            else
                fluid_count = mats[j+1]
            end
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
        seedslot_offset_y = -6,
    },
    {
        stage = 2,
        x_length = 64,
        y_length = 64,
        seedslot_offset_y = -7,
    },
    {
        stage = 3,
        x_length = 128,
        y_length = 128,
        seedslot_offset_y = -15,
    },
    {
        stage = 4,
        x_length = 256,
        y_length = 256,
        seedslot_offset_y = -23,
    }
}

function updateHitboxArea(state)
    local hitboxcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"HitboxComponent")
    ComponentSetValue2(hitboxcomp,"aabb_max_x",growth_sizes[state].x_length)
    ComponentSetValue2(hitboxcomp,"aabb_min_x",growth_sizes[state].x_length * -1)
    ComponentSetValue2(hitboxcomp,"aabb_max_y",growth_sizes[state].y_length)
    ComponentSetValue2(hitboxcomp,"aabb_min_y",growth_sizes[state].y_length * -1)

    local tinker_seedslot_itc = EntityGetFirstComponentIncludingDisabled(tinker_seedslot_id,"InheritTransformComponent")
    local x, y, scale_x, scale_y, rot = ComponentGetValue2(tinker_seedslot_itc, "Transform")
    ComponentSetValue2(tinker_seedslot_itc, "Transform", 0, growth_sizes[state].seedslot_offset_y, scale_x, scale_y, rot)
end

function runUpdateCheck()
    if growth_state == 0 and fluid_count >= 1000 then
        --Update graphics to stage 1
        ComponentSetValue2(vscomp,"value_int",1)
        updateHitboxArea(growth_state+1)
        ComponentSetValue2(sprite_comp_tree,"image_file","mods/Apotheosis/files/buildings_gfx/tinker_tree_stage_01.xml")
        EntityRefreshSprite( entity_id, sprite_comp_tree )

    elseif growth_state == 1 and fluid_count >= 3000 then
        --Update graphics to stage 2
        ComponentSetValue2(vscomp,"value_int",2)
        updateHitboxArea(growth_state+1)
        ComponentSetValue2(sprite_comp_tree,"image_file","mods/Apotheosis/files/buildings_gfx/tinker_tree_stage_02.xml")
        EntityRefreshSprite( entity_id, sprite_comp_tree )

    elseif growth_state == 2 and fluid_count >= 6000 then
        --Update graphics to stage 3
        ComponentSetValue2(vscomp,"value_int",3)
        updateHitboxArea(growth_state+1)
        ComponentSetValue2(sprite_comp_tree,"image_file","mods/Apotheosis/files/buildings_gfx/tinker_tree_stage_03.xml")
        ComponentSetValue2(sprite_comp_leaves,"image_file","mods/Apotheosis/files/buildings_gfx/tinker_tree_stage_03_crystals.xml")
        EntityRefreshSprite( entity_id, sprite_comp_tree )
        EntityRefreshSprite( entity_id, sprite_comp_leaves )
        EntitySetComponentIsEnabled( entity_id, sprite_comp_leaves, true )
        
        EntitySetComponentsWithTagEnabled(tinker_seedslot_id,"enabled_by_script",true)

    elseif growth_state == 3 and fluid_count >= 9999 then
        --Update graphics to stage 4 (final stage)
        ComponentSetValue2(vscomp,"value_int",4)
        updateHitboxArea(growth_state+1)
        EntitySetComponentIsEnabled( entity_id, EntityGetFirstComponentIncludingDisabled(entity_id,"MaterialSuckerComponent"), false )
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"MaterialSuckerComponent"), "_tags","")
        ComponentSetValue2(sprite_comp_tree,"image_file","mods/Apotheosis/files/buildings_gfx/tinker_tree_stage_04.xml")
        ComponentSetValue2(sprite_comp_leaves,"image_file","mods/Apotheosis/files/buildings_gfx/tinker_tree_stage_04_crystals.xml")
        EntityRefreshSprite( entity_id, sprite_comp_tree )
        EntityRefreshSprite( entity_id, sprite_comp_leaves )
        
        EntitySetComponentsWithTagEnabled(tinker_seedslot_id,"enabled_by_script",true)

        --Reward a Desertchievement pillar for the player reaching the maximum growth stage of the tinker tree
        AddFlagPersistent("apotheosis_card_unlocked_full_tinker_tree")
    end
end

function runDecayCheck()
    if growth_state <= 1 then
        EntityKill(entity_id)
        return
    end

    --Update internal data
    ComponentSetValue2(vscomp,"value_int",growth_state-1)
    updateHitboxArea(growth_state-1)
    EntitySetComponentIsEnabled( entity_id, EntityGetFirstComponentIncludingDisabled(entity_id,"MaterialSuckerComponent"), true )

    ComponentSetValue2(sprite_comp_tree,"image_file",table.concat({"mods/Apotheosis/files/buildings_gfx/tinker_tree_stage_0",growth_state-1,".xml"}))
    EntityRefreshSprite( entity_id, sprite_comp_tree )
    if growth_state >= 4 then
        ComponentSetValue2(sprite_comp_leaves,"image_file",table.concat({"mods/Apotheosis/files/buildings_gfx/tinker_tree_stage_0",growth_state-1,"_crystals.xml"}))
        EntityRefreshSprite( entity_id, sprite_comp_leaves )
    else
        EntitySetComponentIsEnabled( entity_id, sprite_comp_leaves, false )
    end

    ComponentSetValue2(vscomp,"value_string",tostring(GameGetFrameNum()))
end

if is_seed_present then
    runUpdateCheck()
elseif curr_frame > last_decay_frame + frames_between_decay_updates then
    runDecayCheck()
end



function interacting(player_id, tinker_seedslot_id, interactable_name)
    local tree_id = EntityGetParent(tinker_seedslot_id)
    local vscomp = EntityGetFirstComponentIncludingDisabled(tree_id,"VariableStorageComponent")
    local is_seed_present = ComponentGetValue2(vscomp,"value_bool")
    local interactable_comp = EntityGetFirstComponentIncludingDisabled(tinker_seedslot_id,"InteractableComponent")

    if is_seed_present == false then
        --Take the seed back
        local seed_id = EntityGetWithName("Seed Tinker Apotheosis")
        EntityKill(seed_id)

        --Update the trees seed status to filled
        ComponentSetValue2(vscomp,"value_bool",true)
        EntitySetComponentsWithTagEnabled(tinker_seedslot_id,"invincible",true)
        ComponentSetValue2(interactable_comp,"ui_text","$building_apotheosis_seed_tinker_remove")
        
        --Prevent any ongoing tree decay
        EntityAddTag(entity_id,"workshop")
        ComponentSetValue2(vscomp,"value_string","0")
        if growth_state > 2 then EntitySetComponentIsEnabled( entity_id, sprite_comp_leaves, true ) EntityRefreshSprite( entity_id, sprite_comp_leaves ) EntitySetComponentsWithTagEnabled(tinker_seedslot_id,"enabled_by_script",true) end
    else
        --Remove the seed
        local slot_x,slot_y = EntityGetTransform(tinker_seedslot_id)
        local seed_item_id = EntityLoad("mods/Apotheosis/files/entities/items/pickups/seed_tinker.xml",slot_x,slot_y)


        if get_player_inventory_state(player_id) == player_inventory_states.slot_is_open then
            GamePickUpInventoryItem( player_id, seed_item_id, true )
        else
            EntitySetComponentsWithTagEnabled( seed_item_id, "enabled_in_world", true )
        end

        --Update the trees seed status to empty
        ComponentSetValue2(vscomp,"value_bool",false)
        EntitySetComponentsWithTagEnabled(tinker_seedslot_id,"invincible",false)
        ComponentSetValue2(interactable_comp,"ui_text","$building_apotheosis_seed_tinker_return")
        if growth_state > 2 then EntitySetComponentsWithTagEnabled(tinker_seedslot_id,"enabled_by_script",true) end

        --Begin tree decay
        EntityRemoveTag(entity_id,"workshop")
        ComponentSetValue2(vscomp,"value_string",tostring(GameGetFrameNum()))
        EntitySetComponentIsEnabled( entity_id, sprite_comp_leaves, false )
    end
end
