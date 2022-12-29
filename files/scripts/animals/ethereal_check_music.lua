dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local radius = 400

local melody = EntityGetInRadiusWithTag( x, y, radius, "musical_stone" )
--This commented out method is the ideal method, but unless I find a way to add tags to the entity directly, this will have to do
--local melody = EntityGetInRadius( x, y, radius )
local found = false

if ( #melody > 0 ) then
	for i,v in ipairs( melody ) do
		local t = EntityGetFirstComponent( v, "LightComponent", "musical_stone" )
		
		if ( t ~= nil ) then
			found = true
			break
		end
	end
end

local t = EntityGetFirstComponent( entity_id, "DamageModelComponent" )

if found then
	if ( t == nil ) then
		EntitySetComponentsWithTagEnabled( entity_id, "magic_music", true )
		EntityLoad( "data/entities/particles/poof_blue.xml", x, y )
	end
else
	if ( t ~= nil ) then
		EntitySetComponentsWithTagEnabled( entity_id, "magic_music", false )
		EntityLoad( "data/entities/particles/poof_blue.xml", x, y )
	end
end