local effect_entity = GetUpdatedEntityID()
local player_entity = EntityGetRootEntity(effect_entity)
local x,y = EntityGetTransform(player_entity)

--Gradually increment visuals
local frame = GameGetFrameNum()
local last_frame = tonumber(GlobalsGetValue("apotheosis_trip_red_frame","0"))
if last_frame + 10 < frame then
	amount = 0
	GlobalsSetValue("apotheosis_trip_red_frame",tostring(frame))
	GameTriggerMusicFadeOutAndDequeueAll( 0.5 )
elseif amount > 6000 then
	amount = 6000
	GlobalsSetValue("apotheosis_trip_red_frame",tostring(frame))
else
	amount = amount + 10
	GlobalsSetValue("apotheosis_trip_red_frame",tostring(frame))
end

if last_frame + 10 < frame then
	amount2 = 0
elseif amount2 <= -480 then
	amount2 = -480
else
	amount2 = amount2 - 1
end


--Warp fx (originally 200)
local warpmultiplier = 6000
local warpmultiplier2 = 480
--640
--local mouse_x, mouse_y = InputGetMousePosOnScreen()
--GamePrint("mouse_x: " .. tostring(mouse_x))
--GamePrint("amount2: " .. tostring(amount2))
GameSetPostFxParameter("conga_red_sand_effect_amount", amount / warpmultiplier, (amount2 / warpmultiplier2) + 1, 0, 0)
if amount > 10 then
	GlobalsSetValue("conga_red_sand_effect_amount",amount)
	GlobalsSetValue("conga_red_sand_effect_zoom_amount",amount2)
end
