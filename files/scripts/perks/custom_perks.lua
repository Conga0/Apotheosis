
local apotheosis_perkappends = {
    {
        id = "APOTHEOSIS_GHOSTLY_VISION",
        ui_name = "$perk_apotheosis_ghostly_vision",
        ui_description = "$perk_apotheosis_ghostly_vision_description",
        ui_icon = "mods/Apotheosis/files/ui_gfx/perk_icons/ghostly_vision_perk_ui.png",
        perk_icon = "mods/Apotheosis/files/items_gfx/perks/ghostly_vision_perk.png",
        not_in_default_perk_pool = true,
        stackable = STACKABLE_NO,
        usable_by_enemies = false,
        func = function( entity_perk_item, entity_who_picked, item_name )
            local x,y = EntityGetTransform( entity_who_picked )
            local child_id = EntityLoad( "mods/Apotheosis/files/entities/misc/perks/ghostly_vision_perk.xml", x, y )
            EntityAddTag( child_id, "perk_entity" )
            EntityAddChild( entity_who_picked, child_id )
        end,
        _remove = function(entity_id)
            local apotheosis_targets = EntityGetAllChildren(entity_id)
            for i,v in ipairs( apotheosis_targets ) do
                if ( v ~= entity_id ) and ( EntityGetName( v ) == "apotheosis_perk_ghostly_vision" ) then
                    EntityKill ( v )
                end
            end
        end,
        func_remove = function( entity_who_picked )
            local apotheosis_targets = EntityGetAllChildren(entity_id)
            for i,v in ipairs( apotheosis_targets ) do
                if ( v ~= entity_id ) and ( EntityGetName( v ) == "apotheosis_perk_ghostly_vision" ) then
                    EntityKill ( v )
                end
            end
        end,
    },
    {
        id = "APOTHEOSIS_RAGE_AURA",
        unlock_flag = "apotheosis_card_unlocked_rage_aura",
        ui_name = "$perk_apotheosis_rage_aura",
        ui_description = "$perk_apotheosis_rage_aura_description",
        ui_icon = "mods/Apotheosis/files/ui_gfx/perk_icons/rage_aura_perk_ui.png",
        perk_icon = "mods/Apotheosis/files/items_gfx/perks/rage_aura_perk.png",
        not_in_default_perk_pool = false,
        stackable = STACKABLE_NO,
        usable_by_enemies = true,
        func = function( entity_perk_item, entity_who_picked, item_name )
            add_halo_level(entity_who_picked, -1)
            local x,y = EntityGetTransform( entity_who_picked )
            local child_id = EntityLoad( "mods/Apotheosis/files/entities/misc/perks/rage_aura_perk.xml", x, y )
            EntityAddTag( child_id, "perk_entity" )
            EntityAddChild( entity_who_picked, child_id )
        end,
        _remove = function(entity_id)
            local apotheosis_targets = EntityGetAllChildren(entity_id)
            for i,v in ipairs( apotheosis_targets ) do
                if ( v ~= entity_id ) and ( EntityGetName( v ) == "apotheosis_perk_rage_aura" ) then
                    EntityKill ( v )
                    add_halo_level(entity_id, 1)
                end
            end
        end,
        func_remove = function( entity_who_picked )
            local apotheosis_targets = EntityGetAllChildren(entity_id)
            for i,v in ipairs( apotheosis_targets ) do
                if ( v ~= entity_id ) and ( EntityGetName( v ) == "apotheosis_perk_rage_aura" ) then
                    EntityKill ( v )
                    add_halo_level(entity_id, 1)
                end
            end
        end,
    },
    {
        id = "APOTHEOSIS_REVENGE_REFLECTIVE",
        id_matchup = "REVENGE_BULLET",
        unlock_flag = "boss_centipede",
        ui_name = "$perk_apotheosis_revenge_reflective",
        ui_description = "$perk_apotheosis_revenge_reflective_description",
        ui_icon = "mods/Apotheosis/files/ui_gfx/perk_icons/revenge_reflection_perk_ui.png",
        perk_icon = "mods/Apotheosis/files/items_gfx/perks/revenge_reflection_perk.png",
        not_in_default_perk_pool = false,
        stackable = STACKABLE_NO,
        usable_by_enemies = true,
        func = function( entity_perk_item, entity_who_picked, item_name )
            local x,y = EntityGetTransform( entity_who_picked )
            EntityAddComponent2(
                entity_who_picked,
                "LuaComponent",
                {
                    execute_on_added = false,
                    execute_every_n_frame=-1,
                    script_damage_received="mods/Apotheosis/files/scripts/perks/wraith_returner_damage.lua",
                    remove_after_executed = false,
                    execute_times=-1
                }
            )
            
            EntityAddComponent2(
                entity_who_picked,
                "LuaComponent",
                {
                    execute_on_added = false,
                    execute_every_n_frame=3,
                    script_source_file="mods/Apotheosis/files/scripts/perks/wraith_returner_memory.lua",
                    remove_after_executed = false,
                    execute_times=-1
                }
            )
            
            EntityAddComponent2(
                entity_who_picked,
                "VariableStorageComponent",
                {
                    name="proj_file_apotheosis",
                    value_string="data/entities/projectiles/wraith_glowing_laser.xml",
                    value_float=0.5
                }
            )
        end,
        _remove = function(entity_id)
            local comp_lua = EntityGetComponentIncludingDisabled( player, "LuaComponent" )
            if ( comp_lua ~= nil ) then
                for i,v in ipairs( comp_lua ) do
                    local name = ComponentGetValue2( v, "script_damage_received" )
                    
                    if ( name == "mods/Apotheosis/files/scripts/perks/wraith_returner_damage.lua" ) or ( name == "mods/Apotheosis/files/scripts/perks/wraith_returner_memory.lua" ) then
                        EntityRemoveComponent(player, v)
                    end
                end
            end        
        end,
        func_remove = function( entity_who_picked )
            local comp_lua = EntityGetComponentIncludingDisabled( player, "LuaComponent" )
            if ( comp_lua ~= nil ) then
                for i,v in ipairs( comp_lua ) do
                    local name = ComponentGetValue2( v, "script_damage_received" )
                    
                    if ( name == "mods/Apotheosis/files/scripts/perks/wraith_returner_damage.lua" ) or ( name == "mods/Apotheosis/files/scripts/perks/wraith_returner_memory.lua" ) then
                        EntityRemoveComponent(player, v)
                    end
                end
            end        
        end,
    },
    {
        id = "APOTHEOSIS_OVERSIZED_SHIELD",
        id_matchup = "SHIELD",
        ui_name = "$perk_apotheosis_shield_oversized_name",
        ui_description = "$perk_apotheosis_shield_oversized_description",
        ui_icon = "mods/apotheosis/files/ui_gfx/perk_icons/shield_oversized.png",
        perk_icon = "mods/apotheosis/files/items_gfx/perks/shield_oversized.png",
        stackable = STACKABLE_YES,
        stackable_how_often_reappears = 10,
        stackable_maximum = 5,
        max_in_perk_pool = 2,
        usable_by_enemies = true,
        func = function( entity_perk_item, entity_who_picked, item_name )
            local x,y = EntityGetTransform( entity_who_picked )
            local child_id = EntityLoad( "mods/Apotheosis/files/entities/misc/perks/shield_oversized.xml", x, y )
            
            local shield_num = tonumber( GlobalsGetValue( "PERK_SHIELD_OVERSIZED_COUNT", "0" ) )
            local shield_radius = 75 + shield_num * 3.0
            local charge_speed = math.max( 0.01 - shield_num * 0.05, 0.02 )
            shield_num = shield_num + 1
            GlobalsSetValue( "PERK_SHIELD_OVERSIZED_COUNT", tostring( shield_num ) )
            
            local comps = EntityGetComponent( child_id, "EnergyShieldComponent" )
            if( comps ~= nil ) then
                for i,comp in ipairs( comps ) do
                    ComponentSetValue2( comp, "radius", shield_radius )
                    ComponentSetValue2( comp, "recharge_speed", charge_speed )
                end
            end
            
            comps = EntityGetComponent( child_id, "ParticleEmitterComponent" )
            if( comps ~= nil ) then
                for i,comp in ipairs( comps ) do
                    local minradius,maxradius = ComponentGetValue2( comp, "area_circle_radius" )
                    
                    if ( minradius ~= nil ) and ( maxradius ~= nil ) then
                        if ( minradius == 0 ) then
                            ComponentSetValue2( comp, "area_circle_radius", 0, shield_radius )
                        elseif ( minradius == 10 ) then
                            ComponentSetValue2( comp, "area_circle_radius", shield_radius, shield_radius )
                        end
                    end
                end
            end
            
            EntityAddTag( child_id, "perk_entity" )
            EntityAddChild( entity_who_picked, child_id )
        end,
        func_enemy = function( entity_perk_item, entity_who_picked )
            local x,y = EntityGetTransform( entity_who_picked )
            local child_id = EntityLoad( "mods/Apotheosis/files/entities/misc/perks/shield_oversized.xml", x, y )
            EntityAddChild( entity_who_picked, child_id )
        end,
        _remove = function( entity_who_picked )
            local shield_num = 0
            GlobalsSetValue( "PERK_SHIELD_OVERSIZED_COUNT", tostring( shield_num ) )
        end,
        func_remove = function( entity_who_picked )
            local shield_num = 0
            GlobalsSetValue( "PERK_SHIELD_OVERSIZED_COUNT", tostring( shield_num ) )
        end,
    },
    {
        id = "APOTHEOSIS_HASTE",
        ui_name = "$perk_apotheosis_haste_name",
        ui_description = "$perk_apotheosis_haste_description",
        ui_icon = "data/ui_gfx/perk_icons/movement_faster.png",
        perk_icon = "data/items_gfx/perks/movement_faster.png",
        stackable = STACKABLE_YES,
        not_in_default_perk_pool = false,
        usable_by_enemies = true,
        stackable_how_often_reappears = 6,
        stackable_maximum = 4,
        max_in_perk_pool = 1,
        func = function(entity_perk_item, entity_who_picked, item_name)
            local comp = EntityGetFirstComponentIncludingDisabled(entity_who_picked, "CharacterPlatformingComponent")
            if comp ~= nil then
                local values = {
                    "jump_velocity_y",
                    "jump_velocity_x",
                    "fly_speed_max_up",
                    "fly_speed_max_down",
                    "run_velocity",
                    "fly_velocity_x",
                    "velocity_min_x",
                    "velocity_max_x",
                    "velocity_min_y",
                    "velocity_max_y"
                }

                --Default speed values Mina starts with, multiplid to be a 60% boost in ComponentSetValue
                local defaults = {
                    -95,
                    56,
                    95,
                    85,
                    154,
                    52,
                    -57,
                    57,
                    -200,
                    350,
                }

                for k=1,#values
                do v = values[k]
                    local val = ComponentGetValue2(comp,v)
                    ComponentSetValue2(comp,v,val + (defaults[k] * 0.6))
                end
            end
        end,
        func_enemy = function( entity_perk_item, entity_who_picked )
            LoadGameEffectEntityTo(entity_who_picked, "mods/Apotheosis/files/entities/misc/perks/perk_haste.xml")
        end,
        _remove = function(entity_who_picked)
            local comp = EntityGetFirstComponentIncludingDisabled(entity_who_picked, "CharacterPlatformingComponent")
            if comp ~= nil then
                local values = {
                    "jump_velocity_y",
                    "jump_velocity_x",
                    "fly_speed_max_up",
                    "fly_speed_max_down",
                    "run_velocity",
                    "fly_velocity_x",
                    "velocity_min_x",
                    "velocity_max_x",
                    "velocity_min_y",
                    "velocity_max_y"
                }

                --Default speed values Mina starts with
                local defaults = {
                -95,
                56,
                95,
                85,
                154,
                52,
                -57,
                57,
                -200,
                350,
                }

                for k=1,#values
                do v = values[k]
                    ComponentSetValue2(comp,v,defaults[k])
                end
            end
        end,
        func_remove = function( entity_who_picked )
            local comp = EntityGetFirstComponentIncludingDisabled(entity_who_picked, "CharacterPlatformingComponent")
            if comp ~= nil then
                local values = {
                    "jump_velocity_y",
                    "jump_velocity_x",
                    "fly_speed_max_up",
                    "fly_speed_max_down",
                    "run_velocity",
                    "fly_velocity_x",
                    "velocity_min_x",
                    "velocity_max_x",
                    "velocity_min_y",
                    "velocity_max_y"
                }

                local defaults = {
                -95,
                56,
                95,
                85,
                154,
                52,
                -57,
                57,
                -200,
                350,
                }

                for k=1,#values
                do v = values[k]
                    ComponentSetValue2(comp,v,defaults[k])
                end
            end
        end,
    },
    {
        id = "APOTHEOSIS_ALCOHOL_IMMUNITY",
        id_matchup = "PROTECTION_ELECTRICITY",
        ui_name = "$perk_apotheosis_alcohol_immunity",
        ui_description = "$perk_apotheosis_alcohol_immunity_description",
        ui_icon = "mods/Apotheosis/files/ui_gfx/perk_icons/protection_alcohol_perk_ui.png",
        perk_icon = "mods/Apotheosis/files/items_gfx/perks/protection_alcohol.png",
        not_in_default_perk_pool = true,
        stackable = STACKABLE_NO,
        usable_by_enemies = true,
        func = function( entity_perk_item, entity_who_picked, item_name )
            local x,y = EntityGetTransform( entity_who_picked )
            local child_id = EntityLoad( "mods/Apotheosis/files/entities/misc/perks/alcohol_immunity_perk.xml", x, y )
            EntityAddTag( child_id, "perk_entity" )
            EntityAddChild( entity_who_picked, child_id )
        end,
        _remove = function(entity_id)
            local apotheosis_targets = EntityGetAllChildren(entity_id)
            for i,v in ipairs( apotheosis_targets ) do
                if ( v ~= entity_id ) and ( EntityGetName( v ) == "apotheosis_perk_alcohol_immunity" ) then
                    EntityKill ( v )
                end
            end
        end,
        func_remove = function( entity_who_picked )
            local apotheosis_targets = EntityGetAllChildren(entity_id)
            for i,v in ipairs( apotheosis_targets ) do
                if ( v ~= entity_id ) and ( EntityGetName( v ) == "apotheosis_perk_alcohol_immunity" ) then
                    EntityKill ( v )
                end
            end
        end,
    },
    {
        id = "APOTHEOSIS_TRIP_IMMUNITY",
        id_matchup = "APOTHEOSIS_ALCOHOL_IMMUNITY",
        ui_name = "$perk_apotheosis_trip_immunity",
        ui_description = "$perk_apotheosis_trip_immunity_description",
        ui_icon = "mods/Apotheosis/files/ui_gfx/perk_icons/protection_trip_perk_ui.png",
        perk_icon = "mods/Apotheosis/files/items_gfx/perks/protection_trip.png",
        not_in_default_perk_pool = true,
        stackable = STACKABLE_NO,
        usable_by_enemies = false,
        func = function()
            GameAddFlagRun("apotheosis_flag_no_tripping")
        end,
        _remove = function()
            GameRemoveFlagRun("apotheosis_flag_no_tripping")
        end,
        func_remove = function( entity_who_picked )
            GameRemoveFlagRun("apotheosis_flag_no_tripping")
        end,
    },
    {
        id = "APOTHEOSIS_NO_RECOIL",
        id_matchup = "NO_MORE_KNOCKBACK",
        ui_name = "$perk_apotheosis_no_recoil",
        ui_description = "$perk_apotheosis_no_recoil_description",
        ui_icon = "data/ui_gfx/perk_icons/low_recoil.png",
        perk_icon = "data/items_gfx/perks/low_recoil.png",
        stackable = STACKABLE_NO,
        usable_by_enemies = false,
        func = function( entity_perk_item, entity_who_picked, item_name )
            local x,y = EntityGetTransform( entity_who_picked )
            local child_id = EntityLoad( "mods/Apotheosis/files/entities/misc/perks/no_recoil.xml", x, y )
            EntityAddTag( child_id, "perk_entity" )
            EntityAddChild( entity_who_picked, child_id )
        end,
        _remove = function(entity_id)
            local apotheosis_targets = EntityGetAllChildren(entity_id)
            for i,v in ipairs( apotheosis_targets ) do
                if ( v ~= entity_id ) and ( EntityGetName( v ) == "apotheosis_perk_no_recoil" ) then
                    EntityKill ( v )
                end
            end
        end,
        func_remove = function( entity_who_picked )
            local apotheosis_targets = EntityGetAllChildren(entity_id)
            for i,v in ipairs( apotheosis_targets ) do
                if ( v ~= entity_id ) and ( EntityGetName( v ) == "apotheosis_perk_recoil" ) then
                    EntityKill ( v )
                end
            end
        end,
    },
    {
        id = "APOTHEOSIS_VOID",
        ui_name = "$perk_apotheosis_void",
        ui_description = "$perk_apotheosis_void_description",
        ui_icon = "mods/apotheosis/files/ui_gfx/perk_icons/void.png",
        perk_icon = "mods/apotheosis/files/items_gfx/perks/void.png",
        stackable = STACKABLE_YES,
        usable_by_enemies = false,
        one_off_effect = true,
        func = function(entity_perk_item, entity_who_picked, item_name)

            local value = tonumber(GlobalsGetValue( "APOTHEOSIS_VOID_COUNT", "0" ))
            GlobalsSetValue( "APOTHEOSIS_VOID_COUNT", tostring(value + 1))

            local pos_x, pos_y = EntityGetTransform(entity_who_picked)
            local c = EntityLoad( "mods/apotheosis/files/entities/misc/effect_tinker_with_wands_temporary.xml", pos_x, pos_y )
            EntityAddChild( entity_who_picked, c )


            local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
            if( damagemodels ~= nil ) then
                for i,damagemodel in ipairs(damagemodels) do
                    local old_max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ) )
                    local multiplier = 1.5
                    if old_max_hp >= 120 then multiplier = 1.01
                    elseif old_max_hp >= 80 then multiplier = 1.05
                    elseif old_max_hp >= 40 then multiplier = 1.15
                    end
                    local max_hp = old_max_hp * multiplier
                    
                    local max_hp_cap = tonumber( ComponentGetValue( damagemodel, "max_hp_cap" ) )
                    if max_hp_cap > 0 then
                        max_hp = math.min( max_hp, max_hp_cap )
                    end
                    
                    local current_hp = tonumber( ComponentGetValue( damagemodel, "hp" ) )
                    current_hp = math.min( current_hp + math.abs(max_hp - old_max_hp), max_hp )
                    
                    ComponentSetValue( damagemodel, "max_hp", max_hp )
                    ComponentSetValue( damagemodel, "hp", current_hp )
                end
            end

            local comp = EntityGetFirstComponentIncludingDisabled(entity_who_picked, "CharacterPlatformingComponent")
            if comp ~= nil then

                local values = {
                    "jump_velocity_y",
                    "jump_velocity_x",
                    "fly_speed_max_up",
                    "fly_speed_max_down",
                    "run_velocity",
                    "fly_velocity_x",
                    "velocity_min_x",
                    "velocity_max_x",
                    "velocity_min_y",
                    "velocity_max_y"
                }

                --Default speed values Mina starts with, multiplied to be a 15% boost in ComponentSetValue
                local defaults = {
                    -95,
                    56,
                    95,
                    85,
                    154,
                    52,
                    -57,
                    57,
                    -200,
                    350,
                }

                for k=1,#values
                do v = values[k]
                    local val = ComponentGetValue2(comp,v)
                    if val <= defaults[k] * 1.75 then
                        ComponentSetValue2(comp,v,val + (defaults[k] * 0.15))
                    end
                end
            end
        end,
        _remove = function(entity_who_picked)

            GlobalsSetValue( "APOTHEOSIS_VOID_COUNT", 0 )

            local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
            if( damagemodels ~= nil ) then
                for i,damagemodel in ipairs(damagemodels) do
                    local old_max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ) )
                    local max_hp = old_max_hp / 1.5
                    
                    local max_hp_cap = tonumber( ComponentGetValue( damagemodel, "max_hp_cap" ) )
                    if max_hp_cap > 0 then
                        max_hp = math.min( max_hp, max_hp_cap )
                    end
                    
                    local current_hp = tonumber( ComponentGetValue( damagemodel, "hp" ) )
                    current_hp = math.min( current_hp + math.abs(max_hp - old_max_hp), max_hp )
                    
                    ComponentSetValue( damagemodel, "max_hp", max_hp )
                    ComponentSetValue( damagemodel, "hp", current_hp )
                end
            end

            local comp = EntityGetFirstComponentIncludingDisabled(entity_who_picked, "CharacterPlatformingComponent")
            if comp ~= nil then
                local values = {
                    "jump_velocity_y",
                    "jump_velocity_x",
                    "fly_speed_max_up",
                    "fly_speed_max_down",
                    "run_velocity",
                    "fly_velocity_x",
                    "velocity_min_x",
                    "velocity_max_x",
                    "velocity_min_y",
                    "velocity_max_y"
                }

                --Default speed values Mina starts with
                local defaults = {
                -95,
                56,
                95,
                85,
                154,
                52,
                -57,
                57,
                -200,
                350,
                }

                for k=1,#values
                do v = values[k]
                    ComponentSetValue2(comp,v,defaults[k])
                end
            end
        end,
        func_remove = function( entity_who_picked )

            GlobalsSetValue( "APOTHEOSIS_VOID_COUNT", 0 )

            local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
            if( damagemodels ~= nil ) then
                for i,damagemodel in ipairs(damagemodels) do
                    local old_max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ) )
                    local max_hp = old_max_hp / 1.5
                    
                    local max_hp_cap = tonumber( ComponentGetValue( damagemodel, "max_hp_cap" ) )
                    if max_hp_cap > 0 then
                        max_hp = math.min( max_hp, max_hp_cap )
                    end
                    
                    local current_hp = tonumber( ComponentGetValue( damagemodel, "hp" ) )
                    current_hp = math.min( current_hp + math.abs(max_hp - old_max_hp), max_hp )
                    
                    ComponentSetValue( damagemodel, "max_hp", max_hp )
                    ComponentSetValue( damagemodel, "hp", current_hp )
                end
            end

            local comp = EntityGetFirstComponentIncludingDisabled(entity_who_picked, "CharacterPlatformingComponent")
            if comp ~= nil then
                local values = {
                    "jump_velocity_y",
                    "jump_velocity_x",
                    "fly_speed_max_up",
                    "fly_speed_max_down",
                    "run_velocity",
                    "fly_velocity_x",
                    "velocity_min_x",
                    "velocity_max_x",
                    "velocity_min_y",
                    "velocity_max_y"
                }

                local defaults = {
                -95,
                56,
                95,
                85,
                154,
                52,
                -57,
                57,
                -200,
                350,
                }

                for k=1,#values
                do v = values[k]
                    ComponentSetValue2(comp,v,defaults[k])
                end
            end
        end,
    },
    {
        id = "APOTHEOSIS_NO_BLOOD",
        id_matchup = "GLOBAL_GORE",
        ui_name = "$perk_apotheosis_no_blood",
        ui_description = "$perk_apotheosis_no_blood_description",
        ui_icon = "mods/Apotheosis/files/ui_gfx/perk_icons/no_blood_perk_ui.png",
        perk_icon = "mods/Apotheosis/files/items_gfx/perks/no_blood_perk.png",
        not_in_default_perk_pool = true,
        stackable = STACKABLE_NO,
        usable_by_enemies = false,
        func = function( entity_perk_item, entity_who_picked, item_name )
            local x,y = EntityGetTransform( entity_who_picked )
            local child_id = EntityLoad( "mods/Apotheosis/files/entities/misc/perks/no_blood_perk.xml", x, y )
            EntityAddTag( child_id, "perk_entity" )
            EntityAddChild( entity_who_picked, child_id )
        end,
        _remove = function(entity_id)
            local apotheosis_targets = EntityGetAllChildren(entity_id)
            for i,v in ipairs( apotheosis_targets ) do
                if ( v ~= entity_id ) and ( EntityGetName( v ) == "apotheosis_perk_no_blood" ) then
                    EntityKill ( v )
                end
            end
        end,
        func_remove = function( entity_who_picked )
            local apotheosis_targets = EntityGetAllChildren(entity_id)
            for i,v in ipairs( apotheosis_targets ) do
                if ( v ~= entity_id ) and ( EntityGetName( v ) == "apotheosis_perk_no_blood" ) then
                    EntityKill ( v )
                end
            end
        end,
    },
}

-- Not completely sure why, but this feels like a bad solution, wrong, is it because it isn't 'absolute'?
--[[
table.insert(perk_list,
{
    id = "APOTHEOSIS_COPY_SPELLS",
    ui_name = "$perk_apotheosis_copy_spells",
    ui_description = "$perk_apotheosis_copy_spells_description",
    ui_icon = "mods/Apotheosis/files/ui_gfx/perk_icons/copy_spells_perk_ui.png",
    perk_icon = "mods/Apotheosis/files/items_gfx/perks/copy_spells.png",
    not_in_default_perk_pool = true,
    stackable = STACKABLE_NO,
    usable_by_enemies = false,
    func = function()
        GameAddFlagRun("apotheosis_flag_copy_spells")
    end,
    _remove = function()
        GameRemoveFlagRun("apotheosis_flag_copy_spells")
    end,
    func_remove = function( entity_who_picked )
        GameRemoveFlagRun("apotheosis_flag_copy_spells")
    end,
})
]]--


if ModSettingGet( "Apotheosis.organised_icons" ) == true then
    for k=1,#apotheosis_perkappends
    do local v = apotheosis_perkappends[k]

        -- Disables the perk from spawning if it's not unlocked
        if v.unlock_flag then
            if HasFlagPersistent( v.unlock_flag ) == false then
                v.not_in_default_perk_pool = false
            end
        end

        --Adds Perk into the list at the position we want
        if v.id_matchup == nil then
            v.author = "Apotheosis - Conga Lyne"
            table.insert(perk_list,v)
        else
            for z=1,#perk_list
            do c = perk_list[z]
                if c.id == v.id_matchup then
                    v.author = "Apotheosis - Conga Lyne"
                    table.insert(perk_list,z + 1,v)
                    break
                end
                if z == #perk_list then
                    --Insert here as a failsafe incase the matchup ID can't be found.. some other mod might delete the perk we're trying to insert at
                    v.author = "Apotheosis - Conga Lyne"
                    table.insert(perk_list,v)
                end
            end
        end
    end
else
    for k=1,#apotheosis_perkappends
    do local v = apotheosis_perkappends[k]
        if v.unlock_flag then
            if HasFlagPersistent( v.unlock_flag ) == false then
                v.not_in_default_perk_pool = false
            end
        end
        v.author = "Apotheosis - Conga Lyne"
        table.insert(perk_list,v)
    end
end


















-- Remove Perks from perk_list
function remove_perk(perk_name)
	local key_to_perk = nil
	for key, perk in pairs(perk_list) do
		if (perk.id == perk_name) then
			key_to_perk = key
		end
	end

	if (key_to_perk ~= nil) then
		table.remove(perk_list, key_to_perk)
	end
end

remove_perk("PROJECTILE_REPULSION") --Reworked into Oversized Shield
remove_perk("MOVEMENT_FASTER") --Combined into HASTE
remove_perk("FASTER_LEVITATION") --Combined into HASTE
remove_perk("LOW_RECOIL") --Reworked into No Recoil

--Modify existing perk data for minor changes, DO NOT USE FOR MAJOR REWORKS
--if you need to do a major rework, remove the relevent perk(s) and add a new one instead
function modify_existing_perk(perk_id, parameter_to_modify, new_value)
	for i, perk in ipairs(perk_list) do
		if perk.id == perk_id then
			perk[parameter_to_modify] = new_value
			break
		end
	end
end

modify_existing_perk("CONTACT_DAMAGE", "ui_description", "$perk_apotheosis_contactdamage_description")
modify_existing_perk("CONTACT_DAMAGE", "game_effect", "PROTECTION_MELEE")

