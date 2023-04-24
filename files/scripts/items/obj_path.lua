local entity_id = GetUpdatedEntityID()
local filepath = EntityGetFilename(entity_id)

EntityAddComponent2(
    entity_id,
    "VariableStorageComponent",
    {   
        name="obj_path",
        value_string=filepath,
        value_int=0
    }
)