
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
GamePlaySound("data/audio/Desktop/projectiles.bank", "explosions/magic_rocket_mid", x, y)
local child = EntityGetAllChildren(entity_id)[1]
local radius = tonumber(EntityGetName(child))
local spec = EntityGetFirstComponent(child, "SpriteComponent") --[[@cast spec number]]
local cursed = ComponentGetValue2(spec, "image_file"):sub(43,43)=="c" -- e.g. mods/Apotheosis/files/particles/knowledge/4_2.png -> 4, cursed begins with c_ thus returns c==c true
local inner_glow = EntityCreateNew("boom")
EntityAddChild(entity_id, inner_glow)
EntityAddComponent2(inner_glow, "LifetimeComponent", {lifetime=12})
local pec = EntityAddComponent2(inner_glow, "ParticleEmitterComponent", {
	emitted_material_name=cursed and "spark_red" or "spark_white",
	lifetime_min=0.05*radius^0.25+1,
	lifetime_max=0.25*radius^0.25+1,
	count_min=math.floor((math.pi*radius)/3),
	count_max=math.floor((math.pi*radius)/6),
	render_on_grid=true,
	fade_based_on_lifetime=true,
	cosmetic_force_create=false,
	airflow_force=0.5,
	airflow_time=0.1,
	airflow_scale=0.5,
	emission_interval_min_frames=1,
	emission_interval_max_frames=1,
	emit_cosmetic_particles=true,
	is_emitting=true,
	attractor_force=24,
})
EntitySetTransform(inner_glow, x, y)
ComponentSetValue2(pec, "gravity", 0, 0)
ComponentSetValue2(pec, "area_circle_radius", radius+3, radius+6)
--GamePrint"!"
local xv, yv = 0, 1
for i=1, 4 do
	local pec2 = EntityAddComponent2(inner_glow, "ParticleEmitterComponent", {
		emitted_material_name=cursed and "spark_red" or "spark_white",
		lifetime_min=0.066*radius^0.25,
		lifetime_max=0.5*radius^0.25,
		count_min=math.floor((math.pi*radius)/3),
		count_max=math.floor((math.pi*radius)/6),
		render_on_grid=true,
		fade_based_on_lifetime=true,
		cosmetic_force_create=false,
		airflow_force=0.5,
		airflow_time=0.1,
		airflow_scale=0.5,
		emission_interval_min_frames=1,
		emission_interval_max_frames=1,
		emit_cosmetic_particles=true,
		is_emitting=true,
		x_pos_offset_min=-2,
		y_pos_offset_min=-2,
		x_pos_offset_max=2,
		y_pos_offset_max=2,
		x_vel_min=-20,
		y_vel_min=-20,
		x_vel_max=20,
		y_vel_max=20,
	})
	ComponentSetValue2(pec2, "gravity", radius*42*xv, radius*42*yv)
	xv, yv = -yv, xv
end
GameScreenshake(0.25, x, y)