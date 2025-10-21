dofile_once("data/scripts/lib/utilities.lua")

local max_hp = 0
local hp 	 = 0

local entity = GetUpdatedEntityID()
local root = EntityGetParent( entity)

local vsc = EntityGetFirstComponentIncludingDisabled( entity, "VariableStorageComponent" )

local trueHP = tonumber(ComponentGetValue( vsc, "value_float" ))

--print("morphine.lua: trueHP before math: " .. trueHP)
local damagemodel = EntityGetFirstComponentIncludingDisabled( root, "DamageModelComponent" )

max_hp 	= ComponentGetValue2( damagemodel, "max_hp" ) 
 
hp		= ComponentGetValue2( damagemodel, "hp"	 ) 

diff 	= max_hp - hp
--print("morphine.lua: Max HP: " .. max_hp .. " HP: " .. hp .. " diff: " .. diff )

trueHP = trueHP - diff

--print("morphine.lua: trueHP after math: " .. trueHP)


if (trueHP <= 0) then
	EntityInflictDamage( root, 5 * max_hp, "DAMAGE_OVEREATING", "Careful with those painkillers.", "PLAYER_RAGDOLL_CAMERA", -500, 0)
end
ComponentSetValue(damagemodel, "hp", max_hp)

ComponentSetValue( vsc, "value_float", trueHP)


--print("Morphine")