--dofile_once("data/scripts/lib/utilities.lua")

function material_area_checker_success( pos_x, pos_y )
	local entity_id = GetUpdatedEntityID()
	local parent_id = EntityGetRootEntity(entity_id)
	local matcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"MaterialAreaCheckerComponent")
	local liquid = ComponentGetValue2(matcomp, "material")

	local varcomp = EntityGetFirstComponentIncludingDisabled(parent_id,"VariableStorageComponent")
	ComponentSetValue2(varcomp, "value_float", liquid)
end
