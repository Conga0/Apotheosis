local entity_id = GetUpdatedEntityID()
local children = EntityGetAllChildren(entity_id)
local children_tbl = {}
for k=1,#children do
    x,y = EntityGetTransform(children[k])
    verlet_entity = children[k]

    local child_data = {verlet_entity,x,y}
    table.insert(children_tbl,child_data)
end

--Todo curve
--The first verlet always appears at 0,0?
--But the 2nd verlet goes to a different position when told to

for num=1,#children_tbl do
    local child = children_tbl[num][1]
    local verlet_component = EntityGetFirstComponentIncludingDisabled(child, "VerletPhysicsComponent")
    local verlet_world_joint_component = EntityGetFirstComponentIncludingDisabled(child, "VerletWorldJointComponent")

    local positions = ComponentGetValue2(verlet_component, "positions")
    positions[9] = children_tbl[math.max(1,num - 1)][2]
    positions[10] = children_tbl[math.max(1,num - 1)][3]

    if verlet_world_joint_component then
        ComponentSetValue2(verlet_world_joint_component, "world_position", children_tbl[num][2], children_tbl[num][3])
    end

    ComponentSetValue2(verlet_component, "positions",positions)
end
