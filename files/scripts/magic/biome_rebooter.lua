
local entity_id = GetUpdatedEntityID()
local parent = EntityGetParent(entity_id)

local children = EntityGetAllChildren(parent_id) or {}
for l=1,#children do
    local comps = EntityGetComponentIncludingDisabled(l,"BiomeTrackerComponent") or {}
    for i=1,#comps do
        EntitySetComponentIsEnabled(l,i,true)
    end
end