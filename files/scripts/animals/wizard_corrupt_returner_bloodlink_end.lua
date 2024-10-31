
local entity_id = GetUpdatedEntityID()

--Enable movement
local velocity_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VelocityComponent")
local characterdata_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterDataComponent")
EntitySetComponentIsEnabled(entity_id, velocity_comp, true)
EntitySetComponentIsEnabled(entity_id, characterdata_comp, true)

-- disables normal sprites + enables bloodlinked sprites
EntitySetComponentsWithTagEnabled(entity_id, "disabled_by_liquid", false)
EntitySetComponentsWithTagEnabled(entity_id, "enable_when_player_seen", true)

local sprite_comps = EntityGetComponent(entity_id, "SpriteComponent") or {}
for i, comp in ipairs(sprite_comps) do
	if ComponentHasTag( comp, "enable_when_player_seen" ) or ComponentHasTag( comp, "disabled_by_liquid" ) then
		ComponentAddTag(comp, "character" )
	end
end

local particle_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteParticleEmitterComponent")
ComponentSetValue2(particle_comp, "sprite_file", "mods/Apotheosis/files/particles/shine_red.xml")
ComponentSetValue2(particle_comp, "randomize_velocity", -40, -40, 40, 40)

local c = EntityGetAllChildren( entity_id )
for a,b in ipairs( c ) do
	local capename = EntityGetName( b )

	if ( capename == "cape" ) then
		local verlet_comps = EntityGetComponent(b, "VerletPhysicsComponent") or {}
		for i, comp in ipairs(verlet_comps) do
			ComponentSetValue2(comp, "cloth_color_edge", 0xFFbabaff) --Baba! :o
			ComponentSetValue2(comp, "cloth_color", 0xFF4f4254)
		end
	end
 end

EntityAddComponent(entity_id, "AudioLoopComponent", {
	file="data/audio/Desktop/projectiles.bank",
	event_name="player_projectiles/meteor/loop",
	auto_play=true,
}) 

EntityAddComponent(entity_id, "LuaComponent", {
	script_source_file="mods/Apotheosis/files/scripts/animals/wizard_corrupt_returner_bloodlink_check.lua",
	execute_every_n_frame=10,
	execute_on_added=0,
	remove_after_executed=0
}) 