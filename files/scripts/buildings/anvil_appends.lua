
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

-- convert items
local converted_apotheosis = false

for _,id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 70, "tablet")) do
	-- make sure item is not carried in inventory or wand
	if EntityGetRootEntity(id) == id then
		local x,y = EntityGetTransform(id)

		local item_comps = EntityGetComponent( id, "ItemComponent" )
		local new_desc = ""
		local item_name

		if ( item_comps ~= nil ) then
			for i,itemc in ipairs(item_comps) do
				item_name = ComponentGetValue2( itemc, "item_name" )

				if( item_name == "$book_apotheosis_orbbook_12_name" ) then new_desc = "$book_apotheosis_orbbook_stone_12_description" end
				if( item_name == "$book_apotheosis_orbbook_13_name" ) then new_desc = "$book_apotheosis_orbbook_stone_13_description" end
				if( item_name == "$book_apotheosis_orbbook_14_name" ) then new_desc = "$book_apotheosis_orbbook_stone_14_description" end
				if( item_name == "$book_apotheosis_orbbook_15_name" ) then new_desc = "$book_apotheosis_orbbook_stone_15_description" end

			end
		end


		if( new_desc ~= "" ) then
			local forged_book = EntityLoad("data/entities/items/books/base_forged.xml", x, y - 5)
			item_comps = EntityGetComponent( forged_book, "ItemComponent" )
			if ( item_comps ~= nil ) then
				for i,itemc in ipairs(item_comps) do
					ComponentSetValue( itemc, "item_name", item_name )
					ComponentSetValue( itemc, "ui_description", new_desc )
				end
			end

			local uiinfo_comp = EntityGetComponent( forged_book, "UIInfoComponent" )
			if( uiinfo_comp ~= nil ) then
				for i,uiinfoc in ipairs(uiinfo_comp) do
					ComponentSetValue( uiinfoc, "name", item_name )
				end
			end

			local ability_comp = EntityGetComponent( forged_book, "AbilityComponent" )
			if( ability_comp ~= nil ) then
				for i,abic in ipairs(ability_comp) do
					ComponentSetValue( abic, "ui_name", item_name )
				end
			end

			EntityLoad("data/entities/projectiles/explosion.xml", x, y - 10)
			EntityKill(id)
		end
		converted_apotheosis = true
	end
end

local forgables = EntityGetInRadiusWithTag(pos_x, pos_y, 70, "forgeable")
for k=1,#forgables do
	local v = forgables[k]
	local x,y = EntityGetTransform(v)

	if EntityGetName(v) == "toiletpaper_fragment_apotheosis" then
		CreateItemActionEntity( "APOTHEOSIS_TOILET_PAPER", x, y)
		AddFlagPersistent( "apotheosis_card_unlocked_toiletpaper_spell" )

		EntityLoad("data/entities/projectiles/explosion.xml", x, y - 10)
		EntityKill(v)
		converted_apotheosis = true
	end
end


if converted_apotheosis then
	GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
	GameTriggerMusicEvent( "music/oneshot/dark_01", true, pos_x, pos_y )
end