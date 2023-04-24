function shot( proj_id )
    if EntityHasTag(proj_id,"tablet") then
        local ghost_id = 0
        local x,y = EntityGetTransform(proj_id)
        local targets = EntityGetWithTag("glue_NOT")
        for k=1,#targets
        do local v = targets[k]
            --GamePrint("shoot")
            --GamePrint("entityname is " .. EntityGetName(v))
            if EntityGetName(v) == "$animal_playerghost" then
                ghost_id = v
                EntitySetComponentsWithTagEnabled( v, "disabled_by_liquid", true )
                EntitySetComponentsWithTagEnabled( v, "enabled_by_liquid", false )

                --Set Tablet catching cooldown
                local comps = EntityGetComponentIncludingDisabled(v,"VariableStorageComponent")
                for k=1,#comps
                do local v = comps[k]
                    if ComponentGetValue2(v,"name") == "tablet_path" then
                        ComponentSetValue2(v,"value_int",GameGetFrameNum())
                        ComponentSetValue2(v,"value_string","")
                    end
                end

                --Disable Tablet Sprite
                local kids = EntityGetAllChildren(ghost_id)
                for z=1,#kids
                do local c = kids[z]
                    EntitySetComponentsWithTagEnabled( c, "enabled_by_liquid", false )
                end
                --local comp = EntityGetFirstComponentIncludingDisabled(v,"SpriteComponent")
                --ComponentSetValue2(comp,"image_file","mods/apotheosis/files/enemies_gfx/playerghost/playerghost.xml")
            end
        end

        --Make the tablet do damage to players
        EntityAddComponent2(
			proj_id,
			"LuaComponent",
			{
				execute_on_added = false,
				script_source_file = "mods/apotheosis/files/scripts/animals/playerghost/tablet_damage.lua",
                script_item_picked_up = "mods/apotheosis/files/scripts/animals/playerghost/tablet_damage.lua",
				execute_every_n_frame = 1,
				remove_after_executed = false,
				execute_times=90
			}
		)

        --Give the Tablet it's VSC data back
        EntityAddComponent2(
			proj_id,
			"VariableStorageComponent",
            {   
                name="obj_path",
                value_string=EntityGetFilename(proj_id),
                value_int=ghost_id
            }
		)
    end
end