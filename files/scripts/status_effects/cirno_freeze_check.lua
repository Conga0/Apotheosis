
local entity_id = GetUpdatedEntityID()
local v = EntityGetParent(entity_id)

if EntityHasTag(v,"robot") == true or GameGetGameEffectCount( v, "STUN_PROTECTION_FREEZE" ) > 0 or GameGetGameEffectCount( v, "PROTECTION_FREEZE" ) > 0 then
    local child = EntityLoad("data/entities/misc/effect_frozen_speed_up.xml",pos_x,pos_y)
    EntityAddChild(v,child)
    EntityKill(entity_id)
end
