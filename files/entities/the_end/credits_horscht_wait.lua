dofile_once("data/scripts/lib/utilities.lua")

local player_id = EntityGetWithTag("player_unit")[1]
local x,y = EntityGetTransform(player_id)
local credits = EntityLoad("mods/Apotheosis/files/entities/the_end/credits_horscht.xml",x,y)
EntityAddChild(player_id,credits)

EntityKill(GetUpdatedEntityID())