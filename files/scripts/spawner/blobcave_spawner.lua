dofile_once("data/scripts/lib/utilities.lua")



local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
SetRandomSeed( GameGetFrameNum(), pos_x + entity_id )

local blobCount = Random( 2, 4)

repeat
	SetRandomSeed( GameGetFrameNum(), pos_x + blobCount + blobCount )
	local blobSeed = Random( 1, 100)
	if (blobSeed >= 99) then
		EntityLoad( "data/entities/animals/blob_huge.xml", pos_x, pos_y )
	elseif (blobSeed >= 85) then
		EntityLoad( "data/entities/animals/blob_big.xml", pos_x, pos_y )
	elseif (blobSeed >= 70) then
		EntityLoad( "data/entities/animals/blob.xml", pos_x, pos_y )
	elseif (blobSeed >= 50) then
		EntityLoad( "data/entities/animals/ceiling_fungus.xml", pos_x, pos_y )
	elseif (blobSeed >= 40) then
		EntityLoad( "data/entities/animals/bubbles/acid/bubble_liquid.xml", pos_x, pos_y )
	elseif (blobSeed >= 30) then
		EntityLoad( "data/entities/animals/fungus.xml", pos_x, pos_y )
	else
		EntityLoad( "data/entities/animals/miniblob.xml", pos_x, pos_y )
	end
	blobCount = (blobCount - 1)
until(blobCount <= 0)

