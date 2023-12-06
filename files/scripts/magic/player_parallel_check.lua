
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
--local worldsize = tonumber((ModTextFileGetContent("data/compatibilitydata/worldsize.txt") or 35840)) --If the player enters West 2 or East 2, this triggers; multiply by 0.5 for West 1 and East 1
--worldsize = worldsize * 0.5
local parallel = GetParallelWorldPosition(pos_x, pos_y)

if parallel ~= 0 and GlobalsGetValue("apotheosis_plane_fail", "0") == "0" and GameHasFlagRun("apotheosis_everything") == false then

    local comps = EntityGetComponentIncludingDisabled(entity_id,"LuaComponent")
    for k=1,#comps
    do local v = comps[k]
        GlobalsSetValue("apotheosis_plane_fail", "1")
        GameScreenshake( 200 )
        --if ComponentGetValue2(v,"script_source_file") == "mods/apotheosis/files/scripts/magic/player_parallel_check.lua" then   --Turn self off
        --    EntitySetComponentIsEnabled(entity_id,v,false)
        --    break
        --end
    end
end

--Scale Vampirism Healing to be percentage based
--100 hp = 1x rate
--200 hp = 2x rate
--50,000 hp = 500x rate
--etc
--Updates every 10 seconds
local hpcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
local hp = ComponentGetValue2(hpcomp,"max_hp")
local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"IngestionComponent")
ComponentSetValue2(comp,"blood_healing_speed",math.max(0.0024 * (hp / 4), 0.0024))
