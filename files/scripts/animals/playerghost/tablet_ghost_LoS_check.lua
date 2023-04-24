
local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local player = EntityGetClosestWithTag(pos_x, pos_y, "player_unit") --Potential future multiplayer support
if player == nil then return end
local plyr_x, plyr_y = EntityGetTransform(player)
  
local did_hit = RaytraceSurfaces(pos_x, pos_y, plyr_x, plyr_y)
  
if not did_hit and IsInvisible(player) == false then
    EntitySetComponentsWithTagEnabled(entity_id,"enabled_by_liquid",true)
    EntitySetComponentsWithTagEnabled(entity_id,"invincible",false)
end