dofile("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

--This code is stolen from the first Noita mod I ever made... How fitting.
--What once was the beginning, now is the end.
--Finem respice
--Thankyou for playing everyone <3

local plyChildEnt = EntityGetAllChildren( entity_id )
if ( plyChildEnt ~= nil ) then
    for i,childEntity in ipairs( plyChildEnt ) do
        if ( EntityGetName( childEntity ) == "cape" ) then
            
            EntityKill( childEntity )

            --Adds new cape
            local cid = EntityLoad( "data/apotheosis_gfx/golden_cape.xml",  pos_x, pos_y )
            EntityAddChild( entity_id, cid )
            break
        end
    end
end