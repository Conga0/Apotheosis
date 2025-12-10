local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local vsc_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local vel_comp = EntityGetFirstComponent(entity_id,"VelocityComponent")
local vel_y = ComponentGetValue2(vel_comp,"mVelocity")

function SplitStringOnCharIntoTable(string, char)
  local list = {}
  for w in (string .. char):gmatch("([^" .. char .. "]*)" .. char) do
      table.insert(list, w)
  end
  return list
end

local origin_data = SplitStringOnCharIntoTable(ComponentGetValue2(vsc_comp, "value_string"),",")

local origin_x = origin_data[1]
local origin_y = origin_data[2]

ComponentSetValue2(vsc_comp,"value_string",table.concat({origin_x,origin_y + (vel_y * 0.05)},","))

local cam_x, cam_y = GameGetCameraPos()

local parallaxFactor = 0.9

local x2 = (cam_x - origin_x) * parallaxFactor
local y2 = (cam_y - origin_y) * parallaxFactor

EntitySetTransform(entity_id, origin_x + x2, origin_y + y2)