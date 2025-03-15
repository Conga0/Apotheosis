local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)

local targets = EntityGetInRadiusWithTag(x,y,300,"vegetation")
for k=1,#targets do
    EntityKill(targets[k])
end

local player_count = #(EntityGetInRadiusWithTag(x,y,128,"player_unit") or {})
if player_count > 0 then
    local orb_count = GameGetOrbCountThisRun()
    if orb_count > 10 then
        --Do thing
        --Short animation would be awsum
        local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
        local timer = ComponentGetValue2(comp,"value_int")
        if timer == 0 then
            timer = GameGetFrameNum()
            ComponentSetValue2(comp,"value_int",timer)
            EntitySetComponentsWithTagEnabled( entity_id, "enabled_by_script", true )
            EntityLoad("mods/Apotheosis/files/entities/buildings/lectern_audio.xml",x,y)
            --EntitySetComponentsWithTagEnabled( entity_id, "invincible", false )
        end
        if GameGetFrameNum() > timer + 300 then
            EntitySetComponentsWithTagEnabled( entity_id, "enabled_by_script", false )
            CreateItemActionEntity( "APOTHEOSIS_ORB_KNOWLEDGE", x , y )
            EntityKill(entity_id)
        end

    end
end

