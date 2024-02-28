
local entity_id = GetUpdatedEntityID()

local health = 0
local max_health = 0
local healthMultiplier = ModSettingGet( "Apotheosis.boss_health_multiplayer" )

local comp = EntityGetFirstComponent( entity_id, "DamageModelComponent" )

local health = ComponentGetValue2( comp, "hp" )
local health_max = ComponentGetValue2( comp, "max_hp" )
local blood_mult = ComponentGetValue2( comp, "blood_multiplier" )

health = health * (healthMultiplier / 100)
health_max = health_max * (healthMultiplier / 100)
blood_mult = blood_mult / (healthMultiplier / 100)

ComponentSetValue( comp, "max_hp", tostring(health_max) )
ComponentSetValue( comp, "hp", tostring(health) )
ComponentSetValue( comp, "blood_multiplier", tostring(blood_mult) )
