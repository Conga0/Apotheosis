local hp = 0

local entity = GetUpdatedEntityID()
local root = EntityGetParent( entity)
local vsc = EntityGetFirstComponentIncludingDisabled( entity, "VariableStorageComponent" )
local trueHP = tonumber(ComponentGetValue( vsc, "value_float" ))
local damagemodel = EntityGetFirstComponentIncludingDisabled( root, "DamageModelComponent" )

ComponentSetValue(damagemodel, "hp", trueHP)
