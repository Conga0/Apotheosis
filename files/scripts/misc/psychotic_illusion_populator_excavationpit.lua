dofile_once("data/scripts/lib/utilities.lua")
	
--wizard_returner is not on the list, keeps causing burning for some reason
local illusion_list = { "blindgazer", "goo_slug", "poring", "roboguard", "shotgunner", "frog_big", "firebug", "wizard_manaeater", "wizard_poly", "zombie", "bat" }


local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
SetRandomSeed( GameGetFrameNum(), pos_x + entity_id )
local pos_x = pos_x + Random(200,-200)
local pos_y = pos_y + Random(200,-200)

local rnd = Random( 1, #illusion_list )
local target = illusion_list[rnd]

EntityLoad( "data/entities/animals/psychotic/" .. target .. ".xml", pos_x, pos_y )