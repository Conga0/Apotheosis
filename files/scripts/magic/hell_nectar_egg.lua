
local entity_id = GetUpdatedEntityID()
local vcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local timer = ComponentGetValue2(vcomp,"value_int")
timer = timer + 1

ComponentSetValue2(vcomp,"value_int",timer)

for k=1,40 do
    if timer < 1200 then
        if timer == 60 * k then
            GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/heartbeat/create", x, y )
        end
    else
        if timer == 1080 + (30 * k) then
            GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/heartbeat/create", x, y )
        end
    end
end

if timer == 1 then
    local x,y = EntityGetTransform(entity_id)
    GamePlaySound( "data/audio/Desktop/explosion.bank", "explosions/liquid", x, y )
    EntityLoad("data/entities/particles/blood_explosion.xml",x,y)
    EntityLoad("data/entities/particles/blood_explosion.xml",x + 32,y)
    EntityLoad("data/entities/particles/blood_explosion.xml",x - 32,y)
    EntityLoad("data/entities/particles/blood_explosion.xml",x,y + 32)
    EntityLoad("data/entities/particles/blood_explosion.xml",x,y - 32)
    for k=1,8 do
        GamePrint("")
    end
    GamePrintImportant( "$ui_apotheosis_hell_transformation_01")
end

if timer == 500 then
    GamePrintImportant( "$ui_apotheosis_hell_transformation_02")
end

if timer == 1000 then
    GamePrintImportant( "$ui_apotheosis_hell_transformation_03")
end

if timer == 1500 then
    EntityInflictDamage( entity_id, 9999, "DAMAGE_CURSE", "$ui_apotheosis_hell_transformation_hatching", "NONE", 0, 0, 0, x, y, 0 )
    EntityKill(entity_id)
    local x,y = EntityGetTransform(entity_id)
    GamePlaySound( "data/audio/Desktop/explosion.bank", "explosions/liquid", x, y )
    local newbody = EntityLoad("data/entities/animals/worm_end_big_apotheosis.xml",x,y)
    EntityLoad("data/entities/particles/blood_explosion.xml",x,y)
    EntityLoad("data/entities/particles/blood_explosion.xml",x + 32,y)
    EntityLoad("data/entities/particles/blood_explosion.xml",x - 32,y)
    EntityLoad("data/entities/particles/blood_explosion.xml",x,y + 32)
    EntityLoad("data/entities/particles/blood_explosion.xml",x,y - 32)
    ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(newbody,"WormComponent"),"bite_damage",1000)
end
