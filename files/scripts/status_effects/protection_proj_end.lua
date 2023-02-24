local entity_id = GetUpdatedEntityID()
local vsccomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
entity_id = EntityGetRootEntity(entity_id)

local dmgcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
if dmgcomp ~= nil then

    local projdmg = ComponentGetValue2(vsccomp,"value_float")

    ComponentObjectSetValue2( dmgcomp, "damage_multipliers", "projectile", projdmg )

end