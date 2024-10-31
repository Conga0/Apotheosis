local entity_id = GetUpdatedEntityID()
local parent = EntityGetParent(entity_id)
if parent == 0 then
    local pos_x, pos_y, rot, scale_x, scale_y = EntityGetTransform(entity_id)
    local currbiome = BiomeMapGetName( pos_x, pos_y )
    currbiome = tostring(currbiome)
    if currbiome == "$biome_lava_excavation" then
	local eid = EntityLoad( "mods/Apotheosis/files/entities/props/egg_volcanic_lukki_trap.xml", pos_x, pos_y )
	EntityApplyTransform( eid, pos_x, pos_y, rot, scale_x, scale_y)

	EntityKill(entity_id)
    end
end