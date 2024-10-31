 dofile_once("data/scripts/lib/utilities.lua")

potions = 
{
	{
		material="apotheosis_redstone",
		cost=10,
	},
	{
		material="apotheosis_blood_infectious",
		cost=1000,
	},
	{
		material="apotheosis_blood_infectious",
		cost=1000,
	},
	{
		material="apotheosis_blood_infectious",
		cost=1000,
	}
}

function init( entity_id )
	local x,y = EntityGetTransform( entity_id )
	SetRandomSeed( x + GameGetFrameNum(), y )
	-- so that all the potions will be the same in every position with the same seed
	local potion = random_from_array( potions )

	local amount = 500

	if (Random(1,5) == 5) then
		amount = Random(500,1000)
	end

	AddMaterialInventoryMaterial( entity_id, potion.material, amount )
end
