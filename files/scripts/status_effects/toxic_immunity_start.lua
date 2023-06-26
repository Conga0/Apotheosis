
local targets = EntityGetWithTag( "player_unit" )

local target = targets[1]

EntitySetDamageFromMaterial( target, "radioactive_gas", 0)
EntitySetDamageFromMaterial( target, "radioactive_gas_static", 0)
EntitySetDamageFromMaterial( target, "apotheosis_radioactive_gas_fading", 0)
EntitySetDamageFromMaterial( target, "rock_static_radioactive", 0)
EntitySetDamageFromMaterial( target, "ice_radioactive_static", 0)
EntitySetDamageFromMaterial( target, "ice_radioactive_glass", 0)
EntitySetDamageFromMaterial( target, "gold_radioactive", 0)
EntitySetDamageFromMaterial( target, "gold_static_radioactive", 0)

--Makes Toxic Immunity actually make you toxic immune
local dmgcomp = EntityGetFirstComponentIncludingDisabled(target,"DamageModelComponent")
ComponentObjectSetValue2( dmgcomp, "damage_multipliers", "radioactive", 0.0 )
