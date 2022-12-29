dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 32

local targets = EntityGetInRadiusWithTag( x, y, r, "player_unit" )
local summonCount = 5

if #targets >= 1 then
	EntityLoad( "data/entities/animals/robot_alerter_alerted.xml", x,y )
	EntityLoad( "data/entities/animals/robot_alerter_alerted_fake.xml", x,y )
	SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), x + y + entity_id )
	angleCalculator = (Random(0,359))

	repeat

		angleCalculator = (angleCalculator + angleCalculator + 30)
		local angle = math.rad(angleCalculator)
		local length = 300

		local vel_x = math.cos( angle ) * length
		local vel_y = 0 - math.sin( angle ) * length

		shoot_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/alert_enemy_summoner.xml", x, y, vel_x, vel_y )

		summonCount = (summonCount - 1)

	until(summonCount <= 0)

	EntityKill( entity_id )
end