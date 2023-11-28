
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)
local verbs = EntityGetInRadiusWithTag(x,y,80,"musical_stone") or {}

if #verbs > 3 then
    EntitySetComponentsWithTagEnabled(entity_id,"invincible",false)
    EntityRemoveTag(entity_id,"musical_stone")
end
