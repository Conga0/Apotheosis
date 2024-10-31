
local effect_id = GetUpdatedEntityID()
local entity_id = EntityGetParent(effect_id)
local pos_x, pos_y = EntityGetTransform( entity_id )
	
local child_id = EntityLoad("mods/Apotheosis/files/entities/misc/effect_mind_warp_end.xml",pos_x,pos_y)
EntityAddChild(entity_id,child_id)

--GamePrint("whaaaaa")