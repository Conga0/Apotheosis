dofile_once("data/scripts/lib/utilities.lua")
local ambrosiaFairies = ModSettingGet( "Apotheosis.fairy_immortality" )
local ambrosiaCats = ModSettingGet( "Apotheosis.congacat_cat_immortal" )

local fairy_list = { "red", "green", "blue", "white", "yellow" }



local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
SetRandomSeed( GameGetFrameNum(), pos_x + entity_id )
local rainbowCatSeed = Random( 1, 30)
local valid = true
pos_x, pos_y = EntityGetTransform( entity_id )

local rnd = Random( 1, #fairy_list )
local target = fairy_list[rnd]

if (rainbowCatSeed == 30) then
	if ambrosiaCats then
		EntityLoad( "data/entities/animals/cat_immortal/cat_mocreeps_sorako.xml", pos_x, pos_y )
		valid = false
	else
		EntityLoad( "data/entities/animals/cat_mocreeps_sorako.xml", pos_x, pos_y )
		valid = false
	end
end
--OMG GUYS I'M A RAINBOW KITTY! - Sorako

if valid == true then
	if ambrosiaFairies then
		EntityLoad( "data/entities/animals/rgb_fairies/immortal/" .. target .. "/fairy_cheap.xml", pos_x, pos_y )
	else
		EntityLoad( "data/entities/animals/rgb_fairies/" .. target .. "/fairy_cheap.xml", pos_x, pos_y )
	end
end