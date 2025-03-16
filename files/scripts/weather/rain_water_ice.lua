local entity_id = GetUpdatedEntityID()
local lifetime_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "LifetimeComponent")
local death_frame = ComponentGetValue2(lifetime_comp, "kill_frame") 

local world_state = GameGetWorldStateEntity()
local world_state_comp = EntityGetFirstComponentIncludingDisabled(world_state, "WorldStateComponent")

if world_state_comp ~= nil then
	if death_frame - GameGetFrameNum() <= 60 then
		ComponentSetValue2(world_state_comp, "rain_target_extra", 0)
	else
		ComponentSetValue2(world_state_comp, "rain_target_extra", 1)
	end
end

local player_id = EntityGetWithTag("player_unit")[1] or EntityGetWithTag("polymorphed_player")[1]
if not player_id then return end

local x, y = EntityGetTransform(player_id)
local visibility = GameGetSkyVisibility(x, y)
if visibility < 1 then return end


local emitter_e = EntityCreateNew("apotheosis_fake_rain")
EntityAddComponent2(emitter_e, "ParticleEmitterComponent", {
	emitted_material_name = "water_ice",
	create_real_particles = true,
	x_pos_offset_min = -600,
	x_pos_offset_max = 600,
	y_pos_offset_min = -100,
	y_pos_offset_max = 100,
	draw_as_long = true,
	y_vel_min = 1000,
	y_vel_max = 1000,
	count_min = 1,
	count_max = 5,
	emission_interval_min_frames = 10,
	emission_interval_max_frames = 30,
})
EntityAddComponent2(emitter_e, "LifetimeComponent", {
	lifetime = 30,
})
EntitySetTransform(emitter_e, x, y - 500)
