dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()

edit_component( entity_id, "LuaComponent", function(comp,vars)
	EntitySetComponentIsEnabled( entity_id, comp, false )
end)

local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"LuaComponent")
