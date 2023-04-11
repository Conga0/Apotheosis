 dofile_once("data/scripts/lib/utilities.lua")

-- NOTE( Conga Lyne ): 
-- materials_rare is all you really need to append to if you want to expand this list as someone looking for cross-mod compatibility, go nuts
-- Intention for this list is for all materials you *want* to be very rare, but can't make them rare via normal means since the "weight" system is broken
-- It wouldn't be very compatipiled to fix that, probably, so this'll do for now

materials_rare = 
{
	{
		material="apotheosis_magic_liquid_nukes",
		cost=800,
	},
	{
		material="apotheosis_magic_liquid_escapium",
		cost=800,
	},
	{
		material="apotheosis_milk",
		cost=800, --Hey, I'll be real with you, cost changes literally nothing, even in the normal potion.lua file, I'm just keeping it here incase a mod far off in the future decides to change that
	}
}

function init( entity_id )
	local x,y = EntityGetTransform( entity_id )
	SetRandomSeed( x, y ) -- so that all the potions will be the same in every position with the same seed
	local potion_material = "apotheosis_magic_liquid_nukes"


	if( Random( 0, 100000 ) <= 50 ) then
		potion_material = "magic_liquid_hp_regeneration"
	else
		potion_material = random_from_array( materials_rare )
		potion_material = potion_material.material
	end

	local total_capacity = tonumber( GlobalsGetValue( "EXTRA_POTION_CAPACITY_LEVEL", "1000" ) ) or 1000
	if ( total_capacity > 1000 ) then
		local comp = EntityGetFirstComponentIncludingDisabled( entity_id, "MaterialSuckerComponent" )
			
		if ( comp ~= nil ) then
			ComponentSetValue( comp, "barrel_size", total_capacity )
		end
		
		EntityAddTag( entity_id, "extra_potion_capacity" )
	end
	
	local components = EntityGetComponent( entity_id, "VariableStorageComponent" )

	if( components ~= nil ) then
		for key,comp_id in pairs(components) do 
			local var_name = ComponentGetValue( comp_id, "name" )
			if( var_name == "potion_material") then
				potion_material = ComponentGetValue( comp_id, "value_string" )
			end
		end
	end

	AddMaterialInventoryMaterial( entity_id, potion_material, total_capacity )
end