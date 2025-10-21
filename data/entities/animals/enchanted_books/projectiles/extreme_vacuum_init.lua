local entity_id    = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ProjectileComponent")
local owner_id = ComponentGetValue2(projcomp,"mWhoShot")
local animalAiComp = EntityGetFirstComponentIncludingDisabled(owner_id,"AnimalAIComponent")
local current_target = ComponentGetValue2(animalAiComp,"mGreatestPrey") or ComponentGetValue2(animalAiComp,"mGreatestThreat") or 0

if current_target == 0 then
    current_target = owner_id
end

local targ_x,targ_y = EntityGetTransform(current_target)

EntitySetTransform( entity_id, targ_x, targ_y)
