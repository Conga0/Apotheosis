
local extract = dofile_once("mods/Apotheosis/files/scripts/misc/proj_data.lua")
local entity_id = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ProjectileComponent")

local gun_data = extract(projcomp, {2})

function SplitStringOnCharIntoTable(string, char)
    local list = {}
    for w in (string .. char):gmatch("([^" .. char .. "]*)" .. char) do
        table.insert(list, w)
    end
    return list
end

local gun_info = SplitStringOnCharIntoTable(gun_data,string.char(255))
--#gun_info is 65
--print(gun_info[62])
for k=1,#gun_info do
    print(k .. ": " .. gun_info[k])
end
print("------------------------------------------------------")
print("62: " .. gun_info[62])

local vscomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
ComponentSetValue2(vscomp,"value_string",gun_info[62])