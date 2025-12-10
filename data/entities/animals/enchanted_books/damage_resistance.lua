function find_vsc(name)
    local entity_id = GetUpdatedEntityID()
    local vsc = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent") or {}
    for k=1,#vsc do
        if ComponentGetValue2(vsc[k],"name") == name then
            return vsc[k]
        end
    end
end

function damage_about_to_be_received( damage, x, y, entity_thats_responsible, critical_hit_chance )

    local reduced_damage = damage * 0.3 --Reduce all incoming damage by 70%
    local entity_id = GetUpdatedEntityID()
    local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
    local vsc_comp = find_vsc("iframe_data")
    local max_hp = ComponentGetValue2(comp,"max_hp")
    local dmg_cap = max_hp * 0.05
    local iframes = ComponentGetValue2(vsc_comp,"value_int")
    local last_hit_frame = ComponentGetValue2(vsc_comp,"value_float")
    local iframes_duration = 5
    local current_frame = GameGetFrameNum()
    local rng = math.random(1,100)

    local iframes_mult = math.floor(math.min(1,(reduced_damage / dmg_cap)) * iframes_duration)

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

    ComponentSetValue2(vsc_comp,"value_int",math.max(current_frame + iframes_mult,iframes))
    ComponentSetValue2(vsc_comp,"value_float",current_frame)

    local ndmg = math.min(dmg_cap, reduced_damage)
    return ndmg, 0
end