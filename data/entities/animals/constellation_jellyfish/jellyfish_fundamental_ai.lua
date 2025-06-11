local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local worldEntity = GameGetWorldStateEntity()
local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")
local time = ComponentGetValue2(comp,"time")
local skylight = GameGetSkyVisibility( pos_x, pos_y )

local vsc_comps = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local generic_ai_data = vsc_comps[1]
local star_barrage_data = vsc_comps[2]
local dmgcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
local hp = ComponentGetValue2(dmgcomp,"hp")
local hp_max = ComponentGetValue2(dmgcomp,"max_hp")

--Outside of this range is day time for Noita
--If it's daytime then vanish the jellyfish until night
--The jellyfish need clear visibility of the sun to soak in it's radiance
if (time < 0.55 or time > 0.70) and (pos_y < 500 or skylight > 0.5) then
    EntityKill(entity_id)
    if EntityHasTag(entity_id,"minion") == false then
        EntityLoad("data/entities/animals/AI/constellation_jellyfish_day.xml",pos_x,pos_y)
    end
end

--Enables aggressive AI if the jellyfish is damaged below 95% hp
if hp < (hp_max * 0.95) and ComponentGetValue2(generic_ai_data,"value_bool") == false then
    ComponentSetValue2(generic_ai_data,"value_bool",true)
    EntitySetComponentsWithTagEnabled( entity_id, "invincible", true )

    ComponentSetValue2(dmgcomp,"hp",hp_max)
    EntityAddTag(entity_id,"miniboss")

    local paicomp = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsAIComponent")
    ComponentSetValue2(paicomp,"target_vec_max_len",24)
    ComponentSetValue2(paicomp,"force_coeff",16.0)
    ComponentSetValue2(paicomp,"force_max",200)
end

--Aggressive AI
if ComponentGetValue2(generic_ai_data,"value_bool") == true then

    --Summon other jellyfish when near death
    if hp < (hp_max * 0.10) and ComponentGetValue2(generic_ai_data,"value_float") < 1 then
        ComponentSetValue2(generic_ai_data,"value_float",1.0)

        --Summon ring of particles around the jellyfish, grant it 5 seconds of immunity, restore health to 30% from 10% & enable death
        ----Note: When spoop's done with his work on the audio bank, make this thing SCREAM
        EntityLoad("data/entities/animals/constellation_jellyfish/jellyfish_backup_scream.xml",pos_x,pos_y)
        local c = EntityLoad("mods/Apotheosis/files/entities/misc/effect_protection_all_true.xml",pos_x,pos_y)
        EntityAddChild(entity_id,c)
        ComponentSetValue2(dmgcomp,"hp",ComponentGetValue2(dmgcomp,"max_hp") * 0.30)
        ComponentSetValue2(dmgcomp,"kill_now",true)

        local points = 8
        local radius = 128
        local circle = math.pi * 2
        local inc = circle / points
        for k=1,points do
            local angle = inc * k
            local target_x = pos_x + math.cos( angle ) * radius
            local target_y = pos_y + 0 - math.sin( angle ) * radius

            local backup = EntityLoad("data/entities/animals/constellation_jellyfish/jellyfish_backup_summon.xml",target_x,target_y)
            --EntityLoad("mods/Apotheosis/debug/static_image.xml",target_x,target_y)
        end
    end
end