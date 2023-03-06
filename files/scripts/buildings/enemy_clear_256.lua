local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)
local r = 256
local targets = EntityGetInRadiusWithTag(x,y,r,"mortal")

for k=1,#targets
do v= targets[k]
    if EntityHasTag(v,"player_unit") == false then
        EntityKill(v)
    end
end

EntityKill(entity_id)