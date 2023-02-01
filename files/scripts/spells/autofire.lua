local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local comp = EntityGetFirstComponentIncludingDisabled( root, "PlatformShooterPlayerComponent" )
local x, y = EntityGetTransform(entity_id)
if (comp ~= nil) then
    local targets = EntityGetInRadiusWithTag(x, y, 200, "enemy") or {}
    if (#targets > 0) then
        ComponentSetValue2( comp, "mForceFireOnNextUpdate", true )
    end
    EntitySetComponentsWithTagEnabled( GetUpdatedEntityID(), "invincible", (#targets > 0))
end
