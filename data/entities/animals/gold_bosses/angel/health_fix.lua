dofile_once( "data/scripts/lib/utilities.lua" )


local entity_id = GetUpdatedEntityID()

local comp = EntityGetFirstComponent( entity_id, "DamageModelComponent" )

ComponentSetValue( comp, "max_hp", "16000" )
ComponentSetValue( comp, "hp", "16000" )
