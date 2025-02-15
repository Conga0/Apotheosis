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

    local proj_id = shoot_projectile( root_id, "mods/Apotheosis/files/entities/projectiles/hexskull_bloodcurse.xml", pos_x, pos_y, vel_x, vel_y )
    local projcomp = EntityGetFirstComponentIncludingDisabled( proj_id, "ProjectileComponent" )
    ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("mage_corrupted"))
    local velcomp = EntityGetFirstComponentIncludingDisabled( proj_id, "VelocityComponent" )
    ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y)
    ComponentSetValue2(velcomp, "mPrevVelocity", vel_x, vel_y)
    EntityAddComponent(proj_id, "LuaComponent", {
	script_source_file="mods/Apotheosis/files/scripts/projectiles/proj_no_flip.lua",
	execute_every_n_frame=1
    })
end