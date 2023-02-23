dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local players = EntityGetWithTag( "player_unit" )
local player = players[1]
if player == nil then return end
local plyr_x, plyr_y = EntityGetTransform(player)
  
local did_hit = RaytraceSurfaces(pos_x, pos_y, plyr_x, plyr_y)
  
if not did_hit then
    EntitySetComponentsWithTagEnabled(entity_id,"enabled_by_liquid",true)
    EntitySetComponentsWithTagEnabled(entity_id,"disabled_by_liquid",true)
else
    EntitySetComponentsWithTagEnabled(entity_id,"enabled_by_liquid",false)
end