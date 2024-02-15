
function collision_trigger()
	local entity_id = GetUpdatedEntityID()
	wake_up(entity_id)
end

function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id = GetUpdatedEntityID()
	wake_up(entity_id)
end

function wake_up(entity_id)

	local comps = {
		"PhysicsAIComponent",
		"LightComponent",
		"AnimalAIComponent",
		"SpriteParticleEmitterComponent"
	}

	for k=1,#comps do
		local v = comps[k]
		local comp = EntityGetFirstComponentIncludingDisabled(entity_id,v)
		EntitySetComponentIsEnabled(entity_id,comp,true)
	end
	
end