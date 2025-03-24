local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
LoadPixelScene("mods/Apotheosis/files/biome_impl/dev_test/scene_test.png", "", x, y, "", true, true, {}, 50, true)
--[[
--260x520
for x=0, 2600, 260 do
	for y=0, 5200, 520 do
		EntityLoad("mods/Apotheosis/files/entities/special/test_perf.xml", x, y)
	end
end]]