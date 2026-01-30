local entity_id = GetUpdatedEntityID()
local parent_id = EntityGetRootEntity(entity_id)

local vsc_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local is_set = ComponentGetValue2(vsc_comp,"value_bool")

local genome_comp = EntityGetFirstComponentIncludingDisabled(parent_id,"GenomeDataComponent")
local herd_id = HerdIdToString( ComponentGetValue2(genome_comp,"herd_id") )

local comp = EntityGetFirstComponentIncludingDisabled(parent_id, "CharacterPlatformingComponent")
if comp ~= nil and is_set == false and herd_id ~= "spider" then
    local values = {
        "jump_velocity_y",
        "jump_velocity_x",
        --"fly_speed_max_up",
        "fly_speed_max_down",
        "run_velocity",
        "fly_velocity_x",
        "velocity_min_x",
        "velocity_max_x",
        "velocity_min_y",
        "velocity_max_y"
    }

    for k=1,#values do
        local v = values[k]
        local val = ComponentGetValue2(comp,v)
        ComponentSetValue2(comp,v,val * 0.1)
    end
    ComponentSetValue2(vsc_comp,"value_bool",true)
end