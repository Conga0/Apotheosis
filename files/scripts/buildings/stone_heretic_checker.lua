local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

print("wagawaga")
local stone_id = nil
local heretic_stones = EntityGetWithTag("poopstone") or {}
for k=1,#heretic_stones
do local v = heretic_stones[k]
	print("wowza!")
	local comp = EntityGetFirstComponentIncludingDisabled(v,"PhysicsImageShapeComponent")
	if ComponentGetValue2(comp,"image_file") == "mods/apotheosis/files/items_gfx/goldnugget_01_alt_heretic.png" and EntityGetParent(v) == 0 then
		print("bingbangbong")
		stone_id = v
		break
	elseif ComponentGetValue2(comp,"image_file") == "mods/apotheosis/files/items_gfx/goldnugget_01_alt_radar.png" and EntityGetParent(v) == 0 then
		print("bongbangbing")
		stone_id = v
		break
	end
end

if stone_id ~= nil and EntityGetParent(stone_id) ~= nil then
	print("wow!")
	EntityLoad("mods/Apotheosis/files/entities/misc/spawn_boss_flesh_monster_stone_convert_delay.xml", pos_x, pos_y)
end

EntityKill(entity_id)