dofile( "data/scripts/lib/utilities.lua" )

local entity_id = GetUpdatedEntityID()

EntityAddComponent(entity_id, "LuaComponent", {
	script_source_file="mods/Apotheosis/files/scripts/animals/ceiling_implant.lua",
	execute_every_n_frame=10,
	execute_on_added=0,
})
