dofile_once("data/scripts/lib/utilities.lua")


local entity_id = GetUpdatedEntityID()
local enemy_list = EntityGetWithTag( "mortal" )

for id,enemy in pairs(enemy_list) do
    if EntityHasTag(enemy, "c_shifted") ~= true then

        local iter_count = tonumber( GlobalsGetValue( "apotheosis_creature_shift_iteration", "0" ) )

        if iter_count >= 1 then
            repeat 
                
                local targ_count = tostring(iter_count)

                local target1 = (GlobalsGetValue("apotheosis_global_Cshift_" .. targ_count .. "_targ1", "failed") )
                local target2 = (GlobalsGetValue("apotheosis_global_Cshift_" .. targ_count .. "_targ2", "failed") )

                local temp_filepath = EntityGetFilename(enemy)
                local temp_filename = temp_filepath:match("([^/]*)$")
                if temp_filename == table.concat({target2,".xml"}) then

                    local health = 0
                    local max_health = 0

                    local pos_x,pos_y = EntityGetTransform(enemy)
                    local shiftto = EntityLoad("data/entities/animals/" .. target1 .. ".xml", pos_x, pos_y)
                    --GamePrint(tostring(target1))

                    local comp = EntityGetFirstComponent(enemy, "DamageModelComponent" )
                    if comp ~= nil then
                        max_health = ComponentGetValue2(comp, "max_hp")
                        health = ComponentGetValue2(comp, "hp")
                    end
        
                    local comp = EntityGetFirstComponent(shiftto, "DamageModelComponent" )
                    if comp ~= nil then
                        ComponentSetValue2(comp, "max_hp", max_health)
                        ComponentSetValue2(comp, "hp", health)
                    end

                    --Adds fungal shift particles to the creature
                    local pcomp = EntityAddComponent2(
                        shiftto,
                        "ParticleEmitterComponent",
                        {
                            emitted_material_name="fungal_shift_particle_fx",
                            x_pos_offset_min=-4,
                            x_pos_offset_max=4,
                            y_pos_offset_min=-12,
                            y_pos_offset_max=4,
                            x_vel_min=-5,
                            x_vel_max=5,
                            y_vel_min=-10,
                            y_vel_max=-10,
                            count_min=2,
                            count_max=3,
                            is_trail=false,
                            trail_gap=1,
                            fade_based_on_lifetime=true,
                            lifetime_min=0.5,
                            lifetime_max=1.2,
                            airflow_force=0.6,
                            airflow_time=0.401,
                            airflow_scale=0.05,
                            create_real_particles=false,
                            emit_cosmetic_particles=true,
                            render_on_grid=true,
                            emission_interval_min_frames=4,
                            emission_interval_max_frames=12,
                            is_emitting=true,
                        }
                    )
                    --We can't set these values inherently when creating a new component via lua, so set them here instead
                    ComponentSetValue2(pcomp, "offset", 0, -0.5)
                    ComponentSetValue2(pcomp, "gravity", 0, -10)
                    
                    EntityKill(enemy)
                end


                iter_count = iter_count - 1
            
            until (iter_count == 0)
        end
    end
end


--TODO: Add smoke fx