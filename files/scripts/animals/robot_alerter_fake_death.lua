dofile_once( "data/scripts/lib/utilities.lua" )

local entity = GetUpdatedEntityID()

local comp = EntityGetFirstComponent( entity, "DamageModelComponent" )
if( comp ~= nil ) then
    ComponentSetValue( comp, "max_hp", 0 )
    ComponentSetValue( comp, "hp", 0 )
	ComponentSetValue2(comp, "air_needed", true)
	ComponentSetValue2(comp, "air_in_lungs", 0)
end