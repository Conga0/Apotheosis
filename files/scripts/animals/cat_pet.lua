dofile_once("data/scripts/lib/utilities.lua")

EntitySetComponentsWithTagEnabled( GetUpdatedEntityID(), "enabled_if_charmed", true )

function interacting(entity_who_interacted, entity_interacted, interactable_name)
	local x, y = EntityGetTransform( entity_interacted )
	local animate = true
	
	edit_component( entity_interacted, "VelocityComponent", function(comp,vars)
		ComponentSetValueVector2( comp, "mVelocity", 0, 0 )
	end)

	edit_component( entity_interacted, "CharacterDataComponent", function(comp,vars)
		ComponentSetValueVector2( comp, "mVelocity", 0, 0 )
	end)
	
	edit_component( entity_who_interacted, "VelocityComponent", function(comp,vars)
		ComponentSetValueVector2( comp, "mVelocity", 0, 0 )
	end)

	edit_component( entity_who_interacted, "CharacterDataComponent", function(comp,vars)
		ComponentSetValueVector2( comp, "mVelocity", 0, 0 )
	end)
	
	SetRandomSeed( x + entity_interacted, y + GameGetFrameNum() )
	local rnd = Random( 1, 20 )
	
	if ( rnd <= 6 ) then
		EntitySetComponentsWithTagEnabled( entity_interacted, "enabled_if_charmed", false )
		
		GamePrint( "$ui_apotheosis_cat_pet_01" )
		GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/kittycat/voc_attack_purr_01", x, y )
	elseif ( rnd <= 12 ) then
		EntitySetComponentsWithTagEnabled( entity_interacted, "enabled_if_charmed", false )
		
		GamePrint( "$ui_apotheosis_cat_pet_02" )
		GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/kittycat/sora_meow_01", x, y )
	elseif ( rnd <= 18 ) then
		EntitySetComponentsWithTagEnabled( entity_interacted, "enabled_if_charmed", false )
		
		GamePrint( "$ui_apotheosis_cat_pet_03" )
		animate = false
	else
		EntitySetComponentsWithTagEnabled( entity_interacted, "enabled_if_charmed", false )
		
		GamePrint( "$ui_apotheosis_cat_pet_04" )
	end

	if animate then
		GamePlayAnimation( entity_interacted, "pet", 42, "stand", 0 )
	end
	GameEntityPlaySound( entity_who_interacted, "pet" )
end
