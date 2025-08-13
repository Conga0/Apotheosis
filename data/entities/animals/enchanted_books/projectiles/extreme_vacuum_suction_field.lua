dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local distance_full = 100

SetRandomSeed( GameGetFrameNum(), x + y + entity_id )

local targets = EntityGetInRadiusWithTag( x, y, distance_full, "mortal" )
local direction_random = math.rad( Random( -30, 30 ) )

if ( #targets > 0 ) then

	for k=1,#targets do
		local target_id = targets[k]

		local is_valid_target = true
		local genomecomp = EntityGetFirstComponentIncludingDisabled( target_id, "GenomeDataComponent" )
		if genomecomp then
			if ComponentGetValue2(genomecomp, "herd_id") ~= StringToHerdId("mage_library") then
				local px, py = EntityGetTransform( target_id )
				local distance = get_distance( px, py, x, y )
				local direction = get_direction( x, y, px, py )

				if ( distance < distance_full ) then
					local velocitycomponents = EntityGetComponent( target_id, "CharacterDataComponent" ) or EntityGetComponent( target_id, "VelocityComponent" ) or nil
					local dmg_to_inflict = (100 - distance) * 0.001
					EntityInflictDamage( target_id, dmg_to_inflict, "DAMAGE_PROJECTILE", "$damage_apotheosis_extreme_vacuum", "NONE", 0, 0, shooter_id )
					
					local gravity_percent = math.max(( distance_full - distance ) / distance_full, 0.01)
					local gravity_coeff = 96 * 5
					if EntityHasTag(target_id, "resist_repulsion") then gravity_coeff = gravity_coeff * 0.25 end
					
					if ( velocitycomponents ~= nil ) then
						edit_component( target_id, "CharacterDataComponent", function(comp,vars)
							local vel_x,vel_y = ComponentGetValueVector2( comp, "mVelocity")
							
							local offset_x = math.cos( direction + direction_random ) * ( gravity_coeff * gravity_percent )
							local offset_y = 0 - math.sin( direction + direction_random ) * ( gravity_coeff * gravity_percent )

							vel_x = vel_x + offset_x
							vel_y = vel_y + offset_y

							ComponentSetValueVector2( comp, "mVelocity", vel_x, vel_y)
						end)
					end
				end
			end
		end
	end
end