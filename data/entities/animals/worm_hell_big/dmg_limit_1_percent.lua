
function retaliate(worm_id,target)
    local hitboxes = EntityGetComponent( EntityGetRootEntity( worm_id ), "HitboxComponent" )
    local childtarget = EntityGetAllChildren( worm_id, "foot" )[1]
    
    if( hitboxes ~= nil ) then
        local itcomp = EntityGetFirstComponentIncludingDisabled(childtarget,"InheritTransformComponent")
        ComponentSetValue2(itcomp,"parent_sprite_id",math.random(1,#hitboxes))
        local r_x,r_y = EntityGetTransform(childtarget)
        local t_x,t_y = EntityGetTransform(target)
        local proj_filepath = "mods/Apotheosis/files/entities/projectiles/orb_devil.xml"
        GameShootProjectile( worm_id, r_x, r_y, t_x, t_y, EntityLoad(proj_filepath,r_x,r_y))
    end
end

function damage_about_to_be_received( damage, x, y, entity_thats_responsible, critical_hit_chance )

    local reduced_damage = damage * 0.3 --Reduce all incoming damage by 70%
    local entity_id = GetUpdatedEntityID()
    local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
    local comp2 = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
    local max_hp = ComponentGetValue2(comp,"max_hp")
    local dmg_cap = max_hp * 0.01
    local iframes = ComponentGetValue2(comp2,"value_int")
    local iframes_duration = 5

    if iframes > 0 and iframes ~= iframes_duration then
        return 0, 0
    end

    ComponentSetValue2(comp2,"value_int",iframes_duration)
    --if math.random(1,30) == 1 then
    --    retaliate(entity_id,entity_thats_responsible)
    --end
    local ndmg = math.min(dmg_cap, reduced_damage)
    return ndmg, 0
end