
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)
local tps = EntityGetInRadiusWithTag(x,y,150,"projectile_player") or {}
local tp_count = 0

for k=1, #tps do
    if EntityGetName(tps[k]) == "apotheosis_toilet_trail" then
        tp_count = tp_count + 1
    end

    if tp_count > 80 then
        EntityKill(entity_id)
        break
    end
end

