
local worldEntity = GameGetWorldStateEntity()
local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")
local time = ComponentGetValue2(comp,"time")
local goal_time = 0.0

function lerp(a, b, weight)
	return a * weight + b * (1 - weight)
end

if GlobalsGetValue("apotheosis_spellbook_night","0") == "1" then
    goal_time = 0.60
elseif GlobalsGetValue("apotheosis_spellbook_light","0") == "1" then
    goal_time = 0.30
end


local new_time = lerp(time,goal_time,0.99)
ComponentSetValue2(comp,"time",new_time)
 