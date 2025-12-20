dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")
dofile_once("data/scripts/perks/perk.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local vsc_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local state = ComponentGetValue2(vsc_comp,"value_int")
local state_timer = ComponentGetValue2(vsc_comp,"value_float")
local current_frame = GameGetFrameNum()
SetRandomSeed(666,444)

local minimum_mat_count_to_create_spell = 500

local time_to_suck_liquids = 600

local state_options = {
    idle = 0,
    suck_liquid = 1,
    evaluate_contents = 2,
    creation_animation = 3,
    create_spells = 4,
    sleep = 5,
    reset_to_default = 99,
}

spell_material_database = {
    {
        materials = {"acid"},
        reward = function()
            local spell_opts = {"APOTHEOSIS_LIQUIDSPHERE_ACID",}
            local spell_id = spell_opts[Random(1,#spell_opts)]
            CreateItemActionEntity( spell_id, pos_x, pos_y - 35 )

            ProduceRewardFlair(true, pos_x, pos_y - 35)
        end
    },
    {
        materials = {"magic_liquid_movement_faster","magic_liquid_faster_levitation","magic_liquid_faster_levitation_and_movement","apotheosis_magic_liquid_velocium","apotheosis_magic_liquid_escapium"},
        reward = function()
            local spell_opts = {"SPEED","ACCELERATING_SHOT"}
            local spell_id = spell_opts[Random(1,#spell_opts)]
            CreateItemActionEntity( spell_id, pos_x, pos_y - 35 )

            ProduceRewardFlair(true, pos_x, pos_y - 35)
        end
    },
    {
        materials = {"magic_liquid_berserk"},
        reward = function()
            local spell_opts = {"DAMAGE", "DAMAGE_RANDOM", "BLOODLUST", "HEAVY_SHOT",}
            local spell_id = spell_opts[Random(1,#spell_opts)]
            CreateItemActionEntity( spell_id, pos_x, pos_y - 35 )

            ProduceRewardFlair(true, pos_x, pos_y - 35)
        end
    },
    {
        materials = {"magic_liquid_polymorph", "magic_liquid_random_polymorph","magic_liquid_unstable_polymorph","apotheosis_milk_polymorph_polymorph"},
        reward = function()
            local spell_opts = {"POLYMORPH_FIELD", "CHAOS_POLYMORPH_FIELD", "PROJECTILE_TRANSMUTATION_FIELD",}
            local spell_id = spell_opts[Random(1,#spell_opts)]
            CreateItemActionEntity( spell_id, pos_x, pos_y - 35 )

            ProduceRewardFlair(true, pos_x, pos_y - 35)
        end
    },
    {
        materials = {"magic_liquid_mana_regeneration"},
        reward = function()
            local spell_opts = {"MANA_REDUCE",}
            local spell_id = spell_opts[Random(1,#spell_opts)]
            CreateItemActionEntity( spell_id, pos_x, pos_y - 35 )

            ProduceRewardFlair(true, pos_x, pos_y - 35)
        end
    },
    {
        materials = {"material_confusion"},
        reward = function()
            local spell_opts = {"APOTHEOSIS_RANDOM_ARC","APOTHEOSIS_RANDOM_HOMING","DAMAGE_RANDOM","RANDOM_EXPLOSION","TRANSMUTATION","CHAOTIC_ARC",}
            local spell_id = spell_opts[Random(1,#spell_opts)]
            CreateItemActionEntity( spell_id, pos_x, pos_y - 35 )

            ProduceRewardFlair(true, pos_x, pos_y - 35)
        end
    },
    {
        materials = {"magic_liquid_hp_regeneration","magic_liquid_hp_regeneration_unstable"},
        reward = function()
            local spell_opts = {"HEAL_BULLET","ANTIHEAL","REGENERATION_FIELD",}
            local spell_id = spell_opts[Random(1,#spell_opts)]
            CreateItemActionEntity( spell_id, pos_x, pos_y - 35 )

            ProduceRewardFlair(true, pos_x, pos_y - 35)
        end
    },
    {
        materials = {"magic_liquid_charm"},
        reward = function()
            local spell_opts = {"HOMING_SHOOTER",}
            local spell_id = spell_opts[Random(1,#spell_opts)]
            CreateItemActionEntity( spell_id, pos_x, pos_y - 35 )

            ProduceRewardFlair(true, pos_x, pos_y - 35)
        end
    },
    {
        materials = {"magic_liquid_worm_attractor","blood_worm"},
        reward = function()
            local spell_opts = {"WORM_SHOT",}
            if Random(1,100) == 1 then
                spell_opts = {"WORM_RAIN"}
            end

            local spell_id = spell_opts[Random(1,#spell_opts)]
            CreateItemActionEntity( spell_id, pos_x, pos_y - 35 )

            ProduceRewardFlair(true, pos_x, pos_y - 35)
        end
    },
    {
        materials = {"material_rainbow"},
        reward = function()
            local spell_opts = {"RAINBOW_TRAIL","COLOUR_RAINBOW",}
            local spell_id = spell_opts[Random(1,#spell_opts)]
            CreateItemActionEntity( spell_id, pos_x, pos_y - 35 )
            --09/12/2025 Conga: I would like this to create a rainbow parallax that replaces the default parallax but I'm weary of 

            ProduceRewardFlair(true, pos_x, pos_y - 35)
        end
    },
    {
        materials = {"magic_liquid_unstable_teleportation", "magic_liquid_teleportation","apotheosis_magic_liquid_rideshare"},
        reward = function()
            local spell_opts = {"TELEPORT_PROJECTILE", "TELEPORT_PROJECTILE_SHORT", "APOTHEOSIS_ALT_FIRE_TELEPORT", "APOTHEOSIS_ALT_FIRE_TELEPORT_SHORT"}
            if GameHasFlagRun("apotheosis_hardmode") then
                spell_opts = {"APOTHEOSIS_ALT_FIRE_TELEPORT", "APOTHEOSIS_ALT_FIRE_TELEPORT_SHORT"}
            end
            local spell_id = spell_opts[Random(1,#spell_opts)]
            CreateItemActionEntity( spell_id, pos_x, pos_y - 35 )

            ProduceRewardFlair(true, pos_x, pos_y - 35)
        end
    },
    {
        materials = {"apotheosis_magic_liquid_attunium"},
        reward = function()
            local spell_opts = {"HOMING", "HOMING_SHORT", "HOMING_ROTATE", "HOMING_ACCELERATING", "HOMING_AREA", "APOTHEOSIS_HOMING_DELAYED",}
            local spell_id = spell_opts[Random(1,#spell_opts)]
            CreateItemActionEntity( spell_id, pos_x, pos_y - 35 )

            ProduceRewardFlair(true, pos_x, pos_y - 35)
        end
    },
    --[[
    {
        materials = {"apotheosis_magic_liquid_divine"},
        reward = function()
            local spell_opts = {"ALL_SPELLS",}
            local spell_id = spell_opts[Random(1,#spell_opts)]
            CreateItemActionEntity( spell_id, pos_x, pos_y - 35 )

            ProduceRewardFlair(false, pos_x, pos_y - 35)
        end
    },
    ]]--
    {
        materials = {"apotheosis_magic_liquid_moon_portal"},
        reward = function()
            EntityLoad("mods/Apotheosis/files/scripts/materials/moon_portal_spawner.xml",pos_x,pos_y - 60)

            ProduceRewardFlair(true, pos_x, pos_y - 35)
        end
    },
    {
        materials = {"apotheosis_magic_liquid_nukes"},
        reward = function()
            local spell_opts = {"NUKE","ORBIT_NUKES","APOTHEOSIS_NUKE_RAY","APOTHEOSIS_NUKE_RAY_ENEMY",}
            local spell_id = spell_opts[Random(1,#spell_opts)]
            CreateItemActionEntity( spell_id, pos_x, pos_y - 35 )

            ProduceRewardFlair(true, pos_x, pos_y - 35)
        end
    },
    {
        materials = {"apotheosis_magic_liquid_pure_light"},
        reward = function()
            local spell_opts = {"LIGHT","APOTHEOSIS_MIND_VISION"}
            local spell_id = spell_opts[Random(1,#spell_opts)]
            CreateItemActionEntity( spell_id, pos_x, pos_y - 35 )

            ProduceRewardFlair(true, pos_x, pos_y - 35)
        end
    },
    {
        materials = {"apotheosis_magic_liquid_suffocatium"},
        reward = function()
            local spell_opts = {"MATERIAL_WATER",}
            local spell_id = spell_opts[Random(1,#spell_opts)]
            CreateItemActionEntity( spell_id, pos_x, pos_y - 35 )

            ProduceRewardFlair(true, pos_x, pos_y - 35)
        end
    },
    {
        materials = {"apotheosis_sweat"},
        reward = function()
            local pcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ParticleEmitterComponent")
            ComponentSetValue2(pcomp,"emitted_material_name","apotheosis_hidden_liquid_baldium")

            ProduceRewardFlair(true, pos_x, pos_y - 35)
        end
    },
    {
        materials = {"water"},
        reward = function()
            EntityLoad("mods/Apotheosis/files/entities/items/pickups/pity.xml", pos_x + 10, pos_y - 35)

            ProduceRewardFlair(false, pos_x, pos_y - 35)
        end
    },
    {
        materials = {"midas","midas_precursor"},
        reward = function()
            local pcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ParticleEmitterComponent")
            ComponentSetValue2(pcomp,"emitted_material_name","gold")

            local plyr = EntityGetWithTag("player_unit") or {}
            for k=1,#plyr do
                local wallet = EntityGetFirstComponentIncludingDisabled(plyr[k],"WalletComponent")
                local money = ComponentGetValue2(wallet,"money")
                ComponentSetValue2(wallet,"money",money + 1000000)
            end

            ProduceRewardFlair(true, pos_x, pos_y - 35)
        end
    },
    {
        materials = {"milk","apotheosis_milk"},
        reward = function()
            if Random(1,4) == 1 then
                perk_spawn( pos_x, pos_y - 35, "IRON_STOMACH" )

                ProduceRewardFlair(true, pos_x, pos_y - 35)
            else
                EntityLoad("data/entities/particles/image_emitters/chest_effect_bad.xml", pos_x, pos_y - 35)
                GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/chest_bad/create", pos_x, pos_y - 35)
            end
        end
    },
}

function get_material_count()
    local matinvcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"MaterialInventoryComponent")
    local fluid_data = {}

    local mats = ComponentGetValue2(matinvcomp, "count_per_material_type")
    for j = 0, #mats, 1 do
        local fluid_count = mats[j+1]
        if fluid_count ~= 0 and fluid_count ~= nil then
            if fluid_count > minimum_mat_count_to_create_spell then
                table.insert(fluid_data,{material_string = CellFactory_GetName(j), liquid_count = fluid_count})
            end
            AddMaterialInventoryMaterial(entity_id,CellFactory_GetName(j),0)
        end
    end

    return fluid_data
end

function find_rewards(fluid_data)
    local pcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ParticleEmitterComponent")
    local reward_indexes_to_payout = {}
    local index_found = false
    for k=1,#fluid_data do
        local material_id = fluid_data[k].material_string
        index_found = false
        for z=1,#spell_material_database do if index_found then break end
            for b=1,#spell_material_database[z].materials do if index_found then break end
                if spell_material_database[z].materials[b] == material_id then
                    table.insert(reward_indexes_to_payout,z)
                    ComponentSetValue2(pcomp,"emitted_material_name",material_id)
                    index_found = true
                    break
                end
            end
        end
    end

    return reward_indexes_to_payout
end

function ProduceRewardFlair(good_item_dropped,pos_x,pos_y)
    GameTriggerMusicEvent( "music/oneshot/ei_vihuja_01", true, pos_x, pos_y )
	if good_item_dropped then
		EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", pos_x, pos_y)
	else
		EntityLoad("data/entities/particles/image_emitters/chest_effect_bad.xml", pos_x, pos_y)
		GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/chest_bad/create", pos_x, pos_y )
	end
end

function vat_update()
    if state == state_options.idle then
        return
    elseif state == state_options.suck_liquid then

        if current_frame > state_timer then
            local mat_suck_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"MaterialSuckerComponent")
            EntitySetComponentIsEnabled( entity_id, mat_suck_comp, false )

            ComponentSetValue2(vsc_comp,"value_int",state_options.evaluate_contents)
            ComponentSetValue2(vsc_comp,"value_float",current_frame + 300)
        end
    elseif state == state_options.evaluate_contents then
        local fluid_data = get_material_count()
        if #fluid_data > 0 then
            --Decide what spells we're going to print and save it to the VSC
            local indexes_to_reward = find_rewards(fluid_data)
            --print("spells to create are: " .. table.concat(spells_to_create,","))
            ComponentSetValue2(vsc_comp,"value_string",table.concat(indexes_to_reward,","))

            ComponentSetValue2(vsc_comp,"value_int",state_options.create_spells)
            ComponentSetValue2(vsc_comp,"value_float",current_frame + 300)
        else 
            ComponentSetValue2(vsc_comp,"value_int",99)
            ComponentSetValue2(vsc_comp,"value_float",current_frame + 300)
        end
    elseif state == state_options.create_spells then
        local indexes_to_reward = SplitStringOnCharIntoTable(ComponentGetValue2(vsc_comp,"value_string"),",")
        for k=1,#indexes_to_reward do
            spell_material_database[tonumber(indexes_to_reward[k])].reward()
        end
        
        local pe_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"ParticleEmitterComponent")
        EntitySetComponentIsEnabled(entity_id,pe_comp,true)

        local sucker_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"MaterialSuckerComponent")
        EntitySetComponentIsEnabled(entity_id,sucker_comp,false)
        local lua_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"LuaComponent")
        EntitySetComponentIsEnabled(entity_id,lua_comp,false)

        local children = EntityGetAllChildren(entity_id) or {}
        for child=1,#children do
            local mcon_comp = EntityGetFirstComponentIncludingDisabled(children[child],"MagicConvertMaterialComponent")
            EntitySetComponentIsEnabled(children[child],mcon_comp,true)
        end

        ComponentSetValue2(vsc_comp,"value_int",state_options.sleep)

    elseif state == state_options.reset_to_default then
        --Reset since we failed for some reason

        local area_checkers = EntityGetComponent(entity_id,"MaterialAreaCheckerComponent") or {}
        for k=1,#area_checkers do
            EntitySetComponentIsEnabled(entity_id,area_checkers[k],true)
        end

        local sucker_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"MaterialSuckerComponent")
        EntitySetComponentIsEnabled(entity_id,sucker_comp,false)

        ComponentSetValue2(vsc_comp,"value_int",state_options.idle)
    end
end

function init(entity_id)
    --Generate a list of MaterialAreaCheckerComponents for every possible liquid listed in the above database
    --If Noita ever gets support for this component to search for tags instead of individual materials, this can be cleaned up
    local materials_to_check_for = {}
    local checkers_to_assemble = {}

    for z=1,#spell_material_database do
        for b=1,#spell_material_database[z].materials do
            table.insert(materials_to_check_for,spell_material_database[z].materials[b])
        end
    end

    for k=1,#materials_to_check_for,2 do
        local suck_comp = EntityAddComponent2(
            entity_id,
            "MaterialAreaCheckerComponent",
            {
                update_every_x_frame=10,
                material=CellFactory_GetType(materials_to_check_for[k] or ""),
                material2=CellFactory_GetType(materials_to_check_for[k+1] or ""),
                look_for_failure=false,
                kill_after_message=false,
            }
        )

        ComponentSetValue2(suck_comp, "area_aabb", -25, -3, 25, 3)
    end
end

function material_area_checker_success( pos_x, pos_y )
    local area_checkers = EntityGetComponent(entity_id,"MaterialAreaCheckerComponent")
    for k=1,#area_checkers do
        EntitySetComponentIsEnabled(entity_id,area_checkers[k],false)
    end

    local sucker_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"MaterialSuckerComponent")
    EntitySetComponentIsEnabled(entity_id,sucker_comp,true)

    ComponentSetValue2(vsc_comp,"value_int",state_options.suck_liquid)
    ComponentSetValue2(vsc_comp,"value_float",current_frame + time_to_suck_liquids)

    GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
end

vat_update()