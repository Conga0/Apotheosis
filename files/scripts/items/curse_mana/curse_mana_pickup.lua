dofile( "data/scripts/game_helpers.lua" )
dofile_once("data/scripts/lib/utilities.lua")

function item_pickup( entity_item, entity_who_picked, item_name )
	-- fetch perk info ---------------------------------------------------

	local pos_x, pos_y = EntityGetTransform( entity_item )
		
	local cid = EntityLoad( "mods/Apotheosis/files/entities/misc/curse_mana/curse_mana.xml", pos_x, pos_y )
	EntityAddChild( entity_who_picked, cid )
	
	--GameAddFlagRun( "greed_curse" )
	--AddFlagPersistent( "greed_curse_picked" )

	EntityAddComponent( entity_who_picked, "LuaComponent", 
	{ 
		execute_every_n_frame=-1,
		script_damage_received="mods/Apotheosis/files/scripts/items/curse_mana/curse_mana_disrupt.lua",
		remove_after_executed=0,
	})

	-- cosmetic fx -------------------------------------------------------

	EntityLoad( "data/entities/particles/image_emitters/perk_effect.xml", pos_x, pos_y )
	GamePrintImportant( "$perk_apotheosis_curse_mana_reveal", "$perk_apotheosis_curse_mana_description_reveal" )
	
	EntityKill( entity_item )
end