
local entity_id = GetUpdatedEntityID()
local parent_id = EntityGetRootEntity(entity_id)

local comp = EntityGetFirstComponentIncludingDisabled(parent_id,"DamageModelComponent")
ComponentSetValue2(comp,"ragdoll_material","slime")
ComponentSetValue2(comp,"hp",0.00)
ComponentSetValue2(comp,"max_hp",0.04)

EntityInflictDamage( parent_id, 9999, "DAMAGE_OVEREATING", "$damage_apotheosis_addiction", "NONE", 0, 0, parent_id )
