local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local r = 24
local obj_path = ""
local cd_frame = 0
local cd_time = 6 * 60 --Time in seconds

--Grab tablet cooldown frame
local ent_comp = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")
for k=1,#ent_comp
do local v = ent_comp[k]
    if ComponentGetValue2(v,"name") == "tablet_path" then
        cd_frame = ComponentGetValue2(v,"value_int")
    end
end

local tablet =  EntityGetInRadiusWithTag(pos_x, pos_y, r, "tablet")[1]
if tablet and EntityGetParent( tablet ) == 0 and (cd_frame + cd_time < GameGetFrameNum()) then
    local comps = EntityGetComponentIncludingDisabled(tablet,"VariableStorageComponent")
    if comps ~= nil then
        for k=1,#comps
        do local v = comps[k]
            if ComponentGetValue2(v,"name") == "obj_path" then
                obj_path = ComponentGetValue2(v,"value_string")
            end
        end

        local ent_comp = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")
        for k=1,#ent_comp
        do local v = ent_comp[k]
            if ComponentGetValue2(v,"name") == "tablet_path" then
                ComponentSetValue2(v,"value_string",obj_path)
            end
        end

        --Enable Tablet Sprite
        local kids = EntityGetAllChildren(entity_id)
        for k=1,#kids
        do local v = kids[k]
            EntitySetComponentsWithTagEnabled( v, "enabled_by_liquid", true )
        end
        --local sprite_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent")
        --ComponentSetValue2(sprite_comp,"image_file","mods/apotheosis/files/enemies_gfx/playerghost/playerghost_tablet.xml")

        --Set AiAttackComp to use the appropriate tablet it just grabbed
        local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"AIAttackComponent")
        ComponentSetValue2(comp,"attack_ranged_entity_file",obj_path)       --Sets the ghost to throw the exact tablet he caught
        ComponentGetValue2(comp,"mNextFrameUsable",GameGetFrameNum() + 60)  --Prevents the Ghost from instantly throwing the tablet the frame he catches it

        --Enable & disable components related to tablet catching/throwing
        EntitySetComponentsWithTagEnabled( entity_id, "disabled_by_liquid", false )
        EntitySetComponentsWithTagEnabled( entity_id, "enabled_by_liquid", true )

        EntityKill(tablet)
    end
end
