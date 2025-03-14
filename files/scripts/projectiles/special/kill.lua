local values = {
    { "lob_min",                       0.0              },
    { "lob_max",                       0.0              },
    { "speed_min",                     100000000000000  },
    { "speed_max",                     100000000000000  },
    { "direction_random_rad",          0                },
    { "on_death_explode",              false            },
    { "on_death_gfx_leave_sprite",     false            },
    { "on_lifetime_out_explode",       false            },
    { "collide_with_entities",         false            },
    { "explosion_dont_damage_shooter", true             },
    { "on_collision_die",              false            },
    { "die_on_liquid_collision",       false            },
    { "lifetime",                      -1               },
    { "damage",                        0                },
    { "ragdoll_force_multiplier",      0.0              },
    { "hit_particle_force_multiplier", 0.0              },
    { "camera_shake_when_shot",        0.0              },
    { "bounce_energy",                 0                },
    { "bounces_left",                  0                },
    { "muzzle_flash_file",             ""               },
    { "shoot_light_flash_radius",      1                },
    { "knockback_force",               0                },
    { "physics_impulse_coeff",         0                },
    { "penetrate_entities",            false            },
    { "penetrate_world",               true             },
    { "damage_every_x_frames",         25               },
    { "collide_with_world",            false            },
    { "collide_with_tag",              ""               },
}
local component_whitelist = {
    ProjectileComponent = true,
    VelocityComponent   = true,
}

local entity_id = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
local comps = EntityGetAllComponents(entity_id) or {}
for i=1,#values do ComponentSetValue2(projcomp, values[i][1], values[i][2]) end
for i=1,#comps do if not component_whitelist[ComponentGetTypeName(comps[i])] then EntityRemoveComponent(entity_id, comps[i]) end end
EntityKill(entity_id)