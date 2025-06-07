dofile_once("data/scripts/lib/utilities.lua")
--Handles spawning Heretic after he just portaled in, and updating his incarnation value
--Same script as the normal one, just with 2 extra lines that make Heretic always loaded in

function get_magnitude( x, y )
	local result = math.sqrt( x ^ 2 + y ^ 2 )
	return result
end

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

if not GameHasFlagRun("apotheosis_flesh_boss_released") then
	GameAddFlagRun("apotheosis_flesh_boss_released")
end

local cowardness = tonumber(GlobalsGetValue("HERETIC_COWARDLY"))
if cowardness == nil then
	cowardness = 0
end
GlobalsSetValue("HERETIC_COWARDLY", tostring(cowardness + 1))

local safe_mode = false
local heretic_stones = EntityGetInRadiusWithTag(pos_x,pos_y,50,"poopstone") or {}
for k=1,#heretic_stones
do local v = heretic_stones[k]
	local comp = EntityGetFirstComponentIncludingDisabled(v,"PhysicsImageShapeComponent")
	if ComponentGetValue2(comp,"image_file") == "mods/Apotheosis/files/items_gfx/goldnugget_01_alt_heretic.png" and EntityGetParent(v) == 0 then
		local stone_id = v
		local parent = EntityGetParent(stone_id)
		if parent == 0 then
			local stone_x, stone_y = EntityGetTransform(stone_id)
			local dis_x = stone_x - pos_x
			local dis_y = stone_y - pos_y
			local distance = get_magnitude(dis_x, dis_y)

			if distance <= 50 then
				--Heretic has successfully eaten the corrupt stone, now Heretic will hoodini away shortly after
				EntityKill(stone_id)
				GameAddFlagRun( "apotheosis_miniboss_boss_flesh_monster_stone" )
				EntitySetComponentsWithTagEnabled(entity_id,"angry_ghost_cooldown",true)

				local player_id = EntityGetWithTag("player_unit")[1]
				targ_x, targ_y = EntityGetTransform(player_id)

				local cam_x, cam_y, cam_w, cam_h = GameGetCameraBounds()

				local range = cam_h / 2

				local a_x = pos_x - targ_x
				local a_y = pos_y - targ_y

				local distance = get_magnitude(a_x, a_y)
				if ( distance > range ) then
					--oh no! the player likely cannot see this nonsense transpiring!
					--let's cool things down a bit so whatever they have around isn't destroyed
					safe_mode = true
				end
			end
		end
	end
end

if GameHasFlagRun("apotheosis_flesh_boss_armor") then
	local eid = EntityLoad("data/entities/animals/boss_flesh_monster/phase3/boss_flesh_monster.xml", pos_x, pos_y)
	EntityAddComponent(eid, "StreamingKeepAliveComponent" ) 
	EntityAddComponent(eid, "LuaComponent", {
	    script_source_file="data/entities/animals/boss_flesh_monster/boss_flesh_monster_chase_target_distance.lua",
	    execute_every_n_frame=100,
	}) 
	EntitySetTransform(eid, pos_x, pos_y)
	local dmgcomp = EntityGetFirstComponentIncludingDisabled(eid,"DamageModelComponent")
	local max_hp = ComponentGetValue2( dmgcomp, "max_hp")
	local health = max_hp
	ComponentSetValue( dmgcomp, "hp", health)

	local incarncomp = EntityGetComponentIncludingDisabled( eid, "VariableStorageComponent" )[2]
	ComponentSetValue2( incarncomp, "value_int", tonumber(GlobalsGetValue("HERETIC_COWARDLY")))

	--Put a thing to disable flesh convert here when I add it
	if safe_mode == true then
		local celcomp = EntityGetFirstComponentIncludingDisabled(eid,"CellEaterComponent")
		EntitySetComponentIsEnabled(eid,celcomp,false)
	end

	EntityLoad("data/entities/animals/boss_flesh_monster/phase3/transport_emitter_flesh.xml", pos_x, pos_y)

	--Make the heretic more aggressive if the player has severely stacked more love, to prevent Heretic from having no thoughts head empty and floating to the east
	local animalaicomp = EntityGetFirstComponentIncludingDisabled(eid,"AnimalAIComponent")
	ComponentSetValue2(animalaicomp,"mAggression",ComponentGetValue2(animalaicomp,"mAggression") + (total_extra_love * 25))

else
	local eid = EntityLoad("data/entities/animals/boss_flesh_monster/boss_flesh_monster.xml", pos_x, pos_y)
	EntityAddComponent(eid, "StreamingKeepAliveComponent" ) 
	EntityAddComponent(eid, "LuaComponent", {
	    script_source_file="data/entities/animals/boss_flesh_monster/boss_flesh_monster_chase_target_distance.lua",
	    execute_every_n_frame=100,
	}) 
	EntitySetTransform(eid, pos_x, pos_y)
	local dmgcomp = EntityGetFirstComponentIncludingDisabled(eid,"DamageModelComponent")
	local max_hp = ComponentGetValue2( dmgcomp, "max_hp")
	local health = max_hp
	ComponentSetValue( dmgcomp, "hp", health)

	local incarncomp = EntityGetComponentIncludingDisabled( eid, "VariableStorageComponent" )[2]
	ComponentSetValue2( incarncomp, "value_int", tonumber(GlobalsGetValue("HERETIC_COWARDLY")))

	if safe_mode == true then
		local celcomp = EntityGetFirstComponentIncludingDisabled(eid,"CellEaterComponent")
		EntitySetComponentIsEnabled(eid,celcomp,false)
	end

	--Handles Heretic's armor breakage, would be weird for it to randomly regenerate magically
	if GameHasFlagRun("apotheosis_flesh_boss_armor_1") then
		local storages = EntityGetComponentIncludingDisabled( eid, "VariableStorageComponent" )[1]
		ComponentSetValue2( storages, "value_float", 1)

		local spritecomp = 0
		local spritecomp2 = 0
		local spritecomps = EntityGetComponentIncludingDisabled(eid, "SpriteComponent") or {}
		for i = 1, #spritecomps do
		    if ComponentGetValue2(spritecomps[i], "image_file") == "mods/Apotheosis/files/enemies_gfx/sacriligious_monster/armor.png" then
		        spritecomp = spritecomps[i]
		    end
		    if ComponentGetValue2(spritecomps[i], "image_file") == "mods/Apotheosis/files/enemies_gfx/sacriligious_monster/armor_emissive.png" then
		        spritecomp2 = spritecomps[i]
		    end
		end
		if GameHasFlagRun("apotheosis_flesh_boss_armor_4") then
		    ComponentSetValue2( spritecomp, "image_file", "mods/Apotheosis/files/enemies_gfx/sacriligious_monster/armor_flesh_4.png")
		elseif GameHasFlagRun("apotheosis_flesh_boss_armor_3") then
		    ComponentSetValue2( spritecomp, "image_file", "mods/Apotheosis/files/enemies_gfx/sacriligious_monster/armor_flesh_3.png")
		elseif GameHasFlagRun("apotheosis_flesh_boss_armor_2") then
		    ComponentSetValue2( spritecomp, "image_file", "mods/Apotheosis/files/enemies_gfx/sacriligious_monster/armor_flesh_2.png")
		else
		    ComponentSetValue2( spritecomp, "image_file", "mods/Apotheosis/files/enemies_gfx/sacriligious_monster/armor_flesh_1.png")
		end
		ComponentSetValue2( spritecomp2, "image_file", "mods/Apotheosis/files/enemies_gfx/sacriligious_monster/armor_emissive_alt.png")
	end

	EntityLoad("data/entities/animals/boss_flesh_monster/transport_emitter.xml", pos_x, pos_y)

	--Make the heretic more aggressive if the player has severely stacked more love, to prevent Heretic from having no thoughts head empty and floating to the east
	local animalaicomp = EntityGetFirstComponentIncludingDisabled(eid,"AnimalAIComponent")
	ComponentSetValue2(animalaicomp,"mAggression",ComponentGetValue2(animalaicomp,"mAggression") + (total_extra_love * 25))

end

EntityKill(entity_id)
