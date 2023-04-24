
local entity_id = GetUpdatedEntityID()

local luacomps = EntityGetComponentIncludingDisabled(entity_id,"LuaComponent")
for k=1,#luacomps
do local v = luacomps[k]
    if ComponentGetValue2(v,"script_source_file") == "mods/apotheosis/files/scripts/animals/playerghost/tablet_catch.lua" then
        if ComponentGetValue2(v,"mLastExecutionFrame") + 1 <= GameGetFrameNum() then                    -- if the catch script runs at the exact same frame as the death script, tablets duplicate
            local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"AIAttackComponent")    -- We run a check to make sure they aren't running at the same frame to prevent this
            local path = ComponentGetValue2(comp,"attack_ranged_entity_file")
            if path ~= nil then
                local pos_x, pos_y = EntityGetTransform(entity_id)
                EntityLoad(path,pos_x,pos_y)
            end
        end
        break
    end
end
