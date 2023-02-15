dofile("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID() 
local player = EntityGetRootEntity( entity_id ) 
local children = EntityGetAllChildren( player ) 
local youcanlive = false
if children ~= nil then
    for k=1,#children
    do child = children[k]
        if EntityGetName( child ) == "inventory_quick" then 
            local inventory_items = EntityGetAllChildren(child) 
            if(inventory_items ~= nil) then 
                for z=1,#inventory_items
                do item = inventory_items[z]
                    if EntityHasTag( item, "wand" ) then 
                        youcanlive = true
                    end 
                end 
            end 
            break 
        end 
    end
end

if youcanlive ~= true then
    EntityKill(entity_id)
end