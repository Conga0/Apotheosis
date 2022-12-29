dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )

local comp = EntityGetFirstComponent( root_id, "DamageModelComponent" )

if ( comp ~= nil ) then
	ComponentObjectSetValue2( comp, "damage_multipliers", "melee", 0.1 )
	ComponentObjectSetValue2( comp, "damage_multipliers", "projectile", 0.3 )
	ComponentObjectSetValue2( comp, "damage_multipliers", "explosion", 0.3 )
	ComponentObjectSetValue2( comp, "damage_multipliers", "electricity", 0.3 )
	ComponentObjectSetValue2( comp, "damage_multipliers", "slice", 0.03 )
	ComponentObjectSetValue2( comp, "damage_multipliers", "ice", 0.8 )
	ComponentObjectSetValue2( comp, "damage_multipliers", "curse", 0.7 )
	ComponentObjectSetValue2( comp, "damage_multipliers", "drill", 0.3 )
end

local sprite_comps = EntityGetComponent(root_id, "SpriteComponent") or {}
for i, comp in ipairs(sprite_comps) do

	ComponentSetValue2(comp, "rect_animation", "healing_exit")

end


--Gets the current Boss phase
local storages = EntityGetComponent( root_id, "VariableStorageComponent" )
if ( storages ~= nil ) then
	for i,comp in ipairs( storages ) do
		local name = ComponentGetValue2( comp, "name" )
		if ( name == "phase_brain" ) then
			phase = ComponentGetValue2( comp, "value_int" )
			break
		end
	end
end

--If phase is 3, then set boss to phase 4, the final phase of the fight
if phase == 3 then
	local storages = EntityGetComponentIncludingDisabled( root_id, "VariableStorageComponent" )[1]
	ComponentSetValue2( storages, "value_int", 4)
end