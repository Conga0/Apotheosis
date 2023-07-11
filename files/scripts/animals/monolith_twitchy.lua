
local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

if math.random(1,10) == 1 then
	local player = EntityGetInRadiusWithTag(pos_x, pos_y, 512, "player_unit")[1]
	local c_id = EntityLoad("mods/apotheosis/files/entities/misc/aura/aura_twitchy_debuff.xml", pos_x, pos_y)
	EntityAddChild(player, c_id)
end
