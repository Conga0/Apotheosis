dofile("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local victim = EntityGetRootEntity( entity_id )
local pos_x, pos_y = EntityGetTransform(victim)
local inventory = EntityGetFirstComponentIncludingDisabled(victim, "Inventory2Component")
if inventory ~= nil then
    local active_wand = ComponentGetValue2(inventory, "mActualActiveItem")
    if active_wand ~= nil then
        if EntityHasTag(active_wand, "wand") then
            EntityRemoveFromParent(active_wand)
            EntitySetComponentsWithTagEnabled(active_wand,"enabled_in_hand",false)
            EntitySetComponentsWithTagEnabled(active_wand,"enabled_in_inventory",false)
            EntitySetComponentsWithTagEnabled(active_wand,"enabled_in_world",true)
            --EntityKill(active_wand)
            ComponentSetValue2(inventory, "mActualActiveItem", 0)
            ComponentSetValue2(inventory, "mActiveItem", 0)
            EntityLoad("data/entities/animals/AI/wand_ghost.xml", pos_x, pos_y)
            EntitySetTransform(active_wand, pos_x, pos_y)

            --Prevents items from being dropped briefly after having your wand stolen
            --
            --This is most impactful in the heretic fight, where it's easy to have your wand stolen, and because you were likely holding down Left Click to fire your wand at the time
            --the moment your character automatically swaps to an item in their inventory because their wand was stolen; the game will read that Left Click as a "throw item" command, and immediately throw whatever item you swapped to away.
            --The goal of this is to prevent such an interaction from occuring
            local nodrop_items = EntityLoad("mods/Apotheosis/files/entities/misc/hitfx_stealwand_nodrop.xml",pos_x,pos_y)
            EntityAddChild(victim,nodrop_items)
            --EntityAddChild(wand, active_wand)

            --local c= EntityLoad("mods/Apotheosis/files/entities/misc/stealwand_glow.xml",pos_x,pos_y)
            --EntityAddChild(active_wand,c)

            EntityAddComponent2(
                active_wand,
                "LuaComponent",
                {
                    _enabled=true,
                    _tags="enabled_in_inventory,enabled_in_hand,wand_glow",
                    script_source_file = "mods/Apotheosis/files/scripts/projectiles/stealwand_glow_check.lua",
                    execute_every_n_frame = 30,
                    execute_times=-1,
                }
            )

            EntityAddComponent2(
                active_wand,
                "SpriteComponent",
                {
                    _enabled=true,
                    _tags="enabled_in_inventory,enabled_in_hand,enabled_in_world,wand_glow",
                    alpha=0.55,
                    image_file="data/particles/fog_of_war_hole_64.xml",
                    smooth_filtering=true,
                    fog_of_war_hole=true,
                }
            )

            EntityAddComponent2(
                active_wand,
                "LightComponent",
                {
                    _enabled=true,
                    _tags="enabled_in_inventory,enabled_in_hand,enabled_in_world,wand_glow",
                    radius=128,
                    r=255,
                    g=100,
                    b=25,
                    fade_out_time=1.5,
                }
            )

            local comp = EntityAddComponent2(
                active_wand,
                "ParticleEmitterComponent",
                {
                    _enabled=true,
                    _tags="enabled_in_inventory,enabled_in_hand,enabled_in_world,wand_glow",
                    emitted_material_name="spark_purple_bright",
                    lifetime_min=0.2,
                    lifetime_max=0.4,
                    count_min=10,
                    count_max=20,
                    render_on_grid=true,
                    fade_based_on_lifetime=true,
                    cosmetic_force_create=false,
                    airflow_force=1.5,
                    airflow_time=1.9,
                    airflow_scale=0.15,
                    emission_interval_min_frames=1,
                    emission_interval_max_frames=1,
                    emit_cosmetic_particles=true,
                    draw_as_long=true,
                    x_vel_min=-1,
                    x_vel_max=1,
                    y_vel_min=-1,
                    y_vel_max=1,
                    is_emitting=true,
                    velocity_always_away_from_center=180,
                }
            )

            ComponentSetValue2(comp, "gravity", 0, 0)
            ComponentSetValue2(comp, "area_circle_radius", 5, 10)
        end
    end
end


--GamePrint("Victim ID is " .. tostring(victim))
--GamePrint("Entity ID is " .. tostring(entity_id))

EntityKill(entity_id)

--Look buddy, this code here's held together with lighter fluid and gunpowder, no smoking.
--Take away utilities.lua and it magically breaks
--Try to force the wand into the wand ghost's hand and it magically breaks
--Anything else and it magically breaks
--You can try to improve it if you dare, but know no salvation will be waiting for you when the fireworks start cracking