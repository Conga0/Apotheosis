dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local target = EntityGetRootEntity(entity_id)
if target == 0 then return end

local c_check = false

local children = EntityGetAllChildren(target)
if children then
    for k=1,#children
    do v = children[k]
        if EntityGetName(v) == "apotheosis_protection_toxic" then
            c_check = true
        end
    end
end

if c_check ~= true then
    local valid = true

    local s = EntityGetComponent( target, "GameEffectComponent" )
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
            EntitySetDamageFromMaterial( target, "apotheosis_radioactive_gas_fading", 0.001)
            EntitySetDamageFromMaterial( target, "rock_static_radioactive", 0.001)
            EntitySetDamageFromMaterial( target, "ice_radioactive_static", 0.001)
            EntitySetDamageFromMaterial( target, "ice_radioactive_glass", 0.001)
            EntitySetDamageFromMaterial( target, "gold_radioactive", 0.001)
            EntitySetDamageFromMaterial( target, "gold_static_radioactive", 0.001)

            --Makes Toxic Immunity actually make you toxic immune
            local dmgcomp = EntityGetFirstComponentIncludingDisabled(target,"DamageModelComponent")
            ComponentObjectSetValue2( dmgcomp, "damage_multipliers", "radioactive", 1.0 )            
        end
    end
end

EntityKill(entity_id)