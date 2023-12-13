
local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 350

local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "player_unit" )

--[[
target = targets[1]
if target ~= nil then
    local cid = EntityLoad( "data/entities/animals/boss_water_lukki/projectiles/deathcross_barrage_setup.xml", pos_x, pos_y )
    EntityAddChild( entity_id, cid )
end
]]--

for k=1,#targets do
    local px,py = EntityGetTransform(targets[k])
    EntityLoad("data/entities/animals/boss_water_lukki/projectiles/circle_explosion.xml",px,py)
end
