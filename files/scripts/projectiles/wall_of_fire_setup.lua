
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local fire = {}
local spacing = 10

local targets = EntityGetInRadiusWithTag(pos_x, pos_y, 5, "projectile_player")
for k=1,#targets
do local v = targets[k]
    if EntityGetName(v) == "Wall Of Fire" then
        table.insert(fire,v)
    end
end

for k=1,#fire
do local v = fire[k]
    EntitySetTransform(v,pos_x,pos_y - spacing + (k - 1) * spacing)
end

EntityKill(entity_id)