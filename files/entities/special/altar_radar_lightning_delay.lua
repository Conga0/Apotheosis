--Mmmyes the complexities...
local delay = tonumber(GlobalsGetValue("HERETIC_HINT_DELAY", tostring(GameGetFrameNum()-1) ))
if (delay - GameGetFrameNum()) > 0 then
	local entity_id = GetUpdatedEntityID()
	EntityKill(entity_id)
end