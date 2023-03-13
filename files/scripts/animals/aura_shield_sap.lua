dofile_once("data/scripts/lib/utilities.lua")

--Made by Copi, cheerio mate!

function EntityGetHitboxCenter( entity )
    local tx, ty = EntityGetTransform( entity );
    local hitbox = EntityGetFirstComponent( entity, "HitboxComponent" );
    if hitbox ~= nil then
        local width = ComponentGetValue2( hitbox, "aabb_max_x" ) - ComponentGetValue2( hitbox, "aabb_min_x" );
        local height = ComponentGetValue2( hitbox, "aabb_max_y" ) - ComponentGetValue2( hitbox, "aabb_min_y" );
        tx = tx + ComponentGetValue2( hitbox, "aabb_min_x" ) + width * 0.5;
        ty = ty + ComponentGetValue2( hitbox, "aabb_min_y" ) + height * 0.5;
    end
    return tx, ty;
end

local entity = GetUpdatedEntityID();
local x, y = EntityGetTransform( entity );
local mortals = EntityGetInRadiusWithTag( x, y, 128, "player_unit" ); --This could be replaced with a genome check if needed for an enemy that encounters creatures with bad genomes, currently only used in a biome with mostly friendly genomes, at least as far as shields are concerned

local function reduce_shield( target )
    local energy_shield = EntityGetFirstComponent( target, "EnergyShieldComponent" );
    if energy_shield then
        local radius = ComponentGetValue2( energy_shield, "radius" );
        local energy = ComponentGetValue2( energy_shield, "energy" );
        local energy_required_to_shield = ComponentGetValue2( energy_shield, "energy_required_to_shield" );
        ComponentSetValue2( energy_shield, "energy", math.max( 0, energy - ComponentGetValue2( energy_shield, "recharge_speed" ) * 0.02 ) );
        local tx, ty = EntityGetHitboxCenter( target );
        SetRandomSeed( tx, ty + GameGetFrameNum() );
        local angle = Random() * math.pi * 2;
        local amount = 1;
        if energy >= energy_required_to_shield then
            amount = 4;
        end
        GameCreateParticle( "plasma_fading", tx + math.cos( angle ) * radius, ty + math.sin( angle ) * radius, amount, Random( -100, 100 ), Random( -100, 100 ), false, false );
    end
    for k,v in ipairs( EntityGetAllChildren( target ) or {} ) do
        reduce_shield( v );
    end
end

for k,v in ipairs( mortals ) do
    reduce_shield( v );
end