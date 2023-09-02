
local entity_id = GetUpdatedEntityID()

if GameHasFlagRun("apotheosis_flesh_boss_released") then
    local children = EntityGetAllChildren(entity_id)
    for k=1,#children do
        EntityKill(children[k])
    end
    EntityKill(entity_id)
else
    local entity_id = GetUpdatedEntityID()
    local x, y = EntityGetTransform(entity_id)
    
    local chains = {}
    local children = EntityGetAllChildren(entity_id) or {}
    for k=1, #children
    do local child = children[k]
      if EntityGetName(child) == "chain_verlet" then
        table.insert(chains, child)
      end
    end
    
    local pos = {{93,93},{-93,93},{93,-93},{-93,-93},{-70,-121},{55,-130},{10,35},{30,30}}
    
    for k=1,#chains
    do local child = chains[k];
    
        local verlet_component = EntityGetFirstComponentIncludingDisabled(child, "VerletPhysicsComponent")
        local verlet_world_joint_component = EntityGetFirstComponentIncludingDisabled(child, "VerletWorldJointComponent")
    
        local positions = ComponentGetValue2(verlet_component, "positions")
    
        --Sets verlet postions based on the pos table
        positions[47] = x + pos[k][1]
        positions[48] = y + pos[k][2]
        if verlet_component then
            ComponentSetValue2(verlet_component, "positions", positions)
        end
        if verlet_world_joint_component then
            if k == 7 then
                ComponentSetValue2(verlet_world_joint_component, "world_position", x - 30, y + 30)
            elseif k == 8 then
                ComponentSetValue2(verlet_world_joint_component, "world_position", x - 5, y + 35)
            else
                ComponentSetValue2(verlet_world_joint_component, "world_position", x + (pos[k][1] * 0.1), y + (pos[k][2] * 0.1))
            end
        end
    end
end

--Conga: There's definitely a more optimised way to do this, but I'm pushing for the mod to be done
