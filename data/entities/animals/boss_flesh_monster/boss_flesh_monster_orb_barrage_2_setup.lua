dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 350

local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "player_unit" )

target = targets[1]
if target ~= nil then
    local cid = EntityLoad( "data/entities/animals/boss_flesh_monster/projectiles/orb_barrage_setup_2.xml", pos_x, pos_y )
    EntityAddChild( entity_id, cid )
end
