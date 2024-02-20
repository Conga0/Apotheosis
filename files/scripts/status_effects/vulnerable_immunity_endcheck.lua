dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local target = EntityGetRootEntity(entity_id)
if target == 0 then return end

local c_check = false

local children = EntityGetAllChildren(target)
if children then
    for k=1,#children
    do v = children[k]
        if EntityGetName(v) == "apotheosis_protection_lava" then
            c_check = true
        end
    end
end

if c_check ~= true then
    if target ~= nil then
        EntityRemoveTag(target,"weaken_NOT")
    end
end

EntityKill(entity_id)