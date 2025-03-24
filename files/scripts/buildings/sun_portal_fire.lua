
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)
local r = 60
local targets = EntityGetInRadiusWithTag(x,y,r,"hittable")
for k=1,#targets do
    local comp = EntityGetFirstComponent(targets[k],"DamageModelComponent") or false
    if comp ~= false then
        ComponentSetValue2(comp,"is_on_fire",true)
        ComponentSetValue2(comp,"mIsOnFire",true)
        ComponentSetValue2(comp,"mFireDurationFrames",90)
        ComponentSetValue2(comp,"mFireFramesLeft",90)
    end
end