
local entity_id = GetUpdatedEntityID()
local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"GameEffectComponent")
local respawncount = ComponentGetValue2(comp,"mCounter")
if respawncount > 0 then 
    EntityRemoveFromParent(entity_id)
    EntityKill(entity_id)
end
