local entity_id = GetUpdatedEntityID()
local parent_id = EntityGetParent(entity_id)
local pos_x,pos_y = EntityGetTransform(entity_id)
vsc = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
teleported = ComponentGetValue2(vsc,"value_bool")
phaseout_stage = ComponentGetValue2(vsc,"value_float")

frame = GameGetFrameNum()
init_frame = ComponentGetValue2(vsc,"value_int")

function printboth(text)
    print(text)
    GamePrint(text)
end

if init_frame == 0 then
    ComponentSetValue2(vsc,"value_int",frame)
    init_frame = frame
end

function stage1()
    if frame > init_frame + 60 then
        if ComponentGetValue2(vsc,"value_float") > 0.50 then
            ComponentSetValue2(vsc,"value_float",100.0)
            ComponentSetValue2(vsc,"value_int",frame)
            init_frame = frame
            EntitySetComponentsWithTagEnabled( entity_id, "invincible", true )
        else
            EntityKill(entity_id)
        end
    end
end

function stage2()
    if frame > init_frame + 150 then
        if ComponentGetValue2(vsc,"value_float") > 101.40 then
            ComponentSetValue2(vsc,"value_float",200.0)
            ComponentSetValue2(vsc,"value_int",frame)
            init_frame = frame
            local child = EntityLoad("data/entities/animals/constellation_jellyfish/jellyfish_teleport_audio.xml")
            EntityAddChild(parent_id,child)
            EntitySetComponentsWithTagEnabled( entity_id, "invincible", false )
        else
            EntityKill(entity_id)
        end
    end
end

function stage3()
    if teleported then
        GameSetPostFxParameter("conga_constellation_transition_amount", math.min(1,2.30 - ((frame - init_frame) / 300)), 0, 0, 0)
    else
        GameSetPostFxParameter("conga_constellation_transition_amount", ((frame - init_frame) / 300) * (frame - init_frame) / 300, 0, 0, 0)
    end

    if frame == init_frame + 300 then
        ComponentSetValue2(vsc,"value_bool",true)
        if phaseout_stage > 202 then
            EntitySetTransform(parent_id,-20750,-30350)
            local c = EntityLoad("mods/Apotheosis/files/entities/misc/effect_protection_all_true.xml",pos_x,pos_y)
            EntityAddChild(parent_id,c)
            GlobalsSetValue("apotheosis_jellyfish_lastpos",table.concat({pos_x,",",pos_y}))
        else
            ComponentSetValue2(vsc,"value_int",init_frame - 190)
        end
    end

    if frame >= init_frame + 690 then
        EntityKill(entity_id)
        GameSetPostFxParameter("conga_constellation_transition_amount", 0, 0, 0, 0)
    end
end

if phaseout_stage < 100.0 then
    stage1()
elseif phaseout_stage < 200.0 then
    stage2()
else
    stage3()
end
