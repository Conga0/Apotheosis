dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )

local phase = 0

local storages = EntityGetComponent( root_id, "VariableStorageComponent" )

--Gets the current Boss phase
if ( storages ~= nil ) then
	for i,comp in ipairs( storages ) do
		local name = ComponentGetValue2( comp, "name" )
		if ( name == "phase_brain" ) then
			phase = ComponentGetValue2( comp, "value_int" )
			break
		end
	end
end

--If post is in the dying phase, cancel healing
if phase == 5 then
	EntityKill(entity_id)
else
	local comp = EntityGetFirstComponent( root_id, "DamageModelComponent" )

	if ( comp ~= nil ) then
		ComponentObjectSetValue2( comp, "damage_multipliers", "melee", 0 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "projectile", 0 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "explosion", 0 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "electricity", 0 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "slice", 0 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "ice", 0 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "curse", 0 )
		ComponentObjectSetValue2( comp, "damage_multipliers", "drill", 0 )
	end
end