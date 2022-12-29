dofile( "data/scripts/lib/utilities.lua" )

local entity_id = GetUpdatedEntityID()

local x, y = EntityGetTransform( entity_id )
  
local did_hit, hit_x, hit_y = RaytraceSurfaces(x, y - 6, x, y - 7)
  
if not did_hit then
	
	local damage_model_component = EntityGetFirstComponent(entity_id, "DamageModelComponent")
		
	ComponentSetValue2(damage_model_component, "hp", 0)
	ComponentSetValue2(damage_model_component, "air_needed", true)
	ComponentSetValue2(damage_model_component, "air_in_lungs", 0)

end