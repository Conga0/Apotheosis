--Just an attempt to try using "animation_target_offset", looks weird though
local num_limbs = 7

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)

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

  local anim_x, anim_y = ComponentGetValue2(verlet_component, "animation_target_offset")

  local tendril_x = (target_x - x) / 2
  local tendril_y = (target_y - y) / 2

  if verlet_component then
	ComponentSetValue2(verlet_component, "animation_target_offset", tendril_x, tendril_y)
  end
  if verlet_world_joint_component then
	ComponentSetValue2(verlet_world_joint_component, "world_position", x, y - 3)
  end
end