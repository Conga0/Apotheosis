
--We call potion.lua here so anyone appending to the potion.lua file also adds to this potion's liquid pool
dofile("data/scripts/items/potion.lua")

function init( entity_id )
	local x,y = EntityGetTransform( entity_id )
	SetRandomSeed( x, y ) -- so that all the potions will be the same in every position with the same seed
	local potion_material = "water"

	if( Random( 0, 100 ) <= 75 ) then
		-- 0.05% chance of magic_liquid_
		if( Random( 0, 100000 ) <= 50 ) then
			potion_material = "magic_liquid_hp_regeneration"
		elseif( Random( 200, 100000 ) <= 250 ) then
			potion_material = "purifying_powder"
		else
			potion_material = random_from_array( materials_magic )
			potion_material = potion_material.material
		end
	else
		potion_material = random_from_array( materials_standard )
		potion_material = potion_material.material
	end

	-- load the material from VariableStorageComponent
	
	if Random(1,100) == 1 then
		local opts = {
			"apotheosis_magic_liquid_nukes",
			"apotheosis_magic_liquid_escapium",
			"apotheosis_milk",
			--"apotheosis_magic_liquid_mimic",
			"mimic_liquid",
		}

		potion_material = opts[Random(1,#opts)]
	end

	if Random(1,1000) == 1 then
		potion_material = "apotheosis_unholy_concoction"
	end
	
	local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()

	
	if ((( month == 5 ) and ( day == 1 )) or (( month == 4 ) and ( day == 30 ))) and (Random( 0, 100 ) <= 20) then
		potion_material = "sima"
	end

	if( jussi and Random( 0, 100 ) <= 9 ) then
		potion_material = "juhannussima"
	end

	if ( month == 2 and day == 14 and Random( 0, 100 ) <= 8) then
		potion_material = "magic_liquid_charm"
	end

	local total_capacity = tonumber( GlobalsGetValue( "EXTRA_POTION_CAPACITY_LEVEL", "2000" ) ) or 2000
	if ( total_capacity > 2000 ) then
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