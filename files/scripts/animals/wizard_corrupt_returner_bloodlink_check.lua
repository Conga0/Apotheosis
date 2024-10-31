local entity_id = GetUpdatedEntityID()

local bloodlinked = false
local children = EntityGetAllChildren( entity_id )
if ( children ~= nil ) then
	for a,b in ipairs( children ) do
		local effectname = EntityGetName( b )

		if ( effectname == "bloodlink" ) then
			bloodlinked = true
			break
		end
	end
end

if bloodlinked == false then
	local animation_length = 60

	--Disable movement
	local velocity_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VelocityComponent")
	local characterdata_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "CharacterDataComponent")
	EntitySetComponentIsEnabled(entity_id, velocity_comp, false)
	EntitySetComponentIsEnabled(entity_id, characterdata_comp, false)

	local sprite_comps = EntityGetComponent(entity_id, "SpriteComponent") or {}
	for i, comp in ipairs(sprite_comps) do
		if ComponentHasTag( comp, "enable_when_player_seen" ) or ComponentHasTag( comp, "disabled_by_liquid" ) then
			ComponentRemoveTag(comp, "character" )
			ComponentSetValue2(comp, "rect_animation", "unbloodlink")
			ComponentSetValue2(comp, "next_rect_animation", "stand")
		end
	end

	local audioloopcomps = EntityGetComponentIncludingDisabled(entity_id, "AudioLoopComponent") or {}
	for i = 1, #audioloopcomps do
		if ComponentGetValue2(audioloopcomps[i], "event_name") == "player_projectiles/meteor/loop" then
			EntityRemoveComponent(entity_id, audioloopcomps[i])
		end
	end

	--MMmm animatioonnnzzzz
	EntityAddComponent(entity_id, "LuaComponent", {
		script_source_file="mods/Apotheosis/files/scripts/animals/wizard_corrupt_returner_unbloodlink_end.lua",
		execute_every_n_frame=animation_length,
		execute_on_added=0,
		remove_after_executed=1
	}) 

	local comp_id = GetUpdatedComponentID()
	EntityRemoveComponent(entity_id, comp_id)
end