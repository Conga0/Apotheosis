local entity_id = GetUpdatedEntityID()
if SetValueInteger("init", -100) == -100 then
	SetValueInteger("init", GameGetFrameNum())
end
local spcs = EntityGetComponent(entity_id, "SpriteComponent") or {}
for i=1, #spcs do
	ComponentSetValue2(spcs[i],	"alpha", math.min(GameGetFrameNum()-GetValueInteger("init", 0),8)/(8)*0.35)
end