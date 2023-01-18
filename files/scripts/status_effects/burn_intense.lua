dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local who_shot = entity_id

local max_health = 0

edit_component( root_id, "DamageModelComponent", function(comp,vars)
    max_health = tonumber(ComponentGetValue( comp, "max_hp"))
end)

local damage = max_health * 0.0065

EntityInflictDamage( root_id, damage, "DAMAGE_FIRE", "$damage_fire", "DISINTEGRATED", 0, 0, who_shot )
