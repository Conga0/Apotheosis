dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

local entity_id = GetUpdatedEntityID()

--randomly assign the bolt to be anti-tele, maybe inflict wounding, maybe inflict Lex, etc
--Set the projectile's sprite, particle & debuff data here

--Spell book of arcane enchantments?
--Summons wands to fire player spells
--Shoots player spells like sparkbolt with trigger & bolt orb out as regular attacks

local orb_options = {
    {
        --Corrupt Tele Orb
        debuff_file = "mods/Apotheosis/files/entities/misc/effect_teleport_cancel_long.xml",
        sprite_file = "data/projectiles_gfx/orb_blue.xml",
        particle_material = "spark_blue",
        probability = 1.0,
        extra_func = function(entity_id)
            local comp = EntityAddComponent2(
                entity_id,
                "SpriteParticleEmitterComponent",
                {
                    sprite_file="mods/Apotheosis/files/particles/antiteleparticle.xml",
                    delay=0,
                    lifetime=0.4,
                    velocity_slowdown=0,
                    rotation=0,
                    angular_velocity=0,
                    use_velocity_as_rotation=0,
                    emission_interval_min_frames=1,
                    emission_interval_max_frames=4,
                    count_min=1,
                    count_max=3
                }
            )
            ComponentSetValue2(comp, "velocity", 0, 0)
            ComponentSetValue2(comp, "gravity", 0, 0)
            ComponentSetValue2(comp, "color_change", 0, 0, 0, -0.2)
            ComponentSetValue2(comp, "scale", 0.2, 1.0)
            ComponentSetValue2(comp, "scale_velocity", 1.0, -0.2)
            ComponentSetValue2(comp, "randomize_position", -40, 40)
            ComponentSetValue2(comp, "randomize_velocity", -5, 5)
            ComponentSetValue2(comp, "randomize_lifetime", -0.45, 0.2)
        end
    },
    {
        --Corrupt Tele Orb
        debuff_file = "mods/Apotheosis/files/entities/misc/effect_teleport_cancel_long.xml",
        sprite_file = "data/projectiles_gfx/orb_blue.xml",
        particle_material = "",
        probability = 1.0
    },
}

local proj_data = random_from_weighted_table(bolt_options)

if proj_data.bolt_debuff_file then
    EntityAddComponent2(
        entity_id,
        "HitEffectComponent",
        {
            effect_hit="LOAD_UNIQUE_CHILD_ENTITY",
            value_string=bolt_data.bolt_debuff_file
        }
    )
end

if proj_data.sprite_file then
    local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent")
    ComponentSetValue2(comp,"image_file",proj_data.sprite_file)
end

if proj_data.particle_material then
    local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"ProjectileComponent")
    ComponentObjectSetValue2( comp, "config_explosion", "create_cell_material", CellFactory_GetType( proj_data.particle_material ) )
    ComponentObjectSetValue2( comp, "config_explosion", "spark_material", CellFactory_GetType( proj_data.particle_material ) )
end

if proj_data.extra_func then
    proj_data.extra_func(entity_id)
end
