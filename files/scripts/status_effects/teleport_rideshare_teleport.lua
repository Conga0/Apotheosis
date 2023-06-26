
function teleported( from_x, from_y, to_x, to_y, wasportal )

    local entity_id = GetUpdatedEntityID()
    local targets = EntityGetInRadiusWithTag(from_x, from_y, 128,"teleportable_NOT")
    for k=1,#targets
    do local v = targets[k]
        if EntityHasTag(v,"player_unit") == false then
            local x,y = EntityGetTransform(v)
            local target_x, target_y = (to_x + (x - from_x))
            local target_y = (to_y + (y - from_y))

            local did_hit, r_x, r_y = Raytrace(to_x,to_y,target_x,target_y)
            if did_hit then
                --Move all creatures over to the new location if a solid wall was in the way
                EntitySetTransform(v,r_x, r_y)
            else
                --Move all creatures over to the new location if it's open air
                EntitySetTransform(v,target_x, target_y)
            end
        end
    end
end