
--[[
local targets = EntityGetWithTag( "player_unit" )

local target = targets[1]
]]--

-- why wasn't it just GetRootEntity in the first place? it's already a status effect on an entity... -Spoop

local entity_id = GetUpdatedEntityID()
local target = EntityGetRootEntity(entity_id)

EntitySetDamageFromMaterial( target, "lava", 0)