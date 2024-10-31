dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local parent_id = EntityGetRootEntity( entity_id )
local pos_x, pos_y = EntityGetTransform( parent_id )

local pid1 = shoot_projectile( parent_id, "data/entities/animals/boss_flesh_monster/projectiles/orb_blood_circle.xml", pos_x, pos_y - 10, 0,  math.random(-50,50) )
local projcomp = EntityGetFirstComponentIncludingDisabled( pid1, "ProjectileComponent" )
ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("mage_corrupted"))
local pid2 = shoot_projectile( parent_id, "data/entities/animals/boss_flesh_monster/projectiles/orb_blood_hex.xml", pos_x - 5, pos_y, -30, math.random(-50,50) )
projcomp = EntityGetFirstComponentIncludingDisabled( pid2, "ProjectileComponent" )
ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("mage_corrupted"))
local pid3 = shoot_projectile( parent_id, "data/entities/animals/boss_flesh_monster/projectiles/orb_blood_hex.xml", pos_x - 5, pos_y, -30, math.random(-50,50) )
projcomp = EntityGetFirstComponentIncludingDisabled( pid3, "ProjectileComponent" )
ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("mage_corrupted"))


