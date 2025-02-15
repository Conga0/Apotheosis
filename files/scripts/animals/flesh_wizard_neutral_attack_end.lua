dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 300

local targets = EntityGetInRadiusWithTag( x, y, r, "mortal" ) or {}

local animalai = EntityGetFirstComponentIncludingDisabled(entity_id, "AnimalAIComponent")
local aggression = ComponentGetValue2(animalai, "mAggression") or 40

if #targets > 1 then
	for k=1, #targets
	do local v = targets[k]
		local genome = EntityGetFirstComponentIncludingDisabled(v, "GenomeDataComponent")
		if v ~= entity_id and genome ~= nil and (EntityGetHerdRelation(entity_id, v) < aggression) then
		local t_x, t_y = EntityGetTransform(v)
		local did_hit = RaytraceSurfaces(x, y, t_x, t_y)
		if not did_hit then
			SetRandomSeed( GameGetFrameNum(), x + y + entity_id )

			local angle_inc = 0
			local angle_inc_set = false

			local length = 1150

			if ( t_x ~= nil ) and ( t_y ~= nil ) then
				angle_inc = 0 - math.atan2( ( t_y - y ), ( t_x - x ) )
				angle_inc_set = true
			end

			local angle = 0
			if angle_inc_set then
				angle = angle_inc
			else
				angle = math.rad( Random( 1, 360 ) )
			end
	
			local shots = 5

			for s=1,shots do
				local vel_x = math.cos( angle ) * length
				local vel_y = 0- math.sin( angle ) * length

				length = length + 5

				local pid = shoot_projectile(entity_id,"mods/Apotheosis/files/entities/projectiles/laserbeam_flesh_neutral.xml",x,y,vel_x,vel_y)
				local projcomp = EntityGetFirstComponentIncludingDisabled( pid, "ProjectileComponent" )
				ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("mage_corrupted"))
				local velcomp = EntityGetFirstComponentIncludingDisabled( pid, "VelocityComponent" )
				ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y)
				ComponentSetValue2(velcomp, "mPrevVelocity", vel_x, vel_y)
				GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/megalaser/launch", pos_x, pos_y )
			end

			local current_frame = GameGetFrameNum()
			local cooldown = 600
			local variablecomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
			for k=1,#variablecomp
			do local v = variablecomp[k]
				if ComponentGetValue2(v,"name") == "cooldown_frame" then
					ComponentSetValue2( v, "value_int", current_frame + cooldown )
					break
				end
			end
			break
		end
		end
	end
end


local c = EntityGetAllChildren( entity_id )
for a,b in ipairs( c ) do
	local warningname = EntityGetName( b )
	if ( warningname == "laserbeam_neutral_warning" ) then
		EntityKill( b )
	end
end
EntitySetComponentsWithTagEnabled(entity_id,"invincible",false)