
local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
local hp = ComponentGetValue2(comp,"hp")
if hp < 3999 then
	local c_id = EntityLoad("mods/apotheosis/files/entities/misc/aura/aura_heal_600.xml", pos_x, pos_y)
	EntityAddChild(entity_id, c_id)
end

--Conga: no worky, too eepy seepy to fix
--Some issue with healthbar components not liking being disabled
--[[
if hp < 3920 then
	EntitySetComponentsWithTagEnabled( entity_id, "ui", true )
else
	EntitySetComponentsWithTagEnabled( entity_id, "ui", false )
end
]]--
