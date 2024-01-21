
local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )

local comp = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "effect_curse_wither_type" )

if ( comp ~= nil ) then
	local name = ComponentGetValue2( comp, "value_string" )
	
	comp = EntityGetFirstComponent( root_id, "DamageModelComponent" )
	
	if ( comp ~= nil ) then
		--local mult = ComponentObjectGetValue2( comp, "damage_multipliers", name )
		--mult = mult - 1.00
		ComponentObjectSetValue2( comp, "damage_multipliers", name, 0 )
	end
end