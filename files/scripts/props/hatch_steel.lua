
function toggle_background(door)
  local bg = EntityGetFirstComponentIncludingDisabled(door, "SpriteComponent", "door_open_sprite")
  local enabled = ComponentGetIsEnabled(bg)

  EntitySetComponentIsEnabled(door, bg, not enabled)
end

function toggle_body(door)
  local body = EntityGetFirstComponentIncludingDisabled(door, "PhysicsBodyComponent")
  local enabled = ComponentGetIsEnabled(body)

  EntitySetComponentIsEnabled(door, body, not enabled)

  -- TODO: Shouldn't these be added only when the body is enabled?
  EntityAddComponent(door, "PhysicsJointComponent", {
    ["nail_to_wall"] = 1, ["breakable"] = 1, ["grid_joint"] = 1, ["pos_x"] = 0, ["pos_y"] = 3
  })
  EntityAddComponent(door, "PhysicsJointComponent", {
    ["nail_to_wall"] = 1, ["breakable"] = 1, ["grid_joint"] = 1, ["pos_x"] = 23, ["pos_y"] = 3
  })
end

function interacting(interacter, door, door_name)
  toggle_background(door)
  toggle_body(door)
end



-- Disable interacting when the door is shot, damaged anything
function physics_body_modified( is_destroyed )
  local door = GetUpdatedEntityID()
  local interaction = EntityGetFirstComponentIncludingDisabled(door, "InteractableComponent")
  local bg_sprite = EntityGetFirstComponentIncludingDisabled(door, "SpriteComponent", "door_bg_sprite")

  EntityRemoveComponent(door, interaction)
  EntityRemoveComponent(door, bg_sprite)
end

