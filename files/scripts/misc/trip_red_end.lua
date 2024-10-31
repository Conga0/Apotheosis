local amount = GlobalsGetValue("conga_red_sand_effect_amount")
amount = amount - (math.ceil(amount / 1800) or 0)	--Drain all trip effects gradually over the course of 40 seconds

GameSetPostFxParameter("conga_red_sand_effect_amount", amount / 6000, 1, 0, 0)
GlobalsSetValue("conga_red_sand_effect_amount", amount)
if amount <= 0 then
	GameSetPostFxParameter("conga_red_sand_effect_amount", 0, 0, 0, 0)
	GlobalsSetValue("conga_red_sand_effect_amount", 0)
	EntityKill(GetUpdatedEntityID())
end
