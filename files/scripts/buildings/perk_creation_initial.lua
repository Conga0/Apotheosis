dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local active = false
local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
for i = 1, #luacomps do
    if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/apotheosis/files/scripts/buildings/perk_creation.lua" then
	active = true
	break
    end
end

if active then return end

local convertlist = {
    "brimstone",
    "stonestone",
    "thunderstone",
    "waterstone",
    "poopstone",
    "seed_a",
    "seed_b",
}

-- abort if conversion already in progress
if #EntityGetInRadiusWithTag(pos_x, pos_y, 10, "forge_item_convert") > 0 then return end

for _,id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 60, "item_pickup")) do
    for k=1, #convertlist
    do local v = convertlist[k];
        if EntityHasTag(id,v) and not EntityHasTag(id,"forge_item_convert") then
            -- make sure item is not carried in inventory or wand
            if EntityGetRootEntity(id) == id then
                -- start gear turning

		local sprite_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")
		ComponentSetValue2(sprite_comp, "rect_animation", "active")

                local c1 = EntityLoad("mods/apotheosis/files/entities/misc/perk_creation_gear_sounds.xml", pos_x-163, pos_y+78)
		local inherit_comp1 = EntityGetFirstComponentIncludingDisabled(c1, "InheritTransformComponent")
		local x1, y1, scale_x1, scale_y1, rot1 = ComponentGetValue2(inherit_comp1, "Transform")
		ComponentSetValue2(inherit_comp1, "Transform", x1-163, y1+76, scale_x1, scale_y1, rot1)
                local c2 = EntityLoad("mods/apotheosis/files/entities/misc/perk_creation_gear_sounds.xml", pos_x+160, pos_y+76)
		local inherit_comp2 = EntityGetFirstComponentIncludingDisabled(c2, "InheritTransformComponent")
		local x2, y2, scale_x2, scale_y2, rot2 = ComponentGetValue2(inherit_comp2, "Transform")
		ComponentSetValue2(inherit_comp2, "Transform", x2+160, y2+76, scale_x2, scale_y2, rot2)
                EntityAddChild(entity_id,c1)
                EntityAddChild(entity_id,c2)

                EntityAddComponent2(
                    entity_id,
                    "LuaComponent",
                    {
                        execute_on_added = false,
                        script_source_file = "mods/apotheosis/files/scripts/buildings/perk_creation.lua",
                        execute_every_n_frame = 96
                    }
                )

                EntityAddComponent2(
                    entity_id,
                    "LuaComponent",
                    {
                        execute_on_added = false,
                        script_source_file = "mods/apotheosis/files/scripts/buildings/perk_creation_end.lua",
                        execute_every_n_frame = 144,
                        remove_after_executed = true,
                        execute_times = 1
                    }
                )
                return
            end
        end
    end
end
