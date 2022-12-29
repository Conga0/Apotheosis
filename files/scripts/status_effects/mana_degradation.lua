 --Written by Squirrelly

    dofile("data/scripts/lib/utilities.lua")
    local entity_id = GetUpdatedEntityID() 
    local player = EntityGetRootEntity( entity_id ) 
    local children = EntityGetAllChildren( player ) 
    for i, child in ipairs( children ) do 
        if EntityGetName( child ) == "inventory_quick" then 
        local inventory_items = EntityGetAllChildren(child) 
            if(inventory_items ~= nil) then 
                for i, item in ipairs(inventory_items) do 
                    if EntityHasTag( item, "wand" ) then 
                        local ac_id = EntityGetFirstComponentIncludingDisabled( item, "AbilityComponent" )   
                        local mana = ComponentGetValue2( ac_id, "mana" )  
                        local mana_charge_speed = ComponentGetValue2( ac_id, "mana_charge_speed" ) 
                        ComponentSetValue2( ac_id, "mana", math.max( mana - (mana_charge_speed * 1.5 / 45), 0 ) ) 
                    end 
                end 
            end 
            break 
        end 
    end

    --ComponentSetValue2( ac_id, "mana", math.max( mana - (mana_charge_speed / 45), 0 ) ) drains mana at x1 the wand's recharge rate
    --ComponentSetValue2( ac_id, "mana", math.max( mana - (mana_charge_speed * 2 / 45), 0 ) )   drains mana at x2 the wand's recharge rate
    --ComponentSetValue2( ac_id, "mana", math.max( mana - (mana_charge_speed * 10 / 45), 0 ) )   drains mana at x10 the wand's recharge rate