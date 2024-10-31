
local entity_id = GetUpdatedEntityID()

local var_comp = nil
local var_comps = EntityGetComponent(entity_id, "VariableStorageComponent") or {}
for i, comp in ipairs(var_comps) do
	if ComponentGetValue2(comp,"name") == "bloodlinker" then
		var_comp = comp
	end
end
local cooldown = 15 * 60 --Cooldown for 15 seconds
local frame = GameGetFrameNum() + cooldown
ComponentSetValue2(var_comp, "value_int", frame)
ComponentSetValue2(var_comp, "value_bool", false)

-- disables normal sprites + enables bloodlinked sprites
EntitySetComponentsWithTagEnabled(entity_id, "disabled_by_liquid", true)
EntitySetComponentsWithTagEnabled(entity_id, "enable_when_player_seen", false)

local sprite_comps = EntityGetComponent(entity_id, "SpriteComponent") or {}
for i, comp in ipairs(sprite_comps) do
	if ComponentHasTag( comp, "enable_when_player_seen" ) or ComponentHasTag( comp, "disabled_by_liquid" ) then
		ComponentAddTag(comp, "character" )
	end
end

--Enable movement
local velocity_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VelocityComponent")
local characterdata_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterDataComponent")
EntitySetComponentIsEnabled(entity_id, velocity_comp, true)
EntitySetComponentIsEnabled(entity_id, characterdata_comp, true)

local particle_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteParticleEmitterComponent")
ComponentSetValue2(particle_comp, "sprite_file", "data/particles/shine_blue.xml")
ComponentSetValue2(particle_comp, "randomize_velocity", -5, -5, 5, 5)

local c = EntityGetAllChildren( entity_id )
for a,b in ipairs( c ) do
	local capename = EntityGetName( b )

	if ( capename == "cape" ) then
		local verlet_comps = EntityGetComponent(b, "VerletPhysicsComponent") or {}
		for i, comp in ipairs(verlet_comps) do
			ComponentSetValue2(comp, "cloth_color_edge", 0xFFfffcba)
			ComponentSetValue2(comp, "cloth_color", 0xFF6b4d38)
		end
	end
 end