local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

function kill_trees(x,y,r)
    local targets = EntityGetInRadiusWithTag(x,y,r,"vegetation")
    for k=1,#targets do
        EntityKill(targets[k])
    end
end

local did_hit, hit_x, hit_y = Raytrace( pos_x, pos_y, pos_x, pos_y + 300 )

if did_hit then
    EntityLoad("data/entities/animals/forest_monolith.xml", hit_x, hit_y-8)
    kill_trees(hit_x,hit_y,150)
else
    EntityLoad("data/entities/animals/forest_monolith.xml", pos_x, pos_y)
    kill_trees(pos_x,pos_y,300)
end

EntityKill(entity_id)