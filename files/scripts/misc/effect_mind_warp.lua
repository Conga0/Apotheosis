local effect_entity = GetUpdatedEntityID()
local player_entity = EntityGetRootEntity(effect_entity)
local x,y = EntityGetTransform(player_entity)

--Doesn't work?
if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") then
	EntityKill(effect_entity)
end

--Gradually increment visuals
local frame = GameGetFrameNum()
local last_frame = tonumber(GlobalsGetValue("apotheosis_mind_warp_frame","0"))
if last_frame + 10 < frame then
	amount = 0
	GlobalsSetValue("apotheosis_mind_warp_frame",tostring(frame))
	GameTriggerMusicFadeOutAndDequeueAll( 0.5 )
elseif amount > 200 then
	amount = 200
	GlobalsSetValue("apotheosis_mind_warp_frame",tostring(frame))
else
	amount = amount + 1
	GlobalsSetValue("apotheosis_mind_warp_frame",tostring(frame))
end


--Warp fx (originally 200)
local warpmultiplier = 200
GameSetPostFxParameter("conga_mind_warp_effect_amount", amount / warpmultiplier, 0, 0, 0)
if amount > 20 then
	GlobalsSetValue("conga_mind_warp_effect_amount",amount)
end
