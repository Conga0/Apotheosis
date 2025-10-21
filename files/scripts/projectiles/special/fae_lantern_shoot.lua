dofile_once("data/scripts/lib/utilities.lua")

--Worm Firing Data
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local enemy_count = #(EntityGetInRadiusWithTag(x,y,192,"homing_target") or {})
local projectile_damage_mult = 1.5 --Damage multiplier

function SplitStringOnCharIntoTable(string, char)
    local list = {}
    for w in (string .. char):gmatch("([^" .. char .. "]*)" .. char) do
        table.insert(list, w)
    end
    return list
end

--Gun Info
local extract = dofile_once("mods/Apotheosis/files/scripts/misc/proj_data.lua")
local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ProjectileComponent")
local gun_data = extract(projcomp, {2})
local gun_info = SplitStringOnCharIntoTable(gun_data,string.char(255))

--Handles actually shooting the projectiles we want
if enemy_count > 0 then
    local target = EntityGetClosestWithTag(  x, y, "enemy" )
    SetRandomSeed( GameGetFrameNum(), x + y + entity_id )
    local r_x,r_y = EntityGetTransform(entity_id)
    local t_x,t_y = EntityGetTransform(target)

    local pid = EntityLoad("mods/Apotheosis/files/entities/projectiles/deck/fae_lantern_projectile.xml",r_x,r_y)
    GameShootProjectile( entity_id, r_x, r_y, t_x, t_y, pid)
    local pvcomp = EntityGetFirstComponentIncludingDisabled(pid,"VelocityComponent")
    local vel_x, vel_y = ComponentGetValue2(pvcomp,"mVelocity")
    local speed_mult = gun_info[23] or 1 -- Projectile speed
    ComponentSetValue2(pvcomp,"mVelocity", vel_x * speed_mult, vel_y * speed_mult)
    ComponentSetValue2(pvcomp,"gravity_y",ComponentGetValue2(pvcomp,"gravity_y") + (gun_info[53]or 0))
    local pcomp = EntityGetFirstComponentIncludingDisabled(pid,"ProjectileComponent")
    local owner_id = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"ProjectileComponent"),"mWhoShot") or 0
    ComponentSetValue2(pcomp,"mWhoShot",owner_id)
    local ohcomp = EntityGetFirstComponentIncludingDisabled(owner_id,"GenomeDataComponent")
    ComponentSetValue2(pcomp,"mShooterHerdId",ohcomp ~= 0 and ComponentGetValue2(ohcomp,"herd_id") or StringToHerdId("player"))

    --If an enemy is shooting the spell, set the homing target to be 'prey'
    if EntityHasTag(owner_id,"player_unit") == false then
        ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(pid,"HomingComponent"),"target_tag","prey")
    end

    ---Gun data time
    --Damage
        ComponentSetValue2(pcomp,"damage",ComponentGetValue2(pcomp,"damage") + (gun_info[32] * projectile_damage_mult))
        local damagetypes = {
            "melee",
            "projectile",
            "electricity",
            "fire",
            "explosion",
            "ice",
            "slice",
            "healing",
            "curse",
            "drill",
        }
        for u=1,#damagetypes do
            if u ~= 2 or u~= 5 then --2 is projectile, 5 is explosive, both are handled differently
                ComponentObjectSetValue2( pcomp, "damage_by_type", damagetypes[u], ComponentObjectGetValue2( pcomp, "damage_by_type", damagetypes[u]) + (gun_info[30+u] * projectile_damage_mult))
            end
        end
    --Extra Entities
        local extra_children = SplitStringOnCharIntoTable(gun_info[62], ",")
        for u=1,#extra_children do
            if #extra_children[u] > 1 then
                EntityLoadToEntity(extra_children[u],pid)
            end
        end
    --Critical Damage
        ComponentObjectSetValue2( pcomp, "damage_critical", "chance", ComponentObjectGetValue2( pcomp, "damage_critical", "chance") + gun_info[42])
        ComponentObjectSetValue2( pcomp, "damage_critical", "damage_multiplier", ComponentObjectGetValue2( pcomp, "damage_critical", "damage_multiplier") + gun_info[43])
    --Explosions
        ComponentObjectSetValue2( pcomp, "config_explosion", "damage", ComponentObjectGetValue2( pcomp, "config_explosion", "damage") + (gun_info[35] * projectile_damage_mult))
        ComponentObjectSetValue2( pcomp, "config_explosion", "explosion_radius", ComponentObjectGetValue2( pcomp, "config_explosion", "explosion_radius") + gun_info[26])
    --Bounces
        ComponentSetValue2(pcomp,"bounces_left",tonumber(gun_info[52]))
        if tonumber(gun_info[52]) > 0 then
            ComponentSetValue2(pcomp,"bounce_always",true)
            ComponentSetValue2(pcomp,"bounce_energy",0.9)
        end
    --Friendly Fire
        if tostring(gun_info[58]) == "true" then --Why do you only work like this? -Conga
            EntityAddTag(pid,"friendly_fire_enabled")
            ComponentSetValue2(pcomp,"friendly_fire", true)
            ComponentSetValue2(pcomp, "collide_with_shooter_frames", 6 )
        end
    ---Misc Data (Specify)
    --Lifetime
    ComponentSetValue2(pcomp,"lifetime",ComponentGetValue2(pcomp,"lifetime") + gun_info[60])
end
