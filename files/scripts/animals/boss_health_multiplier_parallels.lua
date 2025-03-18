

local entity_id = GetUpdatedEntityID()
local x = EntityGetTransform(entity_id)

local health = 0
local max_health = 0
local healthMultiplier = math.max(1, 1 + (math.abs(GetParallelWorldPosition( x, 0 ) * 0.40)))

local comp = EntityGetFirstComponent( entity_id, "DamageModelComponent" )

local health = ComponentGetValue2( comp, "hp" )
local health_max = ComponentGetValue2( comp, "max_hp" )
local blood_mult = ComponentGetValue2( comp, "blood_multiplier" )

health = health * healthMultiplier
health_max = health_max * healthMultiplier
blood_mult = blood_mult / healthMultiplier

ComponentSetValue( comp, "max_hp", health_max )
ComponentSetValue( comp, "hp", health )
ComponentSetValue( comp, "blood_multiplier", blood_mult )
