
local entity_id = GetUpdatedEntityID()
if GetValueNumber("radius", -100) == -100 then
	SetValueNumber("radius", (tonumber(EntityGetName(entity_id)) or 5)+2)
	SetValueNumber("speed", tonumber(math.random(30,40)) or 5)
	SetValueNumber("rot", (math.random()-0.5)/60)
end

local x, y, r = EntityGetTransform(entity_id)
EntitySetTransform(entity_id, x, y, r + GetValueNumber("rot", 35))

local radius = GetValueNumber("radius", 8)
local spcs = EntityGetComponent(entity_id, "SpriteComponent") or {}
local n_spcs = #spcs
local a = ((GameGetFrameNum()+entity_id)/radius)
for i=1, n_spcs do
	local spc = spcs[i]
	local b = a+(i*2*math.pi/n_spcs)
	ComponentSetValue2(spc,	"offset_x",	(math.cos(b)*radius)+1.5)
	ComponentSetValue2(spc,	"offset_y",	(math.sin(b)*radius)+2)
end