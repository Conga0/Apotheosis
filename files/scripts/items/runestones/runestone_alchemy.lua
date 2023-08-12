
local entity_id = GetUpdatedEntityID()
local parent = EntityGetParent(entity_id)
if parent == 0 then
    local x, y = EntityGetTransform( entity_id )
    local vsc_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")

    local child = EntityLoad( "mods/apotheosis/files/entities/misc/runestone_alchemy.xml", x, y )
    local material_id = CellFactory_GetType(ComponentGetValue2(vsc_comp,"value_string"))

    local material_comp = EntityGetFirstComponentIncludingDisabled(child,"MagicConvertMaterialComponent")
    ComponentSetValue2(material_comp,"to_material",material_id)
end
