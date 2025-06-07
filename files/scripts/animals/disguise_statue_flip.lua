
local entity_id = GetUpdatedEntityID()
local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent")
SetRandomSeed(GameGetFrameNum(),555)
if Random(1,2) == 1 then
	ComponentSetValue2(comp,"image_file","data/buildings_gfx/statue_trap_left.xml")
	EntityRefreshSprite(entity_id,comp)
end
