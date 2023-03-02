dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
entity_id = EntityGetRootEntity(entity_id)

local pos_x, pos_y = EntityGetTransform( entity_id )
local length = 150

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), pos_x + pos_y + entity_id )

for k=1,8 do
    local angle = math.rad(45 * k)
    local length = 300

    local vel_x = math.cos( angle ) * length
    local vel_y = 0 - math.sin( angle ) * length

    local spells = { "orb_manadrain", "orb_unstable_transmutation", "orb_tele", "orb_hearty", "orb_neutral", "orb_homing", "orb_twitchy" } --Homebringer curse of swapping would be evil... hmmm
    local rnd = Random( 1, #spells )
    local path = "data/entities/animals/boss_flesh_monster/projectiles/master_orbs/" .. spells[rnd] .. ".xml"

    shoot_projectile( entity_id, path, pos_x, pos_y, vel_x, vel_y )
end