dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()

local comp = EntityGetFirstComponent( entity_id, "AnimalAIComponent" )

if ( comp ~= nil ) then
	local targets = EntityGetWithTag( "sentry_target" )
	
	if ( #targets > 0 ) then
		ComponentSetValue2( comp, "attack_ranged_entity_file", "data/entities/projectiles/forsaken_eye_orb.xml" )
		ComponentSetValue2( comp, "attack_ranged_frames_between", 12 )
		ComponentSetValue2( comp, "attack_ranged_min_distance", 0 )
		ComponentSetValue2( comp, "attack_ranged_max_distance", 90 )
		ComponentSetValue2( comp, "attack_ranged_predict", false )
	else
		ComponentSetValue2( comp, "attack_ranged_entity_file", "data/entities/projectiles/forsaken_eye_targetter.xml" )
		ComponentSetValue2( comp, "attack_ranged_frames_between", 90 )
		ComponentSetValue2( comp, "attack_ranged_min_distance", 0 )
		ComponentSetValue2( comp, "attack_ranged_max_distance", 200 )
		ComponentSetValue2( comp, "attack_ranged_predict", false )
	end
end