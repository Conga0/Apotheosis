dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local enemy_list = { "gazer_greater", "devourer_magic", "devourer_ghost", "crypt/hideous_mass", "gazer_cold_apotheosis", "crypt/tentacler_big", }


SetRandomSeed( pos_x, pos_y )
local rnd = Random( 1, #enemy_list )
local target = enemy_list[rnd]
local count = 0
if Random(1,20000) == 1 then target = "boss_fire_lukki/boss_fire_lukki" end

if target == "gazer_cold_apotheosis" then count = 4 end

repeat 
EntityLoad("data/entities/animals/" .. target .. ".xml", pos_x, pos_y)
count = count - 1
until(count <= 0)

EntityKill(entity_id)
