dofile_once("data/scripts/lib/utilities.lua")

function damage_received( damage, desc, entity_who_caused, is_fatal )
	local entity_id    = GetUpdatedEntityID()

	local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
	local hp = ComponentGetValue2(comp,"hp")
	local max_hp = ComponentGetValue2(comp,"max_hp")

	if hp > max_hp * 0.99 then
		
	end
end
