
local entity_id    = GetUpdatedEntityID()
local player_id = EntityGetRootEntity(entity_id)

local teledisabled = false

--Check if player is still teleport nullified
local children = EntityGetAllChildren(player_id)
for k=1,#children
do local v = children[k]
    if EntityGetName(v) == "apotheosis_teleport_cancel" and v ~= entity_id then
        teledisabled = true
    end
end

--If the player is no longer nullified, reenable teleportation perks & swapper mage swapping
if teledisabled == false then
    local pos_x, pos_y = EntityGetTransform(player_id)
    local c = EntityLoad("mods/apotheosis/files/entities/misc/effect_teleport_cancel_remove.xml", pos_x, pos_y)
    EntityAddChild(player_id,c)
end

--Remove child as it's no longer needed
EntityKill(entity_id)
