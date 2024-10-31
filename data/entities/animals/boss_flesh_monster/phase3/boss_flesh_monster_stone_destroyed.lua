--dofile_once("data/scripts/lib/utilities.lua")

if GameHasFlagRun( "apotheosis_miniboss_boss_flesh_monster_stone" ) then
    local comp_id = GetUpdatedComponentID()
    EntityRemoveComponent(entity_id,comp_id)
end

if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") or GameHasFlagRun("apotheosis_flesh_boss_stone_converted") then
    --MY SHINY ROCK NOOOOOO!!!
    local entity_id = GetUpdatedEntityID()
    local pos_x,pos_y = EntityGetTransform( entity_id )

    if GameHasFlagRun("apotheosis_flesh_boss_mind_warp") == false and GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") and ModIsEnabled("raksa") == false then
	local player = EntityGetInRadiusWithTag(pos_x, pos_y, 400, "player_unit")[1] or nil
	if player ~= nil then
	    GameAddFlagRun("apotheosis_flesh_boss_mind_warp")
	    local warp_id = EntityLoad("mods/Apotheosis/files/entities/misc/effect_mind_warp.xml", pos_x, pos_y)
	    EntityAddChild(player, warp_id)
	end
    end

    local physaicomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsAIComponent" )
    ComponentSetValue2(physaicomp, "force_coeff", 50)
    ComponentSetValue2(physaicomp, "force_max", 1500)

    local distance = false

    --Heretic attacks faster and changes up some attacks
    if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
    local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
    for i = 1, #luacomps do
	if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_shadow_barrage_2.lua" then
	    ComponentSetValue2(luacomps[i], "execute_every_n_frame", 320)
	    ComponentSetValue2(luacomps[i], "script_source_file", "data/entities/animals/boss_flesh_monster/boss_flesh_monster_shadow_barrage_2_setup.lua")
	end
	if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_hex_arc.lua" then
	    ComponentSetValue2(luacomps[i], "execute_every_n_frame", 420)
	end
	if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_chase_target.lua" then
	    ComponentSetValue2(luacomps[i], "execute_every_n_frame", 1500)
	end
	if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_darkflame_barrage_setup.lua" then
	    ComponentSetValue2(luacomps[i], "execute_every_n_frame", 320)
	    ComponentSetValue2(luacomps[i], "script_source_file", "data/entities/animals/boss_flesh_monster/boss_flesh_monster_darkflame_barrage_2_setup.lua")
	end
	if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_hex_barrage_setup.lua" then
	    ComponentSetValue2(luacomps[i], "execute_every_n_frame", 420)
	end
	if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/phase3/boss_flesh_monster_life_drain.lua" then
	    ComponentSetValue2(luacomps[i], "script_source_file", "data/entities/animals/boss_flesh_monster/phase3/boss_flesh_monster_life_drain_enraged.lua")
	end
	if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/Apotheosis/files/scripts/animals/boss_armor.lua" then
	    ComponentSetValue2(luacomps[i], "script_source_file", "mods/Apotheosis/files/scripts/animals/boss_armor_strong.lua")
	end
	if ComponentGetValue2(luacomps[i], "script_source_file") == "data/entities/animals/boss_flesh_monster/boss_flesh_monster_chase_target_distance.lua" then
	    distance = true
	end
    end
    end

    if distance == false then
	EntityAddComponent(entity_id, "LuaComponent", {
	    script_source_file="data/entities/animals/boss_flesh_monster/boss_flesh_monster_chase_target_distance.lua",
	    execute_every_n_frame=100,
	}) 
    end

    --Heretic immediately rushes player
    EntityAddComponent(entity_id, "LuaComponent", {
	script_source_file="data/entities/animals/boss_flesh_monster/boss_flesh_monster_stone_target.lua",
	execute_every_n_frame=5,
	remove_after_executed=1,
    }) 
    EntityAddComponent(entity_id, "LuaComponent", {
	script_source_file="data/entities/animals/boss_flesh_monster/boss_flesh_monster_chase_target.lua",
	execute_every_n_frame=10,
	remove_after_executed=1,
    }) 

    --Heretic gets a corrupt master shield cause why not?
    if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
    EntityAddComponent(entity_id, "LuaComponent", {
	script_damage_received="data/entities/animals/boss_flesh_monster/boss_flesh_monster_shield_logic.lua",
	execute_every_n_frame=-1,
    }) 
    EntityAddComponent(entity_id, "VariableStorageComponent", {
	name="shield_stuff",
    }) 
    end

    --Heretic heals to full after enraging
    local hp = 0
    local max_hp = 0
    local dmgcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "DamageModelComponent" )
    hp = ComponentGetValue2( dmgcomp, "hp" ) 
    max_hp = ComponentGetValue2( dmgcomp, "max_hp" ) 

    if (hp < max_hp * 0.98) then
	local heal_effect = EntityLoad( "mods/apotheosis/files/entities/particles/heal_effect_big.xml", pos_x, pos_y )
	EntityAddChild( entity_id, heal_effect )
    end
    ComponentSetValue2( dmgcomp, "hp", max_hp ) 

    ComponentSetValue2( dmgcomp, "critical_damage_resistance", 0.8)

    --Heretic will now hunt player to the ends of the Earth (hopefully)
    local allseeing = EntityGetFirstComponentIncludingDisabled( entity_id, "StreamingKeepAliveComponent" )
    if allseeing == nil then
	EntityAddComponent(entity_id, "StreamingKeepAliveComponent" ) 
    end

    local comp_id = GetUpdatedComponentID()
    EntityRemoveComponent(entity_id, comp_id)
end