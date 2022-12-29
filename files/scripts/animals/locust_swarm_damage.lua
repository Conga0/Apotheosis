dofile_once("data/scripts/lib/utilities.lua")

function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	
	local health = 0
	local max_health = 0
	local swarm_density = 0
	
	edit_component( entity_id, "DamageModelComponent", function(comp,vars)
		health = tonumber(ComponentGetValue( comp, "hp"))
		max_health = tonumber(ComponentGetValue( comp, "max_hp"))
	end)

	local health_percent = health / max_health

	if health_percent >= 0.75 then
		swarm_density = 30
	elseif health_percent >= 0.5 then
		swarm_density = 15
	elseif health_percent >= 0.25 then
		swarm_density = 7
	elseif health_percent >= 0.1 then
		swarm_density = 3
	else
		swarm_density = 1
	end


	local particleComp = EntityGetFirstComponent( entity_id, "ParticleEmitterComponent" )

	ComponentSetValue2( particleComp, "count_min", swarm_density )
	ComponentSetValue2( particleComp, "count_max", swarm_density )


	local particleComp2 = EntityGetComponentIncludingDisabled(entity_id, "ParticleEmitterComponent")[2]

	ComponentSetValue2( particleComp2, "count_min", swarm_density )
	ComponentSetValue2( particleComp2, "count_max", swarm_density )

end