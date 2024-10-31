
local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y, rot = EntityGetTransform( entity_id )

GlobalsSetValue("HERETIC_X", tostring(pos_x))
GlobalsSetValue("HERETIC_Y", tostring(pos_y))
--print("heretic_x: " .. tostring(GlobalsGetValue("HERETIC_X")))
--print("heretic_y: " .. tostring(GlobalsGetValue("HERETIC_Y")))

if GameHasFlagRun("apotheosis_flesh_boss_mind_warp") == false and GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
	local player = EntityGetInRadiusWithTag(pos_x, pos_y, 400, "player_unit")[1] or nil
	if player ~= nil then
		GameAddFlagRun("apotheosis_flesh_boss_mind_warp")
		local warp_id = EntityLoad("mods/Apotheosis/files/entities/misc/effect_mind_warp.xml", pos_x, pos_y)
		EntityAddChild(player, warp_id)
	end
end
