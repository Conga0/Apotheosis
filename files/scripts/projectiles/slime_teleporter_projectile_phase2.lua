
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local start_x, start_y

local vsccomp = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")
for k=1,#vsccomp
do local v = vsccomp[k]
    if ComponentGetValue2(v,"name") == "teleport_data" then
        start_x = ComponentGetValue2(v,"value_int",pos_x)
        start_y = ComponentGetValue2(v,"value_float",pos_y)
        break
    end
end

--If the portals are 140 pixels or closer to each other, stop the process and cancel operations
if (math.abs(start_y - pos_y) + math.abs(start_x - pos_x)) <= 140 then
    return
end


local start = EntityLoad("mods/apotheosis/files/entities/projectiles/slime_teleporter_portal.xml",start_x,start_y)
local finish = EntityLoad("mods/apotheosis/files/entities/projectiles/slime_teleporter_portal.xml",pos_x,pos_y)

EntityAddComponent2(
    start,
    "VariableStorageComponent",
    {
        name="teleport_data",
        value_int=finish,
    }
)

EntityAddComponent2(
    start,
    "LuaComponent",
    {
        execute_on_added = false,
        script_source_file = "mods/apotheosis/files/scripts/projectiles/slime_teleporter_portal_transmit.lua",
        execute_every_n_frame = 15,
        remove_after_executed = false,
        execute_times=-1,
    }
)

EntityAddComponent2(
    start,
    "LuaComponent",
    {
        execute_on_added = false,
        script_source_file = "mods/apotheosis/files/scripts/projectiles/slime_teleporter_portal_suction.lua",
        execute_every_n_frame = 1,
        remove_after_executed = false,
        execute_times=45,
    }
)
