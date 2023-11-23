
local entity_id    = GetUpdatedEntityID()
local player_id = EntityGetParent(entity_id)

EntityAddComponent( player_id, "LuaComponent",
{
    script_death="mods/apotheosis/files/scripts/status_effects/flesh_curse_death.lua",
    execute_every_n_frame="-1",
})

    EntityAddComponent(
        entity_id,
        "ParticleEmitterComponent",
        {
		emitted_material_name="apotheosis_blood_infectious_fading_slow"
		fade_based_on_lifetime="0",
		x_pos_offset_min="0",
		x_pos_offset_max="0",
		y_pos_offset_min="0",
		y_pos_offset_max="0",
		x_vel_min="-5",
		x_vel_max="15",
		y_vel_min="-5",
		y_vel_max="5",
		area_circle_radius.min="5",
		area_circle_radius.max="5",
		velocity_always_away_from_center="10",
		gravity.y="35",
		friction="0.1",
		airflow_force="0.9",
		airflow_time="0.101",
		airflow_scale="0.81",
		count_min="1",
		count_max="4",
		lifetime_min="1.0",
		lifetime_max="5.0",
		create_real_particles="1",
		emit_cosmetic_particles="0",
		collide_with_grid="1",
		render_on_grid="1",
		emission_interval_min_frames="5",
		emission_interval_max_frames="10",
		render_ultrabright="0",
		is_emitting="1",
        }
    )