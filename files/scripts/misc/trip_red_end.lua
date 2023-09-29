local amount = GlobalsGetValue("conga_red_sand_effect_amount")
print(amount)
amount = amount - 0.005
GameSetPostFxParameter("conga_red_sand_effect_amount", amount, 0, 0, 0)
GlobalsSetValue("conga_red_sand_effect_amount", amount)
if amount <= 0 then
	GameSetPostFxParameter("conga_red_sand_effect_amount", 0, 0, 0, 0)
	GlobalsSetValue("conga_red_sand_effect_amount", 0)
	EntityKill(GetUpdatedEntityID())
end
