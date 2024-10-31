local amount = tonumber(GlobalsGetValue("conga_red_sand_effect_amount"))
local amount2 = tonumber(GlobalsGetValue("conga_red_sand_effect_zoom_amount"))
amount = amount - (math.ceil(amount / 300) or 0)	--Drain all trip effects gradually over the course of 5 seconds
amount2 = amount2 + (math.ceil((amount2 * -1) / 70) or 0)	--Drain zoom effects over the course of 3 seconds
--....don't question my methods... -S

GlobalsSetValue("conga_red_sand_effect_amount", amount)
GlobalsSetValue("conga_red_sand_effect_zoom_amount", amount2)
if amount2 >= 0 then
	GlobalsSetValue("conga_red_sand_effect_zoom_amount", 0)
end
if amount <= 0 then
	GlobalsSetValue("conga_red_sand_effect_amount", 0)
	GlobalsSetValue("conga_red_sand_effect_zoom_amount", 0)
	EntityKill(GetUpdatedEntityID())
end

--GamePrint("amount2: " .. tostring(amount2))
GameSetPostFxParameter("conga_red_sand_effect_amount", amount / 6000, (amount2 / 480) + 1, 0, 0)
