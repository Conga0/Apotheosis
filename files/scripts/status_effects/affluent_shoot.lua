

function shot( entity_id )

    --Adds homing to a projectile using designated values
    EntityAddComponent2(
        entity_id,
        "HitEffectComponent",
        {
            effect_hit="LOAD_UNIQUE_CHILD_ENTITY",
            value_string="mods/apotheosis/files/entities/misc/drop_gold.xml"
        }
    )

    --Adds homing particle effects to the projectile
    local comp = EntityAddComponent2(
        entity_id,
        "ParticleEmitterComponent",
        {
            emitted_material_name="gold",
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
    --We can't set these values inherently when creating a new component via lua, so set them here instead
    ComponentSetValue2(comp, "offset", 0, 0)
    ComponentSetValue2(comp, "gravity", 0, 0)
end