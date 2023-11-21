

local entity_id = GetUpdatedEntityID()
local x = EntityGetTransform(entity_id)

local health = 0
local max_health = 0
local healthMultiplier = math.max(1, 1 + math.abs(GetParallelWorldPosition( x, 0 )))

local comp = EntityGetFirstComponent( entity_id, "DamageModelComponent" )

local health = ComponentGetValue2( comp, "hp" )
local health_max = ComponentGetValue2( comp, "max_hp" )

health = health * healthMultiplier
health_max = health_max * healthMultiplier

ComponentSetValue( comp, "max_hp", tostring(health_max) )
ComponentSetValue( comp, "hp", tostring(health) )
