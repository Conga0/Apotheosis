
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
--Could reduce alpha instead?
--[[
]]--
if hp < 3880 then
	local tbl = EntityGetComponentIncludingDisabled( entity_id, "SpriteComponent", "ui" )
	for k=1,#tbl do
		ComponentSetValue2(tbl[k],"alpha",1)
	end
else
	local tbl = EntityGetComponentIncludingDisabled( entity_id, "SpriteComponent", "ui" )
	for k=1,#tbl do
		ComponentSetValue2(tbl[k],"alpha",0)
	end
end
