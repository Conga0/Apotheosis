dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()

local comp = EntityGetFirstComponentIncludingDisabled( entity_id, "SpriteComponent" )

if ( comp ~= nil ) then
	local y = ComponentGetValue2(comp, "offset_y")
	ComponentSetValue2(comp, "offset_y", y + 0.2)
end

--GamePrint("Spam")