
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local r = 250

local curse = false
local threat = false

local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "enemy" ) or {}
for k=1, #targets
do local v = targets[k]
    local genome = EntityGetFirstComponentIncludingDisabled(v, "GenomeDataComponent")
    local faction = ComponentGetValue2( genome, "herd_id")
    if v ~= entity_id and genome ~= nil and faction == StringToHerdId("player") then
	curse = true
	if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") or GameHasFlagRun("apotheosis_flesh_boss_stone_converted") then break end
    end
    if EntityGetName(v) == "$animal_boss_wizard" or EntityGetName(v) == "$animal_boss_centipede" then
	threat = true
    end
end

local timercomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[3]
if curse == true then
    ComponentSetValue2( timercomp, "value_bool", true)
else
    ComponentSetValue2( timercomp, "value_bool", false)
end

if ( GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") == false or GameHasFlagRun("apotheosis_flesh_boss_stone_converted") == false ) and threat == true then
    EntitySetComponentsWithTagEnabled(entity_id,"angry_ghost_cooldown",true)
end