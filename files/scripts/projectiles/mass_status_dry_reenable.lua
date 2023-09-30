local child_id	= GetUpdatedEntityID()
local entity_id = EntityGetRootEntity(child_id)

local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteStainsComponent")
if comp ~= nil then
	EntitySetComponentIsEnabled(entity_id,comp,true)
end

local x,y = EntityGetTransform(entity_id)
local c = EntityLoad("mods/apotheosis/files/entities/misc/effect_status_dry_cooldown.xml", x, y)
EntityAddChild(entity_id,c)
