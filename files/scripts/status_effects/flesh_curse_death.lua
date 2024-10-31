
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	-- kill self
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

	local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
	ComponentSetValue2(comp,"ragdoll_fx_forced","DISINTEGRATED")

	-- do some kind of an effect? throw some particles into the air?

	if EntityHasTag(entity_id, "boss") == true then return end

	local fleshling = false

	local list = {"Kirottu Mestari","$enemy_apotheosis_lukki_tentacle_hungry","$enemy_apotheosis_flesh_wizard_wands","$enemy_apotheosis_flesh_wizard_manaeater","$enemy_apotheosis_flesh_wizard_swapper","$enemy_apotheosis_flesh_wizard_twitchy","$enemy_apotheosis_flesh_wizard_neutral"}
	for s=1, #list 
	do local fleshy = list[s]
		if ( EntityGetName(entity_id) == fleshy ) then
			fleshling = true
			break
		end
	end


	if fleshling == false then
		local max_hp = ComponentGetValue2( comp, "max_hp")
		if (max_hp >= 5 or (Random( 1, 100) == 1)) and (EntityGetName(entity_id) ~= "Korruptoitunut Mestari") then
			if ( EntityGetName(entity_id) == "$enemy_apotheosis_wizard_corrupt_manaeater" ) then
				EntityLoad( "data/entities/animals/flesh_wizard_manaeater.xml", pos_x, pos_y )
			elseif ( EntityGetName(entity_id) == "$enemy_apotheosis_wizard_corrupt_neutral" ) then
				EntityLoad( "data/entities/animals/flesh_wizard_neutral.xml", pos_x, pos_y )
			elseif ( EntityGetName(entity_id) == "$enemy_apotheosis_wizard_corrupt_swapper" ) then
				EntityLoad( "data/entities/animals/flesh_wizard_swapper.xml", pos_x, pos_y )
			elseif ( EntityGetName(entity_id) == "$enemy_apotheosis_wizard_corrupt_twitchy" ) then
				EntityLoad( "data/entities/animals/flesh_wizard_twitchy.xml", pos_x, pos_y )
			elseif ( EntityGetName(entity_id) == "$enemy_apotheosis_wizard_corrupt_wands" ) then
				EntityLoad( "data/entities/animals/flesh_wizard_wands.xml", pos_x, pos_y )
			else
				EntityLoad( "data/entities/animals/secret/lukki_tentacle_hungry.xml", pos_x, pos_y )
			end
			EntityLoad( "mods/Apotheosis/files/entities/misc/flesh_curse_explosion.xml", pos_x, pos_y )
		else
			EntityLoad( "mods/Apotheosis/files/entities/misc/flesh_curse_explosion_small.xml", pos_x, pos_y )
		end
	end
	
end
