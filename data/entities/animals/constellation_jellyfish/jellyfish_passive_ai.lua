local entity_id = GetUpdatedEntityID()
local pos_x,pos_y = EntityGetTransform(entity_id)
local vsc = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")

local dmgcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
local hp = ComponentGetValue2(dmgcomp,"hp")
local hp_max = ComponentGetValue2(dmgcomp,"max_hp")

if hp < (hp_max * 0.95) then
    ComponentSetValue2(vsc,"value_bool",true)
    EntitySetComponentsWithTagEnabled( entity_id, "invincible", true )
    EntitySetComponentIsEnabled( entity_id, GetUpdatedComponentID(), false )
end