
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
    local entity_id = GetUpdatedEntityID()
    local pos_x,pos_y = EntityGetTransform(entity_id)
    local parent_id = EntityGetRootEntity(entity_id)
    local inheritcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"InheritTransformComponent")
    local segment_id = ComponentGetValue2(inheritcomp,"parent_sprite_id")
    local sprite_comp = EntityGetComponent(parent_id,"SpriteComponent")

    for k=1,#sprite_comp do
        if k == segment_id + 1 then
            --ComponentSetValue2(sprite_comp[k],"image_file","mods/Apotheosis/files/enemies_gfx/worms/worm_maggot_big/worm_maggot_big_exposed.xml")
            ComponentSetValue2(sprite_comp[k],"rect_animation","exposed")
            --EntityRefreshSprite( parent_id, sprite_comp[k] )
            break
        end
    end
   
    local hitboxes = EntityGetComponent( parent_id, "HitboxComponent" )

    if( hitboxes ~= nil ) then
        for k=1,#hitboxes do
            if k == segment_id + 1 then
                local v = hitboxes[k]
                ComponentSetValue2( v, "damage_multiplier", 1 )
                --ComponentSetValue2( v, "aabb_min_", 1 )
                break
            end
        end
    end

    GamePlaySound( "data/audio/Desktop/projectiles.bank", "projectiles/slime_gas/destroy", pos_x, pos_y )
    EntityLoad("mods/Apotheosis/files/entities/projectiles/mist_ominous.xml",pos_x + math.random(-100,100),pos_y + math.random(-100,100))
    EntityLoad("mods/Apotheosis/files/entities/particles/worm_maggot_big_segment_shatter.xml",pos_x,pos_y)
end
