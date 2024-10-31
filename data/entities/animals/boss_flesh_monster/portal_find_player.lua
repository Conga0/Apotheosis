--dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local cam_x, cam_y, cam_w, cam_h = GameGetCameraBounds()

local range = cam_h / 2

local player_found = false
local players = EntityGetInRadiusWithTag( pos_x, pos_y, range, "player_unit" ) or {}
if players ~= nil then
    player_found = true
end

if (player_found == true) then

    EntityAddComponent(entity_id, "LifetimeComponent", {
	lifetime=7200,
	fade_sprites=1,
    }) 

    EntityAddComponent(entity_id, "LuaComponent", {
	script_source_file="data/entities/animals/boss_flesh_monster/portal_fade.lua",
	execute_every_n_frame=1,
    }) 

    local comp_id = GetUpdatedComponentID()
    EntityRemoveComponent(entity_id,comp_id)

end

    