local max_hp = 0

local entity = GetUpdatedEntityID()
local root = EntityGetParent( entity)

local vsc = EntityGetFirstComponentIncludingDisabled( entity, "VariableStorageComponent" )

local trueHP = tonumber( ComponentGetValue( vsc, "value_float") )
local damagemodel = EntityGetFirstComponentIncludingDisabled( root, "DamageModelComponent" )
max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ))
ComponentSetValue( vsc, "value_float", max_hp)
