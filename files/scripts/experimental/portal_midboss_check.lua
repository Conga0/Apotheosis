
local entity_id = GetUpdatedEntityID()
local comps = EntityGetAllComponents(entity_id)
local action = false

if HasFlagPersistent( "apotheosis_portal_midboss" ) then
    action = true
end

--Toggle all component data on/off depending on what's needed
--Red portals may look better here
for k=1,#comps
do local v = comps[k]
    EntitySetComponentIsEnabled(entity_id,v,action)
end

--If the boss has been defeated, stop doing the invincible check
if action == true then
    EntitySetComponentsWithTagEnabled(entity_id,"invincible",false)
else
    EntitySetComponentsWithTagEnabled(entity_id,"invincible",true)
end