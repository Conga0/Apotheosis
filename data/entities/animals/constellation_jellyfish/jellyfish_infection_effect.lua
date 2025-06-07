
local entity_id = GetUpdatedEntityID()
local player_id = EntityGetRootEntity(entity_id)
local pos_x,pos_y = EntityGetTransform(player_id)
local evscomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local curse_increment = ComponentGetValue2(evscomp,"value_float")
local curse_id = 0

local dmgcomp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")
local hp = ComponentGetValue2(dmgcomp,"hp")
local hp_max = ComponentGetValue2(dmgcomp,"max_hp")

--Check if player already has jellyfish infection inflicted
local children = EntityGetAllChildren(player_id)
if children then
    for k=1,#children
    do local v = children[k]
        if EntityGetName(v) == "apotheosis_celestial_infection" and v ~= entity_id then
            curse_id = v
            break
        end
    end
end

if curse_id ~= 0 then
    local uicomp = EntityGetFirstComponentIncludingDisabled(curse_id,"UIIconComponent")
    local vcomp = EntityGetFirstComponentIncludingDisabled(curse_id,"VariableStorageComponent")
    local curse = math.min(100,ComponentGetValue2(vcomp,"value_float") + curse_increment)
    ComponentSetValue2(vcomp,"value_float",curse)
    local text = GameTextGetTranslatedOrNot("$status_apotheosis_celestial_infection_name")
    ComponentSetValue2(uicomp,"name",table.concat({string.format(text, curse),"%"}))

    hp_max = ComponentGetValue2(vcomp,"value_int") / 25
    hp = math.max(0.04,hp_max * (1 - (curse * 0.01)))
    --ComponentSetValue(dmgcomp,"hp",hp)
    ComponentSetValue2(dmgcomp,"max_hp",hp)

    local gec = EntityGetFirstComponentIncludingDisabled(curse_id,"GameEffectComponent")
    ComponentSetValue2(gec,"frames",3600)

elseif curse_increment > 0 then
    local c = EntityLoad("mods/Apotheosis/files/entities/misc/effect_celestial_infection.xml",pos_x, pos_y)
    local uicomp = EntityGetFirstComponentIncludingDisabled(c,"UIIconComponent")
    local text = GameTextGetTranslatedOrNot("$status_apotheosis_celestial_infection_name")
    ComponentSetValue2(uicomp,"name",table.concat({string.format(text, curse_increment),"%"}))
    local vcomp = EntityGetFirstComponentIncludingDisabled(c,"VariableStorageComponent")
    ComponentSetValue2(vcomp,"value_float",curse_increment)
    ComponentSetValue2(vcomp,"value_int",hp_max * 25)
    EntityAddChild(player_id,c)
end

EntityKill(entity_id)