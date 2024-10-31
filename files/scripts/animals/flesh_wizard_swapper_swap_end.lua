--Animations >:(
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )

local sprite_comps = EntityGetComponent(entity_id, "SpriteComponent") or {}
for i, comp in ipairs(sprite_comps) do
	ComponentAddTag(comp, "character" )
end

local c = EntityGetAllChildren( entity_id )
for a,b in ipairs( c ) do
	local eyename = EntityGetName( b )

	if ( eyename == "eye" ) then
		local pupil_comps = EntityGetComponent(b, "SpriteComponent") or {}
		for i, comp in ipairs(pupil_comps) do
			ComponentAddTag(comp, "character" )
			ComponentSetValue2(comp, "rect_animation", "stand")
		end
	end
 end