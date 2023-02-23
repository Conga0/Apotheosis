dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()

local pos_x, pos_y = EntityGetTransform( entity_id )
local length = 150

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), pos_x + pos_y + entity_id )

for k=1,6 do
    local angle = math.rad(Random(0,359))
    local length = Random(200,400)

    local vel_x = math.cos( angle ) * length
    local vel_y = 0 - math.sin( angle ) * length

    shoot_projectile( entity_id, "mods/apotheosis/files/entities/projectiles/aquamine_slowhome.xml", pos_x, pos_y, vel_x, vel_y )
end

EntityLoad("mods/apotheosis/files/entities/particles/circle_fast_blue.xml", pos_x, pos_y)