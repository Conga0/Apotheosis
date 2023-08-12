
--function reload_creature_shifts( entity, x, y, debug_no_limits )

    local iter_count = tonumber( GlobalsGetValue( "apotheosis_creature_shift_iteration", "0" ) )
    local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")

    --Debug Helpers
    --print("Running creature_shift_file_refresh.lua")
    --print("iter_count is " .. iter_count)

    --Debugging shift, forces all Forsaken Eyes to be turned into Blind Gazers
    --target = "blindgazer"
    --target2 = "forsaken_eye"
    if iter_count >= 1 then
        repeat 
            
            local targ_count = tostring(iter_count)

            local target = (GlobalsGetValue("apotheosis_global_Cshift_" .. targ_count .. "_targ1", "failed") )
            local target2 = (GlobalsGetValue("apotheosis_global_Cshift_" .. targ_count .. "_targ2", "failed") )

            --Debug helpers
            --print("targ_count is " .. targ_count)
            --print("target is " .. target)
            --print("target2 is " .. target2)
            --print(target2 .. " has turned into " .. target)

            local content = ModTextFileGetContent("data/entities/animals/" .. target .. ".xml")
            local xml = nxml.parse(content)
            xml:add_child(nxml.parse([[
                <ParticleEmitterComponent
                emitted_material_name="fungal_shift_particle_fx"
                offset.x="0"
                offset.y="-0.5"
                x_pos_offset_min="-4"
                x_pos_offset_max="4"
                y_pos_offset_min="-12"
                y_pos_offset_max="4"
                x_vel_min="-5"
                x_vel_max="5"
                y_vel_min="-10"
                y_vel_max="-30"
                count_min="2"
                count_max="3"
                lifetime_min="0.4"
                lifetime_max="1.0"
                create_real_particles="0"
                emit_cosmetic_particles="1"
                emission_interval_min_frames="4"
                emission_interval_max_frames="12"
                gravity.y="-10"
                is_emitting="1" >
            </ParticleEmitterComponent>
            ]]))

            if target2 == "esoteric_being" then
                xml:add_child(nxml.parse([[
                <LuaComponent
                    script_source_file="mods/Apotheosis/files/scripts/animals/esoteric_being_shifted_smoke.lua"
                    execute_every_n_frame="1"
                    remove_after_executed="1"
                    >
                </LuaComponent>
                ]]))
            end

            ModTextFileSetContent("data/entities/animals/" .. target2 .. ".xml", tostring(xml))

            iter_count = iter_count - 1
        
        until (iter_count == 0)
    end
--end
