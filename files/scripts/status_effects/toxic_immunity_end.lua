dofile_once("data/scripts/lib/utilities.lua")

local targets = EntityGetWithTag( "player_unit" )

local target = targets[1]
local valid = true

s= EntityGetComponent( target, "GameEffectComponent" )
if ( s ~= nil ) then
    for i,v in ipairs( s ) do
        local name = ComponentGetValue2( v, "effect" )
        
        if ( name == "PROTECTION_RADIOACTIVITY" ) then
            valid = false
        end
    end
end


if target ~= nil then
    if valid == true then
        EntitySetDamageFromMaterial( target, "radioactive_gas", 0.001)
        EntitySetDamageFromMaterial( target, "radioactive_gas_static", 0.001)
        EntitySetDamageFromMaterial( target, "rock_static_radioactive", 0.001)
        EntitySetDamageFromMaterial( target, "ice_radioactive_static", 0.001)
        EntitySetDamageFromMaterial( target, "ice_radioactive_glass", 0.001)
        EntitySetDamageFromMaterial( target, "gold_radioactive", 0.001)
        EntitySetDamageFromMaterial( target, "gold_static_radioactive", 0.001)
    end
end