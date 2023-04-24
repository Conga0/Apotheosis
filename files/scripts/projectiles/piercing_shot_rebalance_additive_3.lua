
local entity_id = GetUpdatedEntityID()
local piercingfound = false

local comps = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")
if comps then
    for k=1,#comps
    do v = comps[k]
        if ComponentGetValue2(v,"name") == "apotheosis_piercing_count" then
            piercingfound = true
            local piercingcount = ComponentGetValue2(v,"value_int")
            ComponentSetValue2(v,"value_int",piercingcount + 3)
        end
    end

    if piercingfound == false then
        EntityAddComponent2(
            entity_id,
            "VariableStorageComponent",
            {
                name = "apotheosis_piercing_count",
                value_int = 3,
            }
        )
    end
end
