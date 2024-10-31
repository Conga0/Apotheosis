dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local convertlist = {
    "brimstone",
    "stonestone",
    "thunderstone",
    "waterstone",
    "poopstone",
    "seed_a",
    "seed_b",
}

-- abort if conversion already in progress
if #EntityGetInRadiusWithTag(pos_x, pos_y, 10, "forge_item_convert") > 0 then return end

for _,id in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 60, "item_pickup")) do
    for k=1, #convertlist
    do local v = convertlist[k];
        if EntityHasTag(id,v) and not EntityHasTag(id,"forge_item_convert") then
            -- make sure item is not carried in inventory or wand
            if EntityGetRootEntity(id) == id then
                -- start conversion
                local c = EntityLoad("mods/apotheosis/files/entities/misc/perk_creation_child.xml", pos_x, pos_y)
                EntityAddChild(id,c)
                --EntityAddTag(id,"forge_item_convert")

		--Restarts the end timer
		local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
		for i = 1, #luacomps do
		    if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/apotheosis/files/scripts/buildings/perk_creation_end.lua" then
			EntityRemoveComponent( entity_id, luacomps[i] )

                	EntityAddComponent2(
                	    entity_id,
                	    "LuaComponent",
                	    {
                	        execute_on_added = false,
                	        script_source_file = "mods/apotheosis/files/scripts/buildings/perk_creation_end.lua",
                	        execute_every_n_frame = 144,
                	        remove_after_executed = true,
                	        execute_times = 1
                	    }
                	)
			break
 		    end
		end

                --Failsafe incase tag removal on picking up item fails
                --[[
                EntityAddComponent2(
                    id,
                    "LuaComponent",
                    {
                        execute_on_added = false,
                        script_source_file = "mods/apotheosis/files/scripts/misc/perk_creation_failsafe.lua",
                        execute_every_n_frame = 120,
                        remove_after_executed = true,
                        execute_times=1
                    }
                )
                ]]--

                GamePlaySound( "data/audio/Desktop/projectiles.snd", "projectiles/magic/create", pos_x, pos_y )
                return
            end
        end
    end
end
