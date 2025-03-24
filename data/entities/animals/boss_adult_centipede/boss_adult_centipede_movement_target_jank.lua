local entity_id = GetUpdatedEntityID()

EntityAddTag(entity_id,"movement_target")
print("pls")

EntityAddComponent(entity_id, "PhysicsBodyComponent", {
	uid=1,
	allow_sleep=1,
	angular_damping=0,
	fixed_rotation=0,
	is_bullet=1,
	linear_damping=0,
	auto_clean=0,
	on_death_leave_physics_body=1,
	hax_fix_going_through_ground=1,
}) 

EntityAddComponent(entity_id, "PhysicsImageShapeComponent", {
	body_id=1,
	centered=1,
	image_file="data/items_gfx/musicstone.png",
	material="gem_box2d_turquoise",
}) 

EntityAddComponent(entity_id, "LuaComponent", {
	script_source_file="data/entities/animals/boss_adult_centipede/boss_adult_centipede_movement_target_kill.lua",
	execute_every_n_frame=2,
	execute_on_added=0,
	remove_after_executed=1,
}) 