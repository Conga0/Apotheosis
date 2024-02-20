
local worm_id = GetUpdatedEntityID()
local target = EntityGetWithTag("player_unit")[1]
if target ~= nil then  
    local hitboxes = EntityGetComponent( EntityGetRootEntity( worm_id ), "HitboxComponent" )
    local childtarget = EntityGetAllChildren( worm_id, "foot" )[1]

    if( hitboxes ~= nil ) then
        local itcomp = EntityGetFirstComponentIncludingDisabled(childtarget,"InheritTransformComponent")
        ComponentSetValue2(itcomp,"parent_sprite_id",math.random(1,#hitboxes))
        local r_x,r_y = EntityGetTransform(childtarget)
        r_x = r_x + math.random(-100,100)
        r_y = r_y + math.random(-100,100)
        local t_x,t_y = EntityGetTransform(target)
        local proj_filepath = "data/entities/projectiles/enlightened_laser_fire_wand.xml"
        GameShootProjectile( worm_id, r_x, r_y, t_x, t_y, EntityLoad(proj_filepath,r_x,r_y))
    end
end
