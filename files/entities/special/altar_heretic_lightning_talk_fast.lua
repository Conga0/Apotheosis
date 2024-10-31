dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

if not GameHasFlagRun("heretic_near_death") then
    GameAddFlagRun("heretic_near_death")

    local heretic_eyes = EntityGetInRadiusWithTag(pos_x,pos_y,200,"apotheosis_heretic")
    for k=1,#heretic_eyes
    do local v = heretic_eyes[k]
	local comp = EntityGetFirstComponentIncludingDisabled(v,"PhysicsImageShapeComponent")
	if ComponentGetValue2(comp,"image_file") == "mods/apotheosis/files/items_gfx/heretical_eye.png" and EntityGetParent(v) == 0 then
	local luacomps = EntityGetComponent(v, "LuaComponent") or {}
	for i = 1, #luacomps do
    	    if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/apotheosis/files/scripts/items/heretical_eye_dialogue.lua" then
    		ComponentSetValue2( luacomps[i], "execute_every_n_frame", 10 )
    		ComponentSetValue2( luacomps[i], "mNextExecutionTime", GameGetFrameNum() )
    	    end
    	    if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/apotheosis/files/scripts/items/heretical_eye_dialogue_quiet.lua" then
    		EntityRemoveComponent( heretic_id, luacomps[i] )
    	    end
	end
	EntityAddComponent2(heretic_id, "LuaComponent", {
	    _tags= "enabled_in_world, enabled_in_hand, enabled_in_inventory, graham_speech_quiet",
	    script_source_file="mods/apotheosis/files/scripts/items/heretical_eye_dialogue_quiet.lua",
	    execute_every_n_frame=5,
	}) 
	end
    end
end