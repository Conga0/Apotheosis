
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
    local last_hit_frame = ComponentGetValue2(comp2,"value_float")
    local iframes_duration = 5
    local current_frame = GameGetFrameNum()
    local rng = math.random(1,100)

    if iframes >= current_frame and current_frame ~= last_hit_frame then
        return 0, 0
    end

    if rng < critical_hit_chance then
        local critical_mult = math.max(5,math.floor((critical_hit_chance * 0.05)))
        local x,y = EntityGetTransform(GetUpdatedEntityID())
        GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/critical_hit/create", x, y)
        reduced_damage = reduced_damage * critical_mult
    end

    local iframes_mult = math.floor(math.min(1,(reduced_damage / dmg_cap)) * iframes_duration)

    ComponentSetValue2(comp2,"value_int",math.max(current_frame + iframes_mult,iframes))
    ComponentSetValue2(comp2,"value_float",current_frame)
    --if math.random(1,30) == 1 then
    --    retaliate(entity_id,entity_thats_responsible)
    --end
    local ndmg = math.min(dmg_cap, reduced_damage)
    return ndmg, 0
end