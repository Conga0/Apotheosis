local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 350

local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "player_unit" )

target = targets[1]
if target ~= nil then
    local cid = EntityLoad( "data/entities/animals/boss_flesh_monster/deathlaser/deathlaser_helper.xml", pos_x, pos_y )
    EntityAddChild( entity_id, cid )
end
