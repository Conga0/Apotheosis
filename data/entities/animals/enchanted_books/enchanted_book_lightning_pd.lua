dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local distance_full = 75

SetRandomSeed( GameGetFrameNum(), x + y + entity_id )

local projectiles = EntityGetInRadiusWithTag( x, y, distance_full, "projectile" ) or {}
local direction_random = math.rad( Random( -30, 30 ) )

if ( #projectiles > 0 ) then

	for i,projectile_id in ipairs(projectiles) do
		local projcomp = EntityGetFirstComponentIncludingDisabled( projectile_id, "ProjectileComponent" )
		if ComponentGetValue2(projcomp, "mShooterHerdId") ~= StringToHerdId("mage_library") then
			local px, py = EntityGetTransform( projectile_id )
			local distance = get_distance( px, py, x, y )
			local direction = get_direction( px, py, x, y )

			local pd_laser = EntityLoad("data/entities/animals/enchanted_books/projectiles/point_defense_shot.xml",x,y)
			local comp = EntityGetFirstComponentIncludingDisabled(pd_laser,"LightningComponent")
			ComponentSetValue2(comp,"mExPosition",px,py)

			--draw_line(x,y,px,py,"spark_white")
			EntityKill(projectile_id)
			GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/bullet_lightning/create", x, y )
			break
		end
	end
end