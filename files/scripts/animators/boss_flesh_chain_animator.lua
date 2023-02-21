local tentacles = {}
local children = EntityGetAllChildren(entity_id) or {}
for k=1, #children
do local child = children[k];
  if EntityGetName(child) == "chain_verlet" then
    table.insert(tentacles, child)
  end
end

for k=1, #tentacles
do local child = tentacles[k];

  local verlet_component = EntityGetFirstComponentIncludingDisabled(child, "VerletPhysicsComponent")
  local verlet_world_joint_component = EntityGetFirstComponentIncludingDisabled(child, "VerletWorldJointComponent")

  local positions = ComponentGetValue2(verlet_component, "positions")
  positions[29] = x + (8 * k)
  positions[30] = y + (8 * k)
  if verlet_component then
	ComponentSetValue2(verlet_component, "positions", positions)
  end
  if verlet_world_joint_component then
	ComponentSetValue2(verlet_world_joint_component, "world_position", x, y - 3)
  end
end