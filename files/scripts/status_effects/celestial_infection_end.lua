local entity_id = GetUpdatedEntityID()
local player_id = EntityGetRootEntity(entity_id)
local vcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local dmgcomp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")
if dmgcomp ~= 0 then
    local curse = ComponentGetValue2(vcomp,"value_float")
    local hp_max = ComponentGetValue2(dmgcomp,"max_hp")
    local new_hp = hp_max / (1 - (curse * 0.01))
    if new_hp < 1 or curse > 99 then
        new_hp = ComponentGetValue2(vcomp,"value_int") / 25
    end
    ComponentSetValue2(dmgcomp,"max_hp",new_hp)
end