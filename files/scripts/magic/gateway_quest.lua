
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

if tonumber(GlobalsGetValue("apotheosis_plane_fail",0)) == 1 then
    EntitySetComponentsWithTagEnabled(entity_id,"invincible",false)
    EntitySetComponentsWithTagEnabled(entity_id,"counter",true)
else
    
end