    
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

-- Iterate over the positions table with a step of 2

local targets = EntityGetInRadiusWithTag( pos_x, pos_y, 30, "player_unit" ) or {}
for k=1,#targets do
    local children = EntityGetAllChildren(targets[k]) or {}
    local found = false
    for l=1,#children do
        if EntityGetName(children[l]) == "constellation_jellyfish_teleport" then
            found = true
            local vscomp = EntityGetFirstComponentIncludingDisabled(children[l],"VariableStorageComponent")
            ComponentSetValue2(vscomp,"value_float",0.05 + ComponentGetValue2(vscomp,"value_float"))
            break
        end
    end
    if found == false then
        --Return the player to where they left off
        local child = EntityLoad("data/entities/animals/constellation_jellyfish/jellyfish_teleport_return.xml")
        EntityAddChild(targets[k],child)
    end
end
