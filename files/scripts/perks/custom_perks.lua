
local apotheosis_enrage_unlocked = HasFlagPersistent( "apotheosis_card_unlocked_rage_aura" )
local kolmi_dead = HasFlagPersistent( "boss_centipede" )

table.insert(perk_list,
{
    id = "apotheosis_GHOSTLY_VISION",
    ui_name = "$perk_apotheosis_ghostly_vision",
    ui_description = "$perk_apotheosis_ghostly_vision_description",
    ui_icon = "mods/Apotheosis/files/ui_gfx/perk_icons/ghostly_vision_perk_ui.png",
    perk_icon = "mods/Apotheosis/files/items_gfx/ghostly_vision_perk.png",
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
})


if apotheosis_enrage_unlocked then
    table.insert(perk_list,
    {
        id = "apotheosis_RAGE_AURA",
        ui_name = "$perk_apotheosis_rage_aura",
        ui_description = "$perk_apotheosis_rage_aura_description",
        ui_icon = "mods/Apotheosis/files/ui_gfx/perk_icons/rage_aura_perk_ui.png",
        perk_icon = "mods/Apotheosis/files/items_gfx/rage_aura_perk.png",
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
    })
else
    table.insert(perk_list,
    {
        id = "apotheosis_RAGE_AURA",
        ui_name = "$perk_apotheosis_rage_aura",
        ui_description = "$perk_apotheosis_rage_aura_description",
        ui_icon = "mods/Apotheosis/files/ui_gfx/perk_icons/rage_aura_perk_ui.png",
        perk_icon = "mods/Apotheosis/files/items_gfx/rage_aura_perk.png",
        not_in_default_perk_pool = true,
        stackable = STACKABLE_NO,
        usable_by_enemies = false,
        func = function( entity_perk_item, entity_who_picked, item_name )
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
                end
            end
        end,
    })
end

if kolmi_dead then
    table.insert(perk_list,
    {
        id = "apotheosis_REVENGE_REFLECTIVE",
        ui_name = "$perk_apotheosis_revenge_reflective",
        ui_description = "$perk_apotheosis_revenge_reflective_description",
        ui_icon = "mods/Apotheosis/files/ui_gfx/perk_icons/revenge_reflection_perk_ui.png",
        perk_icon = "mods/Apotheosis/files/items_gfx/revenge_reflection_perk.png",
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
    })
else
    table.insert(perk_list,
    {
        id = "apotheosis_REVENGE_REFLECTIVE",
        ui_name = "$perk_apotheosis_revenge_reflective",
        ui_description = "$perk_apotheosis_revenge_reflective_description",
        ui_icon = "mods/Apotheosis/files/ui_gfx/perk_icons/revenge_reflection_perk_ui.png",
        perk_icon = "mods/Apotheosis/files/items_gfx/revenge_reflection_perk.png",
        not_in_default_perk_pool = true,
        stackable = STACKABLE_NO,
        usable_by_enemies = false,
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
    })
end