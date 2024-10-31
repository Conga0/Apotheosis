local entity_id = GetUpdatedEntityID()
local target_id = EntityGetRootEntity(entity_id)

--If abyssal hex is detected then remove it
local children = EntityGetAllChildren(target_id)
if children then
    for k=1,#children
    do v = children[k]
        if EntityGetName(v) == "apotheosis_hex_water" then
            EntityKill(v)
        end
    end
end