
local entity_id = GetUpdatedEntityID()
local player_id = EntityGetParent(entity_id)
local pos_x, pos_y = EntityGetTransform(entity_id)

local damageComp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")
local hp = math.ceil(ComponentGetValue2(damageComp,"hp"))
local hp_max = ComponentGetValue2(damageComp,"max_hp")
local highest_legal_hp = tonumber(GlobalsGetValue("curse_meat_max","0"))

if highest_legal_hp == 0 then
    highest_legal_hp = hp
    GlobalsSetValue("curse_meat_max",tostring(hp))
end

if hp > highest_legal_hp then
    EntityInflictDamage( player_id, math.min(hp - highest_legal_hp,hp_max * 0.05), "DAMAGE_CURSE", "Meat Curse", "NONE", 0, 0)
elseif hp <= highest_legal_hp then
    GlobalsSetValue("curse_meat_max",tostring(hp))
end
