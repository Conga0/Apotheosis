
--[[
local targets = EntityGetWithTag( "player_unit" )

local target = targets[1]
]]--

-- why wasn't it just GetRootEntity in the first place? it's already a status effect on an entity... -Spoop

local target = EntityGetRootEntity(entity_id)

-- incase there's ever another mod that makes you die to water, then store whatever value this is for later

local dmgcomp = EntityGetFirstComponentIncludingDisabled(target,"DamageModelComponent")
if dmgcomp ~= nil then
local wet_damage = ComponentGetValue2(dmgcomp,"wet_status_effect_damage")

EntityAddComponent( player_id, "VariableStorageComponent",
{
    name="apotheosis_wet_immune",
    value_int=wet_damage,
    value_float=0,
})

ComponentSetValue2(dmgcomp,"wet_status_effect_damage",0)

local materials = {
    "water",
    "mud",
    "water_swamp",
    "water_salt",
    "swamp",
    "snow",
    "water_ice",
    "water_fading",
    "apotheosis_water_fading_fast",
}

for k=1,#materials do
    EntitySetDamageFromMaterial( entity_id, materials[k], 0)
end
end