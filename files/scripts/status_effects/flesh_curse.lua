
local entity = GetUpdatedEntityID() 

local root = EntityGetRootEntity( entity ) 

local x, y = EntityGetTransform(root) 
local max_hp = 0         
local damagemodel = EntityGetFirstComponentIncludingDisabled( root, "DamageModelComponent" ) 

max_hp = ComponentGetValue2( damagemodel, "max_hp" ) 

EntityInflictDamage( root, max_hp / 200 , "DAMAGE_CURSE", "$status_apotheosis_flesh_curse_death", "PLAYER_RAGDOLL_CAMERA", 0, 0) 
