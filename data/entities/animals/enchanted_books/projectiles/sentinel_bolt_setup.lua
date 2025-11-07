dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

local entity_id = GetUpdatedEntityID()

--randomly assign the bolt to be anti-tele, maybe inflict wounding, maybe inflict Lex, etc
--Set the projectile's sprite, particle & debuff data here

--Spell book of arcane enchantments?
--Summons wands to fire player spells
--Shoots player spells like sparkbolt with trigger & bolt orb out as regular attacks

function rgba_translate(rgba_data)
    for k=1,#rgba_data do
        rgba_data[k] = rgba_data[k] / 255
    end
    return rgba_data
end

local bolt_options = {
    {
        bolt_rgba = {127, 206, 234, 255},
        bolt_debuff_file = "mods/Apotheosis/files/entities/misc/effect_teleport_cancel_long.xml",
        probability = 1.0
    },
    {
        bolt_rgba = {243, 225, 106, 255},
        bolt_debuff_file = "data/entities/misc/effect_weaken.xml",
        probability = 0.5
    },
    {
        bolt_rgba = {245, 62, 116, 255},
        bolt_debuff_file = "mods/Apotheosis/files/entities/misc/effect_mana_degradation_long.xml",
        probability = 0.5
    },
    {
        bolt_rgba = {193, 119, 255, 255},
        bolt_death_script = "mods/Apotheosis/files/scripts/projectiles/blob_poison_death.lua",
        probability = 0.5
    }
}

local bolt_data = RandomFromTable(bolt_options)
local bolt_colours = rgba_translate(bolt_data.bolt_rgba)

if bolt_data.bolt_debuff_file then
    EntityAddComponent2(
        entity_id,
        "HitEffectComponent",
        {
            effect_hit="LOAD_UNIQUE_CHILD_ENTITY",
            value_string=bolt_data.bolt_debuff_file
        }
    )
end

if bolt_data.bolt_death_script then
    EntityAddComponent2(
        entity_id,
        "LuaComponent",
        {
            execute_every_n_frame=-1,
            execute_on_removed=1,
            script_source_file=bolt_data.bolt_death_script
        }
    )
end

local particle_sprite_comps = EntityGetComponentIncludingDisabled(entity_id,"SpriteParticleEmitterComponent") or {}
for k=1,#particle_sprite_comps do
    ComponentSetValue2(particle_sprite_comps[k],"color",bolt_colours[1],bolt_colours[2],bolt_colours[3],bolt_colours[4])
end