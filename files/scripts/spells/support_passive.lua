dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")
dofile_once("data/scripts/status_effects/status_list.lua")
local entity_id = GetUpdatedEntityID()
local player_id = EntityGetRootEntity(entity_id)

local vsc_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local next_trueform_frame = ComponentGetValue2(vsc_comp,"value_int")
local trueform_cooldown = 3600
local current_frame = GameGetFrameNum()
local harmful_effect_found = false

function visualEffects(pos_x,pos_y)
    local how_many = 12
    local angle_inc = ( 2 * 3.14159 ) / how_many
    local theta = 0
    local length = 400

    for i=1,how_many do
        local vel_x = math.cos( theta ) * length
        local vel_y = math.sin( theta ) * length
        theta = theta + angle_inc

        shoot_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/deck/mass_status_support_effect.xml", pos_x, pos_y, vel_x, vel_y )
    end
end

if current_frame > next_trueform_frame then
    local children = EntityGetAllChildren(player_id)
    for k=1,#children
    do local v = children[k]
        if EntityHasTag(v,"harmful_status") or EntityHasTag(v,"very_harmful_status") then
            local comp = EntityGetFirstComponentIncludingDisabled(v,"LifetimeComponent") or 0
            if comp ~= 0 then
                ComponentSetValue2(comp,"lifetime",2)
                ComponentSetValue2(comp,"kill_frame",GameGetFrameNum() + 2)
            end
            local comp2 = EntityGetFirstComponentIncludingDisabled(v,"GameEffectComponent") or 0
            if comp2 ~= 0 then
                ComponentSetValue2(comp2,"frames",2)
            end
            harmful_effect_found = true
        end

        local comp = EntityGetFirstComponent(v,"GameEffectComponent") or 0
        if comp ~= 0 then
            local cause_id = ComponentGetValue2(comp,"causing_status_effect")
            local cause_is_ingestion = ComponentGetValue2(comp,"caused_by_ingestion_status_effect")
            local is_harmful = false

            if cause_id > 0 then
                for z=1,#status_effects
                do local s = status_effects[z]
                    if s.is_harmful == true and s.id == status_effects[cause_id].id then
                        is_harmful = true
                        break
                    end
                end
            end

            if cause_is_ingestion and is_harmful then
                EntityRemoveIngestionStatusEffect( player_id, status_effects[cause_id].id )
                ComponentSetValue2(comp,"frames",2)
                harmful_effect_found = true
            end
        end
    end

    if harmful_effect_found == true then
        ComponentSetValue2(vsc_comp,"value_int",current_frame + trueform_cooldown)
        local pos_x, pos_y = EntityGetTransform(entity_id)
		GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/all_seeing_eye/create", pos_x, pos_y )
        local status = EntityLoad("mods/Apotheosis/files/entities/misc/effect_support_passive_cooldown.xml",pos_x,pos_y)
        local extended_protection = EntityLoad("mods/Apotheosis/files/entities/misc/effect_clear_status_everything.xml",pos_x,pos_y)
        EntityAddChild(player_id,status)
        EntityAddChild(player_id,extended_protection)
        visualEffects(pos_x,pos_y)
    end
end
