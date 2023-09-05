dofile_once("data/scripts/lib/utilities.lua")
local seasonalSetting = ModSettingGet( "Apotheosis.seasonal_events" )
	
local ambrosiaCats = ModSettingGet( "Apotheosis.congacat_cat_immortal" )
local cat_list = { "cat_mocreeps", "cat_mocreeps_black", "cat_mocreeps", "cat_mocreeps_black", "cat_mocreeps_white", "cat_mocreeps_spoopy", "cat_mocreeps_spoopy_skittle", "cat_mocreeps_spoopy_frisky", "cat_mocreeps_spoopy_tiger" }

local catPath = "animals"

if ambrosiaCats == true then
	catPath = "animals/cat_immortal"
else
	catPath = "animals"
end

if seasonalSetting == true then
	local year, month, day = GameGetDateAndTimeLocal()
	
	if ( month == 10 ) and ( day >= 15 ) then -- Halloween Event
		cat_list = { "cat_mocreeps", "cat_mocreeps_black", "cat_mocreeps_black", "cat_mocreeps_black", "cat_mocreeps_black", "cat_mocreeps_black", "cat_mocreeps_black", "cat_mocreeps_white", "cat_mocreeps_spoopy", "cat_mocreeps_spoopy", "cat_mocreeps_spoopy", "cat_mocreeps_spoopy", "cat_mocreeps_spoopy", "cat_mocreeps_spoopy", "cat_mocreeps_spoopy_skittle", "cat_mocreeps_spoopy_frisky", "cat_mocreeps_spoopy_tiger" }
	elseif ( month == 12 ) and ( day >= 15 ) then --Smissmass Event
		cat_list = { "cat_mocreeps", "cat_mocreeps_black", "cat_mocreeps_white", "cat_mocreeps_white", "cat_mocreeps_white", "cat_mocreeps_spoopy", "cat_mocreeps_spoopy_skittle", "cat_mocreeps_spoopy_skittle", "cat_mocreeps_spoopy_frisky", "cat_mocreeps_spoopy_frisky", "cat_mocreeps_spoopy_frisky", "cat_mocreeps_spoopy_tiger" }
	end
end


local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
SetRandomSeed( GameGetFrameNum(), pos_x + entity_id )
local goldenCatSeed = Random( 1, 50)
local rainbowCatSeed = Random( 1, 50)
local esotericCatSeed = Random( 1, 100)
local valid = true
pos_x, pos_y = EntityGetTransform( entity_id )

local rnd = Random( 1, #cat_list )
local target = cat_list[rnd]

if esotericCatSeed == 100 then
	EntityLoad( "data/entities/" .. catPath .. "/cat_mocreeps_esoteric.xml", pos_x, pos_y )
	valid = false
end

if ((rainbowCatSeed == 50) and (valid == true)) then
	EntityLoad( "data/entities/" .. catPath .. "/cat_mocreeps_sorako.xml", pos_x, pos_y )
	valid = false
elseif rainbowCatSeed >= 47 then
	EntityLoad( "data/entities/" .. catPath .. "/cat_mocreeps_wizard.xml", pos_x, pos_y )
	valid = false
end
--OMG GUYS I'M A RAINBOW KITTY! - Sorako

if ((goldenCatSeed == 1) and (valid == true)) then
	EntityLoad( "data/entities/" .. catPath .. "/cat_mocreeps_golden.xml", pos_x, pos_y )
	valid = false
elseif ((goldenCatSeed == 2) and (valid == true)) then
	EntityLoad( "data/entities/" .. catPath .. "/cat_mocreeps_spoopy_golden.xml", pos_x, pos_y )
	valid = false
elseif ((goldenCatSeed >= 40) and (valid == true)) then
	EntityLoad( "data/entities/" .. catPath .. "/cat_mocreeps_skateboard.xml", pos_x, pos_y )
	valid = false
end

if seasonalSetting == true then
	-- Halloween Event
	if ( month == 10 ) and ( day >= 1 ) then
		if esotericCatSeed >= 95 and (valid == true) then
			EntityLoad( "data/entities/" .. catPath .. "/cat_mocreeps_esoteric.xml", pos_x, pos_y )
			valid = false
		end
	end

	-- Smissmass Event
	if ( month == 10 ) and ( day >= 1 ) then
		if goldenCatSeed <= 4 and (valid == true) then
			EntityLoad( "data/entities/" .. catPath .. "/cat_mocreeps_golden.xml", pos_x, pos_y )
			valid = false
		elseif goldenCatSeed <= 6 and (valid == true) then
			EntityLoad( "data/entities/" .. catPath .. "/cat_mocreeps_spoopy_golden.xml", pos_x, pos_y )
			valid = false
		end

		if rainbowCatSeed <= 2 and (valid == true) then
			EntityLoad( "data/entities/" .. catPath .. "/cat_mocreeps_sorako.xml", pos_x, pos_y )
			valid = false
		end
	end
end

if valid == true then
	EntityLoad( "data/entities/" .. catPath .. "/" .. target .. ".xml", pos_x, pos_y )
end

EntityKill( entity_id )