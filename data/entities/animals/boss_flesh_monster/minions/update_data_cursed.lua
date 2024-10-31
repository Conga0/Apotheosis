local entity_id = GetUpdatedEntityID()
local minion = EntityGetParent(entity_id)

local damagecomp = EntityGetFirstComponentIncludingDisabled( minion, "DamageModelComponent")
ComponentSetValue2(damagecomp,"ragdoll_material","spark_purple")
local genomecomp = EntityGetFirstComponentIncludingDisabled( minion, "GenomeDataComponent")
ComponentSetValue2(genomecomp,"herd_id",StringToHerdId("mage_corrupted"))
EntitySetName( minion_id, "Kirottu Mestari" )
EntityAddTag( minion , "touchmagic_immunity" )

EntityAddComponent2(
    minion,
    "LifetimeComponent",
    {
        lifetime=2400
    }
)

EntityAddComponent2(
    minion,
    "LuaComponent",
    {
        script_source_file = "data/scripts/animals/illusion_disappear.lua",
        execute_every_n_frame=-1,
        execute_on_removed=true
    }
)

EntityAddComponent2(
    minion,
    "LuaComponent",
    {
        script_source_file="mods/Apotheosis/files/scripts/animals/minion_distance_delete_far.lua",
        execute_every_n_frame=90,
        execute_on_removed=true
    }
)

EntityAddComponent2(
    minion,
    "VariableStorageComponent",
    {
        _tags="no_gold_drop"
    }
)