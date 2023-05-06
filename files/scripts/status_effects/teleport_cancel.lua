
local entity_id    = GetUpdatedEntityID()
local player_id = EntityGetRootEntity(entity_id)

local TeleTest = GameGetGameEffectCount( player_id, "TELEPORTATION" )

local UnstableTeleTest = GameGetGameEffectCount( player_id, "UNSTABLE_TELEPORTATION" )

--Disable Teleportitis
if TeleTest ~= 0 then
    local comp = GameGetGameEffect( player_id, "TELEPORTATION" )
    if comp ~= 0 then
        ComponentSetValue2( comp, "effect", "NONE")
    end
end

--Disable Unstable Teleportitis
if UnstableTeleTest ~= 0 then
    local comp = GameGetGameEffect( player_id, "UNSTABLE_TELEPORTATION" )
    if comp ~= 0 then
        ComponentSetValue2( comp, "effect", "NONE")
    end
end
