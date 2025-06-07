dofile( "data/scripts/game_helpers.lua" )
dofile_once("data/scripts/lib/utilities.lua")
dofile( "data/scripts/perks/perk_list.lua" )

function item_pickup( entity_item, entity_who_picked, item_name )

	-- fetch perk info ---------------------------------------------------

    --Optional perk the player can take if they have infinite gold
    --Goal is to help prevent lag from enemies with high HP by removing physics gold drops
    --while still giving the player the option to keep gold drops enabled to go for high-value gold nuggets if desired

	local pos_x, pos_y = EntityGetTransform( entity_item )
	
	local essence_name = "ESSENCE_NAME_NOT_DEFINED"
	local essence_desc = "ESSENCE_DESCRIPTION_NOT_DEFINED"
	
	edit_component( entity_item, "ItemComponent", function(comp,vars)
		essence_name = ComponentGetValue( comp, "item_name")
		essence_desc = ComponentGetValue( comp, "ui_description")
	end)
	
	-- add ui icon etc
	local entity_ui = EntityLoad("mods/Apotheosis/files/entities/misc/skill_no_gold.xml",pos_x,pos_y)
	EntityAddChild( entity_who_picked, entity_ui )

	--Disables enemies dropping gold
	GameAddFlagRun("drop_no_gold")

	-- cosmetic fx -------------------------------------------------------

	EntityLoad( "data/entities/particles/image_emitters/perk_effect.xml", pos_x, pos_y )
	GamePrintImportant( GameTextGet( "$log_pickedup_perk", GameTextGetTranslatedOrNot( essence_name ) ), essence_desc )

	
	EntityKill( entity_item )
end