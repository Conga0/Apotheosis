

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormComponent")
local vel_x, vel_y = ComponentGetValue2(comp,"mTargetVec")

GameShootProjectile(entity_id, pos_x, pos_y, pos_x + vel_x, pos_y + vel_y,EntityLoad("data/entities/animals/boss_adult_centipede/projectiles/acidshot.xml", pos_x, pos_y))
