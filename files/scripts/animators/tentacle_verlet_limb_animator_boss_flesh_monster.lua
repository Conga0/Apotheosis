dofile_once("data/scripts/lib/utilities.lua")

local num_limbs = 12

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local last_direction = GetValueNumber("last_direction", 0)

local tentacles = {}
local target = {}
local children = EntityGetAllChildren(entity_id) or {}
for k=1, #children
do local child = children[k];
  if EntityGetName(child) == "tentacle_verlet" then
    table.insert(tentacles, child)
  end
  if EntityGetName(child) == "tentacle_limb_leg" then
    table.insert(target, child)
  end
end

for k=1, #tentacles
do local child = tentacles[k];

  local verlet_component = EntityGetFirstComponentIncludingDisabled(child, "VerletPhysicsComponent")
  local verlet_world_joint_component = EntityGetFirstComponentIncludingDisabled(child, "VerletWorldJointComponent")

  local comp = EntityGetComponentIncludingDisabled(target[k],"IKLimbComponent")[1]
  local target_x, target_y = ComponentGetValue2(comp, "end_position")

  local positions = ComponentGetValue2(verlet_component, "positions")
  positions[29] = target_x
  positions[30] = target_y
  if verlet_component then
	ComponentSetValue2(verlet_component, "positions", positions)
  end
  if verlet_world_joint_component then
	ComponentSetValue2(verlet_world_joint_component, "world_position", x, y - 3)
  end
end