

function collision_trigger(projectile_id)
	local entity_id    = GetUpdatedEntityID()
	local proj_x, proj_y = EntityGetTransform( projectile_id )

	local projcomp = EntityGetFirstComponentIncludingDisabled( projectile_id, "ProjectileComponent" )
	if ComponentGetValue2(projcomp, "mShooterHerdId") ~= StringToHerdId("mage_library") then
		EntityLoad("data/entities/particles/neutralized_tiny.xml", proj_x, proj_y)
		EntityKill(projectile_id)
	end
end