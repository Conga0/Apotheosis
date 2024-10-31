local previousInit = do_newgame_plus
---@diagnostic disable-next-line: lowercase-global
function do_newgame_plus()
	previousInit()
    GameRemoveFlagRun( "apotheosis_blob_boss_slain" )
    GameRemoveFlagRun( "apotheosis_fire_lukki_boss_summoned" )

	--If you take a certain stone through while someone's alive then they'll give chase!
	if not GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") and not GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster_stone") then
		--I am a complete and utter fool... ugh...
		--Probably should delete this but I'm too ashamed right now, doing it later......... probably... -S
		--EntityLoad("mods/Apotheosis/files/entities/buildings/newgame_plus_stone_heretic_checker.xml", 778, -1261)

		local stone_id = nil
		local heretic_stones = EntityGetWithTag("poopstone") or {}
		for k=1,#heretic_stones
		do local v = heretic_stones[k]
			local comp = EntityGetFirstComponentIncludingDisabled(v,"PhysicsImageShapeComponent")
			if ComponentGetValue2(comp,"image_file") == "mods/Apotheosis/files/items_gfx/goldnugget_01_alt_heretic.png" then
				stone_id = v
				break
			elseif ComponentGetValue2(comp,"image_file") == "mods/Apotheosis/files/items_gfx/goldnugget_01_alt_radar.png" then
				stone_id = v
				break
			end
		end

		if stone_id ~= nil and EntityGetParent(stone_id) ~= nil then
			EntityLoad("mods/Apotheosis/files/entities/misc/spawn_boss_flesh_monster_newgame_plus_delay.xml", 778, -1261)
		end
	end
end