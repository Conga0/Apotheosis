local entity_id = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ProjectileComponent")
local last_frame = ComponentGetValue2(projcomp,"mLastFrameDamaged") --Extol's Idea
--GamePrint("Last frame hit was " .. last_frame)

if last_frame > 0 then
    --GamePrint("Hit Target")
    local comps = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")
    for k=1,#comps
    do v = comps[k]
        if ComponentGetValue2(v,"name") == "apotheosis_piercing_count" then
            local piercingcount = ComponentGetValue2(v,"value_int")
            if piercingcount == 1 then
                ComponentSetValue2(projcomp,"lifetime",1)
            elseif piercingcount >= 50 then
                ComponentSetValue2(v,"value_int",-1)
                --ComponentSetValue2(v,"value_int",30000)
            else
                ComponentSetValue2(v,"value_int",piercingcount - 1)
            end
        end
    end
end
