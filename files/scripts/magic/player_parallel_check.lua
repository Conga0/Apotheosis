
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local worldsize = tonumber((ModTextFileGetContent("data/compatibilitydata/worldsize.txt") or 35840) * 0.5)

if pos_x > worldsize or pos_x < (worldsize * -1) then

    local comps = EntityGetComponentIncludingDisabled(entity_id,"LuaComponent")
    for k=1,#comps
    do local v = comps[k]
        GlobalsSetValue("apotheosis_plane_fail", "1")
        GameScreenshake( 200 )
        if ComponentGetValue2(v,"script_source_file") == "mods/apotheosis/files/scripts/magic/player_parallel_check.lua" then
            EntitySetComponentIsEnabled(entity_id,v,false)
            break
        end
    end
end