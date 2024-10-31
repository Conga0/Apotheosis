local effect_entity = GetUpdatedEntityID()
local player_entity = EntityGetRootEntity(effect_entity)
local stomach = EntityGetFirstComponent(player_entity, "StatusEffectDataComponent")
local x,y = EntityGetTransform(player_entity)
if stomach == nil then return end
local red_sand_num
for k, v in ipairs(ComponentGetValue2(stomach, "ingestion_effect_causes")) do
	if v == CellFactory_GetType("apotheosis_redstone") then
		red_sand_num = k
	end
end
if red_sand_num == nil then return end

local stomachamount = ComponentGetValue2(stomach, "ingestion_effects")[red_sand_num]

--Gradually increment visuals
local frame = GameGetFrameNum()
local last_frame = tonumber(GlobalsGetValue("apotheosis_trip_red_frame","0"))
if last_frame + 10 < frame then
	amount = 0
	GlobalsSetValue("apotheosis_trip_red_frame",tostring(frame))
	GameTriggerMusicFadeOutAndDequeueAll( 0.5 )
	GameRemoveFlagRun("apotheosis_tripping_balls_red")
elseif stomachamount <= 1 and not GameHasFlagRun("apotheosis_tripping_balls_red") then
	amount = 0
	GameSetPostFxParameter("conga_red_sand_effect_amount", 0, 0, 0, 0)
	GlobalsSetValue("conga_red_sand_effect_amount",0)
elseif stomachamount < 30 then
	amount = amount - ((math.ceil(amount / 1600) or 0) +1)	--Drain all trip effects gradually over the course of 30 seconds
	GlobalsSetValue("apotheosis_trip_red_frame",tostring(frame))
elseif amount > 6000 then
	amount = 6000
	GlobalsSetValue("apotheosis_trip_red_frame",tostring(frame))
else
	amount = amount + 1
	GlobalsSetValue("apotheosis_trip_red_frame",tostring(frame))
end


--Trip fx (originally 200)
local tripmultiplier = 6000
GameSetPostFxParameter("conga_red_sand_effect_amount", amount / tripmultiplier, 1, 0, 0)
if amount > 600 then
	GlobalsSetValue("conga_red_sand_effect_amount",amount)
end
