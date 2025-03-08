local entity_id = GetUpdatedEntityID()
if GetValueNumber("radius", -100) == -100 then
	math.randomseed(entity_id*12, GameGetFrameNum())
	SetValueNumber("radius", (tonumber(EntityGetName(entity_id)) or 5)+math.random(0,3))
	--SetValueNumber("angle", tonumber(EntityGetName(entity_id))/2+math.random(10,30)/10)
	SetValueNumber("speed", math.random(15,20))
	SetValueNumber("rot", (math.random()-0.5)/12)
	EntitySetTransform(entity_id, 0, 0, 2*math.pi*math.random())
end
local x, y, r = EntityGetTransform(entity_id)
local radius = GetValueNumber("radius", 8)
EntitySetTransform(entity_id, x, y, r + GetValueNumber("rot", 35))
local spcs = EntityGetComponent(entity_id, "SpriteComponent") or {}
local n_spcs = #spcs
local a = ((GameGetFrameNum()+entity_id)/GetValueNumber("speed", 35))
for i=1, n_spcs do
	local spc = spcs[i]
	local b = a+(i*2*math.pi/n_spcs)
	local sin = math.sin(b)
	ComponentSetValue2(spc,	"special_scale_x",	sin)
	ComponentSetValue2(spc,	"offset_x",			(math.cos(b)*radius/sin)+2)
	ComponentSetValue2(spc,	"offset_y",			((math.cos(0.1*b))/2*radius*sin)+2)
	ComponentSetValue2(spc,	"z_index",			(sin>=0 and 10 or -10))
	EntityRefreshSprite(entity_id, spc)
end