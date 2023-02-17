

function shot( entity_id )

    local homingspeed=40
    if EntityHasTag(entity_id,"projectile_player") then
        homingspeed=100
    end

    EntityAddComponent2(
        entity_id,
        "HomingComponent",
        {
            homing_targeting_coeff=homingspeed,
            homing_velocity_multiplier=0.86,
        }
    )

    local comp = EntityAddComponent2(
        entity_id,
        "ParticleEmitterComponent",
        {
            emitted_material_name="spark_white",
            x_pos_offset_min=-1,
            x_pos_offset_max=1,
            y_pos_offset_min=-1,
            y_pos_offset_max=1,
            x_vel_min=-2,
            x_vel_max=2,
            y_vel_min=-2,
            y_vel_max=2,
            count_min=1,
            count_max=3,
            is_trail=true,
            trail_gap=1,
            fade_based_on_lifetime=true,
            lifetime_min=0.8,
            lifetime_max=2.0,
            airflow_force=0.6,
            airflow_time=0.401,
            airflow_scale=0.05,
            create_real_particles=false,
            emit_cosmetic_particles=true,
            render_on_grid=true,
            emission_interval_min_frames=1,
            emission_interval_max_frames=2,
            is_emitting=true,
        }
    )
    ComponentSetValue2(comp, "offset", 0, 0)
    ComponentSetValue2(comp, "gravity", 0, 0)
end