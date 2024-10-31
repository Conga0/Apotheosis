
local entity_id = GetUpdatedEntityID()
local cdc_id = EntityGetFirstComponentIncludingDisabled( entity_id, "VelocityComponent" ) --or get the VelocityComp if it lacks this
local vx = ComponentGetValue2( cdc_id, "mVelocity" )
local x, y, rot, scale_x, scale_y = EntityGetTransform(entity_id)
if vx < 0 then 
  EntitySetTransform(entity_id, x, y, rot, -1, scale_y)
elseif vx > 0 then
  EntitySetTransform(entity_id, x, y, rot, 1, scale_y)
end