local effect_entity = GetUpdatedEntityID()
local player_entity = EntityGetRootEntity(effect_entity)
local stomach = EntityGetFirstComponent(player_entity, "StatusEffectDataComponent")
if stomach == nil then return end
local red_sand_num
for k, v in ipairs(ComponentGetValue2(stomach, "ingestion_effect_causes")) do
	if v == CellFactory_GetType("apotheosis_redstone") then
		red_sand_num = k
	end
end
if red_sand_num == nil then return end
local amount = ComponentGetValue2(stomach, "ingestion_effects")[red_sand_num]
GameSetPostFxParameter("conga_red_sand_effect_amount", amount / 200, 0, 0, 0)
if amount > 100 then
	GlobalsSetValue("conga_red_sand_effect_amount",amount / 200)
end