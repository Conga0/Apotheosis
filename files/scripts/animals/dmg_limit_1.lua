
function damage_about_to_be_received( damage, x, y, entity_thats_responsible, critical_hit_chance )
    local rng = math.random(1,100)
    local critical_mult = 1
    if rng < critical_hit_chance then
        critical_mult = 1 + math.max(1,math.floor((critical_hit_chance * 0.01)))
        local x,y = EntityGetTransform(GetUpdatedEntityID())
        GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/critical_hit/create", x, y)
    end
    if damage > 0 then
        return 0.04 * critical_mult
    else
        return damage
    end
end