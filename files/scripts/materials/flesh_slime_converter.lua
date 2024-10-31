
local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local cam_x, cam_y, cam_w, cam_h = GameGetCameraBounds()
local radius = math.floor((cam_w / 4) * 6)
local player_id = EntityGetInRadiusWithTag(x,y,radius,"player_unit") or {}

local converters = EntityGetInRadiusWithTag(x,y,10,"acid") or {}
local converter_found = 0
for cp=1,#converters do
    if entity_id ~= converters[cp] and EntityGetName(converters[cp]) == "flesh_converter" then
	converter_found = converter_found + 1
    end
end

if converter_found > 2 then
      EntityKill(entity_id)
elseif #player_id < 1 then
    EntityAddComponent(entity_id, "MagicConvertMaterialComponent", {
      kill_when_finished=true,
      from_material=CellFactory_GetType("apotheosis_meat_heretic"),
      steps_per_frame=1,
      to_material=CellFactory_GetType("apotheosis_corrupt_flesh_slime"),
      clean_stains=false,
      is_circle=true,
      radius=10,
      convert_same_material=false,
    })
end
