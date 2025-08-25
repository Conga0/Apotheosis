
function retaliate(entity_id,target)
    local r_x,r_y = EntityGetTransform(entity_id)
    local t_x,t_y = EntityGetTransform(target)
    local proj_filepath = "mods/Apotheosis/files/entities/projectiles/orb_wands.xml"
    GameShootProjectile( entity_id, r_x, r_y, t_x, t_y, EntityLoad(proj_filepath,r_x,r_y))
end

function damage_about_to_be_received( damage, x, y, entity_thats_responsible, critical_hit_chance )

    local reduced_damage = damage * 0.3 --Reduce all incoming damage by 70%
    local entity_id = GetUpdatedEntityID()
    local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
    local max_hp = ComponentGetValue2(comp,"max_hp")
    local dmg_cap = max_hp * 0.01

    if math.random(1,4) == 1 then
        retaliate(entity_id,entity_thats_responsible)
    end
    local ndmg = math.min(dmg_cap, reduced_damage)
    return ndmg, 0
end