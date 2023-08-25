dofile( "data/scripts/game_helpers.lua" )
dofile_once("data/scripts/lib/utilities.lua")
dofile( "data/scripts/perks/perk_list.lua" )

function item_pickup( entity_item, entity_who_picked, item_name )

	-- fetch perk info ---------------------------------------------------

	local pos_x, pos_y = EntityGetTransform( entity_item )
	
	local essence_name = "ESSENCE_NAME_NOT_DEFINED"
	local essence_desc = "ESSENCE_DESCRIPTION_NOT_DEFINED"
	
	edit_component( entity_item, "ItemComponent", function(comp,vars)
		essence_name = ComponentGetValue( comp, "item_name")
		essence_desc = ComponentGetValue( comp, "ui_description")
	end)

	local id = ""
	edit_component( entity_item, "VariableStorageComponent", function(comp,vars)
		id = ComponentGetValue( comp, "value_string" )
	end)
	
	-- add ui icon etc
	local entity_ui = EntityCreateNew( "" )
	EntityAddComponent( entity_ui, "UIIconComponent", 
	{ 
		name = "$item_apotheosis_skill_angler_name",
		description = "$item_apotheosis_skill_angler_desc",
		icon_sprite_file = "mods/Apotheosis/files/ui_gfx/essences/skill_angler.png"
	})
	EntityAddChild( entity_who_picked, entity_ui )
	
	local value = tonumber(GlobalsGetValue( "APOTHEOSIS_FISHING_SKILL", "0" ))
	GlobalsSetValue( "APOTHEOSIS_FISHING_SKILL", tostring(value + 1))

	-- cosmetic fx -------------------------------------------------------

	EntityLoad( "data/entities/particles/image_emitters/perk_effect.xml", pos_x, pos_y )
	GamePrintImportant( GameTextGet( "$log_pickedup_perk", GameTextGetTranslatedOrNot( essence_name ) ), essence_desc )

	
	EntityKill( entity_item )
end