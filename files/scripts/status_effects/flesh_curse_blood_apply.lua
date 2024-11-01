
local entity_id    = GetUpdatedEntityID()
local player_id = EntityGetParent(entity_id)

EntityAddComponent( player_id, "LuaComponent",
{
    script_death="mods/Apotheosis/files/scripts/status_effects/flesh_curse_death.lua",
    execute_every_n_frame="-1",
})

local dmgcomp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")
local old_blood = ComponentGetValue2(dmgcomp,"blood_material")

--GamePrint("old_blood: " .. tostring(old_blood))

EntityAddComponent( player_id, "VariableStorageComponent",
{
    name="sacreligious_bloody",
    value_string=old_blood,
})

ComponentSetValue2(dmgcomp,"blood_material","apotheosis_blood_infectious_fading_slow")

local comp = EntityAddComponent(
	entity_id,
	"ParticleEmitterComponent",
	{
	emitted_material_name="apotheosis_blood_infectious_fading_slow",
	fade_based_on_lifetime=false,
	x_pos_offset_min=0,
	x_pos_offset_max=0,
	y_pos_offset_min=0,
	y_pos_offset_max=0,
	x_vel_min=-5,
	x_vel_max=15,
	y_vel_min=-5,
	y_vel_max=5,
	velocity_always_away_from_center=10,
	friction=0.1,
	airflow_force=0.9,
	airflow_time=0.101,
	airflow_scale=0.81,
	count_min=4,
	count_max=6,
	lifetime_min=8.0,
	lifetime_max=10.0,
	create_real_particles=true,
	emit_cosmetic_particles=false,
	collide_with_grid=true,
	render_on_grid=true,
	emission_interval_min_frames=5,
	emission_interval_max_frames=10,
	render_ultrabright=false,
	is_emitting=true,
	}
)

--We can't set these values inherently when creating a new component via lua, so set them here instead
ComponentSetValue2(comp, "area_circle_radius", 5, 5)
ComponentSetValue2(comp, "gravity", 0, 35)