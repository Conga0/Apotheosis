--Used to be used for Conjurer spawning!
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

if not GameHasFlagRun("apotheosis_flesh_boss_released") then
	GameAddFlagRun("apotheosis_flesh_boss_released")
end

local eid = EntityLoad("data/entities/animals/boss_flesh_monster/phase3/boss_flesh_monster.xml", pos_x, pos_y)

local incarncomp = EntityGetComponentIncludingDisabled( eid, "VariableStorageComponent" )[2]
if tonumber(GlobalsGetValue("HERETIC_COWARDLY")) ~= nil then
ComponentSetValue2( incarncomp, "value_int", tonumber(GlobalsGetValue("HERETIC_COWARDLY")))
end

EntityKill(entity_id)
