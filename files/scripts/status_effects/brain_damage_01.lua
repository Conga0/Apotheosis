
local entity_id = GetUpdatedEntityID()
local parent_id = EntityGetRootEntity(entity_id)
local found = false

local children = EntityGetAllChildren(parent_id)
for k=1,#children do
    local v = children[k]
    if EntityGetName(v) == "apotheosis_brain_damage" then
        found = true
        break
    end
end

if found == false then
    local x,y = EntityGetTransform(parent_id)
    local c = EntityLoad("mods/Apotheosis/files/entities/misc/effect_brain_damage_perma.xml", x, y)
    EntityAddChild(parent_id,c)
end
