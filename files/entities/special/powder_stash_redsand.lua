dofile_once("data/scripts/lib/utilities.lua")

function init( entity_id )
	local x,y = EntityGetTransform( entity_id )
	SetRandomSeed( x, y ) -- so that all the potions will be the same in every position with the same seed
	local potion_material = "apotheosis_redstone"

	local total_capacity = tonumber( GlobalsGetValue( "EXTRA_POTION_CAPACITY_LEVEL", "1000" ) ) or 1000
	if ( total_capacity > 1000 ) then
		local comp = EntityGetFirstComponentIncludingDisabled( entity_id, "MaterialSuckerComponent" )
			
		if ( comp ~= nil ) then
			ComponentSetValue( comp, "barrel_size", total_capacity )
		end
		
		EntityAddTag( entity_id, "extra_potion_capacity" )
	end

	AddMaterialInventoryMaterial( entity_id, potion_material, total_capacity )
end
