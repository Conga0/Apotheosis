dofile_once( "data/scripts/game_helpers.lua" )
dofile_once("data/scripts/lib/utilities.lua")
dofile_once( "data/scripts/perks/perk_list.lua" )
dofile_once("data/scripts/perks/perk.lua")

function kill_nearby_perks(eid,pos_x,pos_y)
	local perk_destroy_chance = tonumber( GlobalsGetValue( "TEMPLE_PERK_DESTROY_CHANCE", "100" ) )
	SetRandomSeed( pos_x, pos_y )

	if( Random( 1, 100 ) <= perk_destroy_chance ) then
		-- removes all the perks
		local all_perks = EntityGetWithTag( "perk" )
		disable_reroll = true
	
		if ( #all_perks > 0 ) then
			for i,entity_perk in ipairs(all_perks) do
				if entity_perk ~= eid then
					EntityKill( entity_perk )
				end
			end
		end
	end
end

function item_pickup( entity_item, entity_who_picked, item_name )

	local pos_x, pos_y = EntityGetTransform( entity_item )
	
	-- add ui icon etc
	local entity_ui = EntityLoad("mods/Apotheosis/files/entities/misc/perks/mimic.xml",pos_x,pos_y)
	local uicomp = EntityGetFirstComponentIncludingDisabled(entity_ui,"UIIconComponent")
    local hotkey = ModSettingGet("Apotheosis.bind_disguise_translated")
	local desc = GameTextGetTranslatedOrNot("$perk_apotheosis_mimic_description"):gsub("$0",hotkey)
	ComponentSetValue2(uicomp,"description",desc)
	EntityAddChild( entity_who_picked, entity_ui )

	-- cosmetic fx -------------------------------------------------------

	EntityLoad( "data/entities/particles/image_emitters/perk_effect.xml", pos_x, pos_y )
	GamePrintImportant( GameTextGet( "$log_pickedup_perk", GameTextGetTranslatedOrNot("$perk_apotheosis_mimic") ), GameTextGetTranslatedOrNot("$perk_apotheosis_mimic_description_progress") )

	EntityKill( entity_item )
	kill_nearby_perks(entity_item,pos_x,pos_y)
end

function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )

    local entity_id = GetUpdatedEntityID()
    local pos_x, pos_y = EntityGetTransform(entity_id)

    perk_spawn( pos_x, pos_y - 2, "EDIT_WANDS_EVERYWHERE" )

end

local entity_id = GetUpdatedEntityID()
local item_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"ItemComponent")
if GameGetGameEffectCount(entity_id,"CHARM") > 0 then
	EntitySetComponentIsEnabled( entity_id, item_comp, true )
else
	EntitySetComponentIsEnabled( entity_id, item_comp, false )
end