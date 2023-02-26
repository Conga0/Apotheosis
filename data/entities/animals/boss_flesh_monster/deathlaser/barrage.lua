dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
entity_id = EntityGetRootEntity(entity_id)

local pos_x, pos_y = EntityGetTransform( entity_id )
local length = 150

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), pos_x + pos_y + entity_id )

for k=1,7 do
    local angle = math.rad(Random(0,359))
    local length = Random(200,400)

    local vel_x = math.cos( angle ) * length
    local vel_y = 0 - math.sin( angle ) * length

    shoot_projectile( entity_id, "data/entities/animals/boss_flesh_monster/deathlaser/orb_wands.xml", pos_x, pos_y, vel_x, vel_y )
end