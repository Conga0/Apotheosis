
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)
local tps = EntityGetInRadiusWithTag(x,y,150,"projectile_player") or {}
local tp_count = 0

for k=1, #tps do
    if EntityGetName(tps[k]) == "Divine Toilet Paper of Holy Cleanliness" then
        tp_count = tp_count + 1
    end

    if tp_count > 20 then
        EntitySetComponentsWithTagEnabled(entity_id,"invincible",false)
        break
    end
end

