dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local players = EntityGetWithTag( "player_unit" )
local player = players[1]
if player == nil then return end
local plyr_x, plyr_y = EntityGetTransform(player)
  
local did_hit = RaytraceSurfaces(pos_x, pos_y, plyr_x, plyr_y)
  
if not did_hit then
    local cid = EntityLoad( "mods/apotheosis/files/entities/misc/lukki_fire_tiny_firebolt_barrage_setup.xml", pos_x, pos_y )
    EntityAddChild( entity_id, cid )
end