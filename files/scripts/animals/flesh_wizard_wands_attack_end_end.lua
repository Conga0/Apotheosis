local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 9

local sprite_comps = EntityGetComponent(entity_id, "SpriteComponent") or {}
for i, comp in ipairs(sprite_comps) do
	ComponentAddTag(comp, "character" )
end

local c = EntityGetAllChildren( entity_id )
for a,b in ipairs( c ) do
	local eyename = EntityGetName( b )

	if ( eyename == "eye" ) then
		local pupil_comp = EntityGetFirstComponentIncludingDisabled(b, "SpriteComponent")
		ComponentSetValue2(pupil_comp, "alpha", 1)
	end
end