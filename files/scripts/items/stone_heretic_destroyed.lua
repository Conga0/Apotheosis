local entity_id = GetUpdatedEntityID()
local parent_id = EntityGetParent(entity_id)
local player_id = EntityGetParent(parent_id)
if (player_id ~= 0 and EntityHasTag( player_id, "player_unit" )) or (player_id == 0 and parent_id ~= 0 and EntityGetName(parent_id) == "inventory_quick") then return end
if GameHasFlagRun("apotheosis_heretalk_portal_complete") or ModIsEnabled("raksa") then return end --It don't matter it already done!
--Oh no, Heretic gonna be upsetti
local pos_x, pos_y = EntityGetTransform(entity_id)

GameAddFlagRun("apotheosis_flesh_boss_stone_initiated")
-- if not GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster_stone") then
    if GameHasFlagRun("apotheosis_heretalk_guiding_stone") then
	GameAddFlagRun("apotheosis_flesh_boss_stone_converted")
    else
	GameAddFlagRun("apotheosis_flesh_boss_stone_destroyed")
	EntityLoad( "mods/Apotheosis/files/entities/misc/stone_heretic_death_check.xml", pos_x, pos_y )
    end
-- end

if not GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") and not GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster_stone") then
    local player = EntityGetClosestWithTag( pos_x, pos_y, "player_unit" ) or nil
    if player ~= nil then
	EntityAddComponent(player, "LuaComponent", {
	    script_source_file="data/entities/animals/boss_flesh_monster/player_find_boss.lua",
	    execute_every_n_frame=3600,
	})
    end
    if not GameHasFlagRun("apotheosis_heretalk_guiding_stone") then
	local heretic_found = false

	local boss = EntityGetInRadiusWithTag( pos_x, pos_y, 800, "miniboss" ) or nil
	for bp=1,#boss do
	    if EntityGetName(boss[bp]) == "$creep_apotheosis_boss_flesh_monster_name" then
		--Oh he upsetti
		heretic_found = true
		h_x, h_y = EntityGetTransform( boss[bp] )
		GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/stone_heretic/monster", h_x, h_y );
		GameScreenshake( 150 )
	    end
	end

	if heretic_found == false then
	    GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/stone_heretic/monster_distant", pos_x, pos_y );
	    GameScreenshake( 100 )
	end
    end
end
GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/stone_heretic/destroyed", pos_x, pos_y );
EntityKill(entity_id)