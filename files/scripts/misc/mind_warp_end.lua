local amount = tonumber(GlobalsGetValue("conga_mind_warp_effect_amount"))
amount = amount - (math.ceil(amount / 1800) or 0)	--Drain all warp effects gradually over the course of 30 seconds

GameSetPostFxParameter("conga_mind_warp_effect_amount", amount / 200, 0, 0, 0)
GlobalsSetValue("conga_mind_warp_effect_amount", amount)
if amount <= 0 then
	GameSetPostFxParameter("conga_mind_warp_effect_amount", 0, 0, 0, 0)
	GlobalsSetValue("conga_mind_warp_effect_amount", 0)
	EntityKill(GetUpdatedEntityID())
end
