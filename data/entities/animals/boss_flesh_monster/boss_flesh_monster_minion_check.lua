dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 350

local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "cube_fx" )

for k=1, #targets
do local v = targets[k]
    if EntityHasTag(v,"acid") then
        local eid = EntityLoad( "data/entities/animals/boss_flesh_monster/misc/effect_protection.xml", x, y )
        EntityAddChild( entity_id, eid )
        return
    end
end