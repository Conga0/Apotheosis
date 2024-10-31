dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()

if GameHasFlagRun( "apotheosis_miniboss_boss_flesh_monster_stone" ) or (GameHasFlagRun("apotheosis_flesh_boss_stone_converted") == false and GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") == false) then
    local comp_id = GetUpdatedComponentID()
    EntityRemoveComponent(entity_id, comp_id)
end

local root_id = EntityGetRootEntity(entity_id)

local pos_x, pos_y = EntityGetTransform( root_id )
local length = 150

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), pos_x + pos_y + root_id )

for k=1,8 do
    local angle = math.rad(45 * k)
    local length = 300

    local vel_x = math.cos( angle ) * length
    local vel_y = 0 - math.sin( angle ) * length

    shoot_projectile( root_id, "mods/Apotheosis/files/entities/projectiles/hexskull_bloodcurse.xml", pos_x, pos_y, vel_x, vel_y )
end