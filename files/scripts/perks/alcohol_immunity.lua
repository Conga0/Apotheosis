
local entity_id    = GetUpdatedEntityID()
local player_id = EntityGetRootEntity(entity_id)

local DrunkTest = GameGetGameEffectCount( player_id, "DRUNK" )
if DrunkTest == 0 then
    return
end

--GamePrint("player drunbk")
local comp = GameGetGameEffect( player_id, "DRUNK" )
if comp ~= 0 then
    ComponentSetValue2( comp, "effect", "NONE")
end

