dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )

local superhealing = ModIsEnabled("nightmare") or ModIsEnabled("purgatory")

local comp = EntityGetFirstComponent( root_id, "DamageModelComponent" )

EntitySetComponentsWithTagEnabled( entity_id, "invincible", true )

if ( comp ~= nil ) then
	if superhealing then
		ComponentObjectSetValue2( comp, "damage_multipliers", "melee", -1.0 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "projectile", -1.0 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "explosion", -1.0 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "electricity", -1.0 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "slice", -0.25 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "ice", -1.0 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "curse", -1.0 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "drill", -1.0 )
	else
		ComponentObjectSetValue2( comp, "damage_multipliers", "melee", -0.4 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "projectile", -0.4 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "explosion", -0.4 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "electricity", -0.4 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "slice", -0.1 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "ice", -0.4 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "curse", -0.4 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "drill", -0.4 )
	end
end
