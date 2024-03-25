dofile("data/scripts/lib/utilities.lua")

--If you're looking through these files trying to figure out how Creature Shifting works, you've come to the right place.
--Much like the folder name implies, this is where the magic happens.
--I don't think I documented everything, but you should be able to fill in the gaps, it's a pretty simple system.
--Just replace creature's xml data with the one you want and add a lua script to the player so any already-spawned cretins get transformed too

--10/02/2024 Conga: If you want your creature from another mod to be focus shiftable, simply add it to the vanilla _list.txt file.
--If you want it to be added to the random pool, I recommend gsubbing into the enemy_list for shift victims,
--and enemy_list_from for shift-to targets

local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
local enemy_list
local enemy_list_from
local entity = EntityGetWithTag( "player_unit" )
local x, y = EntityGetTransform( entity )
local year, month, day, hour, minute, second = GameGetDateAndTimeLocal()

--SetRandomSeed( second + minute, second + minute + 3 )
--Seeded RNG

--Top list is modded enemies + vanilla; bottom is only modded enemies
--ModFileSetContent doesn't work on vanilla enemies past initiation stages of the game.. but works perfectly fine on modded creatures? Sure thing, whatever you say dude

--enemy_list = { "bubbles/freezing_liquid/bubble_liquid", "bubbles/ambrosia/bubble_liquid", "blindgazer", "forsaken_eye", "gazer_greater", "gazer_greater_cold", "gazer_greater_sky", "gazer_robot", "ghost_bow", "giant_centipede", "goo_slug", "ccc_bat_psychic", "ceiling_fungus", "devourer_magic", "drone_mini", "esoteric_being", "fairy_cheap", "fairy_big", "fairy_big_discord", "fairy_esoteric", "hideous_mass", "hisii_engineer", "hisii_giga_bomb", "hisii_rocketshotgun", "locust_swarm", "lukki_fungus", "lukki_swarmling", "mimic_explosive_box", "musical_being_weak", "poisonmushroom", "poring", "poring_holy", "poring_magic", "rat_birthday", "sentry", "star_child", "shaman_greater_apotheosis", "tank_flame_apotheosis", "tentacler_big", "triangle_gem", "whisp", "whisp_big", "wizard_ambrosia", "wizard_copeseethmald", "wizard_duck", "wizard_explosive", "wizard_manaeater", "wizard_transmutation", "wizard_firemage_greater", "wizard_z_poly_miniboss", "wraith_weirdo_shield", "acidshooter", "alchemist", "ant", "assassin", "barfer", "bat", "bigfirebug", "bigzombie", "miniblob", "bloodcrystal_physics", "bloom", "chest_mimic", "crystal_physics", "drone_physics", "enlightened_alchemist", "failed_alchemist", "failed_alchemist_b", "firebug", "firemage", "fireskull", "flamer", "fly", "frog", "frog_big", "fungus", "fungus_big", "gazer", "ghoul", "giant", "giantshooter", "healerdrone_physics", "icer", "iceskull", "lasershooter", "longleg", "maggot", "miner", "miner_fire", "missilecrab", "monk", "necromancer", "necromancer_shop", "phantom_a", "phantom_b", "rat", "roboguard", "scavenger_clusterbomb", "scavenger_heal", "scavenger_grenade", "scavenger_leader", "scavenger_mine", "scavenger_poison", "scavenger_smg", "shooterflower", "shotgunner", "skullfly", "skullrat", "slimeshooter", "sniper", "spitmonster", "statue_physics", "tank", "tank_rocket", "tank_super", "tentacler", "tentacler_small", "thundermage", "thunderskull", "wizard_dark", "wizard_neutral", "wizard_poly", "wizard_returner", "wizard_swapper", "wizard_tele", "wolf", "wraith", "wraith_glowing", "wraith_storm", "zombie", "skycrystal_physics", "scavenger_shield", "spearbot", "goblin_bomb", "necrobot", "ethereal_being", }

--Full enemy list, specifically for "focused shift" victims
--Includes creatures that wouldn't be exciting to be creature shifted normally, but the player can choose to focus on when shifting to change them
local enemy_list_full = { "ant", "ant_fire", "ant_suffocate", "bubbles/freezing_liquid/bubble_liquid", "miniblob", "blob", "drone_status_ailment", "enchanted_duck", "eel", "firebug", "bigfirebug", "fairy_big_discord", "fairy_esoteric", "fish", "fish_large", "forsaken_eye", "frog", "frog_big", "fungus", "fungus_big", "fungus_giga", "fungus_smoking_creep", "gazer", "ghost_bow", "giant_centipede", "goo_slug", "ccc_bat_psychic", "ceiling_fungus", "devourer_magic", "drone_mini", "esoteric_being", "fairy_cheap", "fairy_big", "hiisi_thief", "hideous_mass", "hisii_engineer", "hisii_rocketshotgun", "lukki_swarmling", "longleg", "poring", "mudman_friendly", "poisonmushroom", "poring_magic", "sentry", "shaman", "shaman_greater_apotheosis", "tank_flame_apotheosis", "tentacler_small", "tentacler", "tentacler_big", "tesla_turret", "triangle_gem", "whisp", "whisp_big", "wizard_duck", "wraith_returner_apotheosis", "wraith_weirdo_shield",  "scavenger_grenade", "scavenger_smg", "tank", "tank_rocket", "tank_super", "wand_ghost", "ultimate_killer", "miner_weak", "miner", "shotgunner_weak", "shotgunner", "slime_leaker_weak", "slime_leaker", "seeker", "wraith_alchemy_apotheosis", "rat", "plague_rat", "bat", "bigbat", "zombie_weak", "zombie", "firemage_weak", "firemage", "giant", "miner_fire", "fireskull", "fly", "necromancer_shop", "necromancer_super" }


--"Shift from" list to randomly pick from
enemy_list = { "ant_fire", "ant_suffocate", "bubbles/freezing_liquid/bubble_liquid", "fish", "forsaken_eye", "fungus_smoking_creep", "gazer", "ghost_bow", "giant_centipede", "ccc_bat_psychic", "ceiling_fungus", "devourer_magic", "drone_mini", "esoteric_being", "fairy_cheap", "fairy_big", "hideous_mass", "hisii_engineer", "hisii_rocketshotgun", "lukki_swarmling", "longleg", "mudman_friendly", "poisonmushroom", "poring_magic", "sentry", "shaman_greater_apotheosis", "tank_flame_apotheosis", "tentacler_big", "tesla_turret", "triangle_gem", "whisp", "whisp_big", "wizard_duck", "wraith_returner_apotheosis", "wraith_weirdo_shield",  "scavenger_grenade", "scavenger_smg", "wand_ghost", "miniblob", }

--"Shift into" list to randomly pick from
enemy_list_from = { "ant_fire", "ant_suffocate", "bubbles/freezing_liquid/bubble_liquid", "fish", "forsaken_eye", "fungus_smoking_creep", "gazer", "ghost_bow", "giant_centipede", "ccc_bat_psychic", "ceiling_fungus", "devourer_magic", "drone_mini", "esoteric_being", "fairy_cheap", "fairy_big", "hideous_mass", "hisii_engineer", "hisii_rocketshotgun", "lukki_swarmling", "longleg", "mudman_friendly", "poisonmushroom", "poring_magic", "sentry", "shaman_greater_apotheosis", "tank_flame_apotheosis", "tentacler_big", "tesla_turret", "triangle_gem", "whisp", "whisp_big", "wizard_duck", "wraith_returner_apotheosis", "wraith_weirdo_shield", "scavenger_grenade", "scavenger_smg", "wand_ghost", "miniblob", "lukki_fungus", "star_child", "wizard_manaeater", "blindgazer", "wizard_z_poly_miniboss", "wizard_explosive", "waterskull", "alchemist", "ant", "assassin", "barfer", "bat", "bigfirebug", "bigzombie", "blob", "bloodcrystal_physics", "bloom", "chest_mimic", "crystal_physics", "drone_physics", "enlightened_alchemist", "failed_alchemist", "failed_alchemist_b", "firebug", "firemage", "fireskull", "flamer", "fly", "frog", "frog_big", "fungus", "fungus_big", "gazer", "ghoul", "giant", "giantshooter", "healerdrone_physics", "icer", "iceskull", "lasershooter", "longleg", "maggot", "miner", "miner_fire", "missilecrab", "monk", "necromancer", "necromancer_shop", "phantom_a", "phantom_b", "rat", "roboguard", "scavenger_clusterbomb", "scavenger_heal", "scavenger_grenade", "scavenger_leader", "scavenger_mine", "scavenger_poison", "shooterflower", "shotgunner", "skullfly", "skullrat", "slimeshooter", "sniper", "spitmonster", "statue_physics", "tank", "tank_rocket", "tank_super", "tentacler", "tentacler_small", "thundermage", "thunderskull", "wizard_dark", "wizard_neutral", "wizard_poly", "wizard_returner", "wizard_swapper", "wizard_tele", "wolf", "wraith", "wraith_glowing", "wraith_storm", "zombie", "skycrystal_physics", "scavenger_shield", "spearbot", "goblin_bomb", "necrobot", "ethereal_being", "hideous_mass_red", "tree_tall", "hisii_giga_bomb", "mimic_explosive_box", "bubbles/ambrosia/bubble_liquid", "watermage", "watermage_greater", "wizard_copeseethmald", "miniboss_pit_02", }


local shift_check = false
local shift_check_2 = false
local from_creature_name = "DEBUG ERROR"

--TODO create custom messages for these
log_messages = 
{
	"$log_apotheosis_reality_mutation_00",
	"$log_apotheosis_reality_mutation_01",
	"$log_apotheosis_reality_mutation_02",
	"$log_apotheosis_reality_mutation_03",
	"$log_apotheosis_reality_mutation_04",
	"$log_apotheosis_reality_mutation_05",
}


--for minidrones shifting because they have an attack different from their base one.. maybe use a variable storage component in it's base to check if
--it's a real minidrone or a shifted creature?

--This function generates ui images when they're needed during runtime.
--Look for "--Makes the Creature Shift Icon available to be editted during run-time" in init.lua for the setup functions necessary for this to function.
function update_ui_graphic( ui_name, offset_y )
    --print(table.concat({"ui_name is ",ui_name}))
    --GamePrint(table.concat({"ui_name is ",ui_name}))
    --Quick test to see if the requested entity has been prepared by the virtual file system.
    if ModImageDoesExist(table.concat({"data/ui_gfx/animal_icons/creature_shift/",ui_name,".png"})) == false then return false end

    --print("ui name is " .. ui_name)
	local csi_id = ModImageIdFromFilename( "data/ui_gfx/animal_icons/creature_shift/creature_shift_ui.png")
    local csi_from_id = ModImageIdFromFilename( table.concat({"data/ui_gfx/animal_icons/",ui_name,".png"}))
    local csi_from_id_output = ModImageIdFromFilename( table.concat({"data/ui_gfx/animal_icons/creature_shift/",ui_name,".png"}))
    --print("csi_from_id path is " .. table.concat({"data/ui_gfx/animal_icons/",ui_name,".png"}))
    --print("csi_from_id_output path is " .. table.concat({"data/ui_gfx/animal_icons/creature_shift/",ui_name,".png"}))
    if csi_from_id == 0 then print("Invalid image ID") return false end
    for x=1,16 do
        for y=1,16 do
            --Paint the base layer for the ui portrait
            ModImageSetPixel( csi_from_id_output, x, y, ModImageGetPixel( csi_id, x, y ) )
            --Paint the ui icon over the base layer
            if (x > 3 and y > 2) and (x < 13 and y < 12) then
                local colour = ModImageGetPixel( csi_from_id, x, y )
                if colour ~= 0 then
                    ModImageSetPixel( csi_from_id_output, x, y + offset_y, colour )
                end
            end
        end
    end

    --Clean up the border to look pretty
    local border_colour = ModImageGetPixel(csi_id, 5,2)
    ModImageSetPixel( csi_from_id_output, 4, 3, border_colour )
    ModImageSetPixel( csi_from_id_output, 12, 3, border_colour )
    ModImageSetPixel( csi_from_id_output, 4, 11, border_colour )
    ModImageSetPixel( csi_from_id_output, 12, 11, border_colour )
    return true
end

function get_distance( x1, y1, x2, y2 )
	local result = math.sqrt( ( x2 - x1 ) ^ 2 + ( y2 - y1 ) ^ 2 )
	return result
end



function creature_shift( entity, x, y, debug_no_limits )
    local player_id = EntityGetWithTag( "player_unit" )[1]

    if GameHasFlagRun("apotheosis_flag_no_tripping") then
        local frame = GameGetFrameNum()
        local last_frame = tonumber( GlobalsGetValue( "apotheosis_shift_block_last_frame", "-1000000" ) )
        if frame > last_frame + 60*60*3 then --3 minute long cooldown between messages
            GamePrintImportant( "$log_apotheosis_shift_blocked_name", "$log_apotheosis_shift_blocked_desc" )
			GlobalsSetValue( "apotheosis_shift_block_last_frame", tostring(frame))
        end
        return
    end

    local parent = EntityGetParent( entity )
	if parent ~= 0 then
		entity = parent
	end
    --local entity_id = parent

    local frame = GameGetFrameNum()
    local last_frame = tonumber( GlobalsGetValue( "apotheosis_creature_shift_last_frame", "-1000000" ) )
    if frame < last_frame + 60*60*4 and not debug_no_limits then --4 minute long cooldown between shifts
        shift_check = false --long cooldown
    else
        shift_check = true
    end

    local iter = tonumber( GlobalsGetValue( "apotheosis_creature_shift_iteration", "0" ) )
    if iter > 30 and not debug_no_limits then
        shift_check_2 = false --max shifts hit (30)
    else
        shift_check_2 = true
    end

    
    SetRandomSeed( 8888 + iter, 7777 + iter )

    --debug to spam it
    --[[
    shift_check = true
    shift_check_2 = true
    ]]--

    if (shift_check == true) and (shift_check_2 == true) then


        --Actual enemy shift
        --First, we increment the shift interger
        GlobalsSetValue( "apotheosis_creature_shift_iteration", tostring(iter+1) )


        --Grabs Target enemy (the shift-to target) & Target2 Enemy (the victim)

        rnd = Random(1, #enemy_list)
        local target2 = enemy_list[rnd]
        table.remove(enemy_list, rnd)
        --Conga: I don't know why I'm only removing from the table if NE is enabled.. autocorrect typo?
        --Maybe some attempt to reduce likelyhood of clones? I genuinely don't know
        table.remove(enemy_list_from, rnd)


        local rnd = Random(1, #enemy_list_from)
        local target = enemy_list_from[rnd]
        table.remove(enemy_list, rnd)

        --Prioritise an enemy if the player is mousing over them, only applies to valid shift targets
        --75% Chance
        local frng = Random(1,4)
        --print("frng is " .. frng)
        if frng > 0 then
            --print("player id is " .. player_id)
            local controls = EntityGetFirstComponentIncludingDisabled(player_id, "ControlsComponent")  --[[@cast controls number]]
            local cursor_x, cursor_y = ComponentGetValue2(controls, "mMousePosition")
            local cursor_tab = EntityGetInRadiusWithTag(cursor_x, cursor_y, 35, "mortal") or {"null"}
            local temp_cursor_data = {"enemyfilename",100}

            --Cycle through enemy shift list and see if targetted enemy isn't a boss, if not, choose the closest enemy to the mouse cursor
            if cursor_tab[1] ~= "null" then
                for z=1,#cursor_tab do
                    if EntityHasTag(cursor_tab[z],"player_unit") == false and EntityHasTag(cursor_tab[z],"boss") == false and EntityHasTag(cursor_tab[z],"miniboss") == false and EntityHasTag(cursor_tab[z],"boss_dragon") == false then
                        local filename = EntityGetFilename(cursor_tab[z])
                        local cursor_tx, cursor_ty = EntityGetTransform(cursor_tab[z])

                        local dist = get_distance(cursor_x,cursor_y,cursor_tx,cursor_ty)
                        --Remember data
                        if dist < temp_cursor_data[2] then
                            temp_cursor_data[1] = filename
                            temp_cursor_data[2] = dist
                        end
                    end
                end
            end

            --Make the targetted enemy the shift victim
            if temp_cursor_data[1] ~= "enemyfilename" then
                local temp_filepath = temp_cursor_data[1]
                local temp_filename = temp_filepath:match("([^/]*)$")
                temp_filename = temp_filename:gsub(".xml", "")

                target2 = temp_filename
            end
        end


        print(table.concat({"Attempting to creature shift \"",target2,"\" into \"",target,"\""}))

        local ui_offset_y = 0
        if target2 == "miniblob" then
            ui_offset_y = -4
        end

        local successful_image_update = update_ui_graphic( target2, ui_offset_y )


        --Debugging shift, forces all bats to be turned into triangular gems
        --target = "triangle_gem"
        --target2 = "bat"

        --target2 = "esoteric_being"
        --Debugging helper
        --GamePrint(target2 .. " has turned into " .. target)
        --GamePrint("The minute is " .. minute)



        local nxml = dofile_once("mods/Apotheosis/lib/nxml.lua")
        --local setContent = ModTextFileSetContent() Apparantly ModTextFileSetContent works after init if you save a reference to it... somehow?
        --"Yea, ModTextFileSetContent won't be available after initialisation but SetContent will be"
        --"but you can't make any more modifications after a file has been loaded; even if you save a reference to the function"
        --"If you use dofile("xx.lua") from init.lua then ModTextFileSetContent will also be available there."
        --"can't you just unload the entities and load the shift target in their place instead of swapping their file contents?"
        --"I could.. but that'd require rewriting everything I have from the base up, unless you mean unloading the entity from the game's memory?"
        --"no just a script on the entity that kills itself and spawns the other entity in it's place"
        local content = ModTextFileGetContent(table.concat({"data/entities/animals/",target2,".xml"}))
        local xml = nxml.parse(content)
        local creature_name_get = xml.attr.name




        local content = ModTextFileGetContent(table.concat({"data/entities/animals/",target,".xml"}))
        local xml = nxml.parse(content)
        if xml.attr.tags ~= nil then
            xml.attr.tags = xml.attr.tags .. ",c_shifted" --Prevents the player updater script from needlessly updating creatures
        end
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
            lifetime_min="0.5"
            lifetime_max="1.2"
            create_real_particles="0"
            emit_cosmetic_particles="1"
            emission_interval_min_frames="4"
            emission_interval_max_frames="12"
            gravity.y="-10"
            fade_based_on_lifetime="1"
            is_emitting="1" >
        </ParticleEmitterComponent>
        ]]))

        --If the creature being shifted away is an Esoteric Being, add a smoke effect for when it awakens
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

        --If the creature being shifted away is a creature who's spawned by other means (onscreen) then update their filepath here
        --Conga: I wanted the bat to have their projectile graphic updated too, but it ended up being a really deep rabbit hole to grab the necessary data

        --Updates filepath data dynamically to use in edge cases (fishing up shifted fish, spawning shifted mudmen from mud, etc)
        GlobalsSetValue( table.concat({"apotheosis_cs_",target2,"_filepath"}), table.concat({"data/entities/animals/",target,".xml"}) )

        ModTextFileSetContent("data/entities/animals/" .. target2 .. ".xml", tostring(xml))

        from_creature_name = GameTextGetTranslatedOrNot(creature_name_get)

        --Add smoke particles to victim
        --Target = The shift-to target
        --Target2 = The Victim, the one being shifted

        --Bat specific projectile fix for when being launched by big bat
        if target2 == "bat" then
            local eid = EntityLoad(table.concat({"data/entities/animals/",target,".xml"}),0,0)
            local gfx = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(eid,"SpriteComponent"),"image_file")
            if gfx == "" then
                gfx = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(eid,"PhysicsImageShapeComponent"),"image_file")
            end
            GlobalsSetValue( "apotheosis_batgfx_filepath", gfx )
            EntityKill(eid)
        end

        --Fish specific projectile fix for when being reeled in from a fishing rod
        if target2 == "fish" then
            local eid = EntityLoad(table.concat({"data/entities/animals/",target,".xml"}),0,0)
            local gfx = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(eid,"SpriteComponent"),"image_file")
            if gfx == "" then
                gfx = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(eid,"PhysicsImageShapeComponent"),"image_file")
            end
            GlobalsSetValue( "apotheosis_fishgfx_filepath", gfx )
            EntityKill(eid)
        end

        --Fish Large specific projectile fix for when being reeled in from a fishing rod
        if target2 == "fish_large" then
            local eid = EntityLoad(table.concat({"data/entities/animals/",target,".xml"}),0,0)
            local gfx = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(eid,"SpriteComponent"),"image_file")
            if gfx == "" then
                gfx = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(eid,"PhysicsImageShapeComponent"),"image_file")
            end
            GlobalsSetValue( "apotheosis_fish_largegfx_filepath", gfx )
            EntityKill(eid)
        end


        






    -- fx
        -- remove tripping effect
        -- This needs to be updated to the custom status effect when it's implemented
        local entity_id_table = EntityGetWithTag( "player_unit" )
        entity_id_status = entity_id_table[1]
        EntityRemoveIngestionStatusEffect( entity_id_status, "apotheosis_TRIP_RED" );

        -- audio
        GameTriggerMusicFadeOutAndDequeueAll( 5.0 )
        GameTriggerMusicEvent( "music/oneshot/tripping_balls_01", false, x, y )

        -- particle fx
        --[[
        local eye
        if y == nil then
            eye = EntityLoad( "data/entities/particles/treble_eye.xml", x, y - 10 )
        else
            eye = EntityLoad( "data/entities/particles/treble_eye.xml", x, -105 )
        end
        --having trouble detecting y, code belives it's a nil value
        if eye ~= 0 then
            EntityAddChild( entity, eye )
        end
        ]]--

        -- log
        local log_msg = ""
        if from_creature_name ~= "" then
            from_creature_name = GameTextGetTranslatedOrNot( from_creature_name )
			log_msg = GameTextGet( "$logdesc_reality_mutation", from_creature_name )
            GamePrint( log_msg )
        end
        GamePrintImportant( random_from_array( log_messages ), log_msg, "mods/Apotheosis/files/ui_gfx/decorations/3piece_creature_shift.png" )
        GlobalsSetValue( "apotheosis_creature_shift_last_frame", tostring(frame) )

        -- add ui icon
        local add_icon = true
        local children = EntityGetAllChildren(EntityGetWithTag( "player_unit" ))
        if children ~= nil then
            for i,it in ipairs(children) do
                if ( EntityGetName(it) == "creature_shift_ui_icon" ) then
                    add_icon = false
                    break
                end
            end
        end

        local icon_name = target2
        if icon_name == "bubbles/freezing_liquid/bubble_liquid" then
            icon_name = "bubble_liquid"
        end

        -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

        local desc_1 = GameTextGetTranslatedOrNot("$status_apotheosis_creature_shifted_desc")
        local creature_shift_description = table.concat({desc_1,"\n",from_creature_name})
        local ui_sprite_path = "data/ui_gfx/animal_icons/creature_shift/creature_shift_ui_backup.png"

        if successful_image_update then
            ui_sprite_path = table.concat({"data/ui_gfx/animal_icons/creature_shift/",icon_name,".png"})
        end

        if add_icon then
            local icon_entity = EntityCreateNew( "creature_shift_ui_icon" )
            local spritepath = 
            EntityAddComponent( icon_entity, "UIIconComponent", 
            { 
                name = "$status_apotheosis_creature_shifted_name",
                description = "$status_apotheosis_creature_shifted_desc",
                --icon_sprite_file = "mods/Apotheosis/files/ui_gfx/status_indicators/creature_shift_perk.png"
                icon_sprite_file = ui_sprite_path
            })
            local targets = EntityGetWithTag( "player_unit" )

            for i,v in ipairs( targets ) do
                if ( v ~= player__id ) then
                    EntityAddChild( v, icon_entity )
                end
            end
        end

        --[[
        --  Updates Creature description to the new creature name
        local targets = EntityGetInRadius( x, y, 30 )
        for i,v in ipairs( targets ) do
            if ( v ~= entity_id ) and ( EntityGetName( v ) == "creature_shift_ui_icon" ) then
                local comp = EntityGetFirstComponent( v, "UIIconComponent" )
                ComponentSetValue2( comp, "description", creature_shift_description )
            end
        end
        ]]--

        --  Updates Creature icon to the new creature icon
        local targets = EntityGetInRadius( x, y, 30 )
        for i,v in ipairs( targets ) do
            if ( v ~= player_id ) and ( EntityGetName( v ) == "creature_shift_ui_icon" ) then
                local comp = EntityGetFirstComponent( v, "UIIconComponent" )
                ComponentSetValue2( comp, "icon_sprite_file", ui_sprite_path )
                x, y = EntityGetTransform( v )
            end
        end

        local iter_glob = tonumber( GlobalsGetValue( "apotheosis_creature_shift_iteration", "0" ) )
        GlobalsSetValue(table.concat({"apotheosis_global_Cshift_",iter_glob,"_targ1"}), tostring(target) )
        GlobalsSetValue(table.concat({"apotheosis_global_Cshift_",iter_glob,"_targ2"}), tostring(target2) )

        


        --Debugging
        --[[
        local target = (GlobalsGetValue("apotheosis_global_Cshift_" ..iter .. "_targ1", "failed") )
        local target2 = (GlobalsGetValue("apotheosis_global_Cshift_" .. iter .. "_targ2", "failed") )

        GamePrint(target)
        GamePrint(target2)
        ]]--

        --Updates old, already created entities to be shifted to their new form
        --Makes sure to only apply the lua script once
        --The lua script may be removed between restarts actually.. hmm
        --Perhaps a child entity would be better?
        --
        --Then again, a half-budgeted approach might be best, update entities until the player needs to restart
        --Stop consuming resources on this task after the player restarts, and then they probably won't notice or remember the shift later?
        --I just don't want to be resource intensive, bluntly.
        --
        --Updates every 2.5 seconds
        --
        --
        --nxml shifted creatures retain their filepath.. troublesome but a reasonable conclusion I overlooked in pursuit of envisioning how to accomplish other goals
        --Apply 'acid' tag to all shifted creatures, then only update if taken care of?
        --
        --[[
        ]]--

        --Add a lua script to the player as an emergency backup option for creature shifting
        --Conga: Unnecessary since creature_shift_file_refresh.lua has been fixed! (Thankyou me) (Obama medal meme)
        --Conga 03/07/2023: We might actually need this because already serialised entities can't be updated via setting contents
        --[[
        ]]--
        do
            local player_list = EntityGetWithTag("player_unit")
            for k=1,#player_list
            do local v = player_list[k]

                local valid = true

                local luacomps = EntityGetComponentIncludingDisabled(v,"LuaComponent")
                for z=1,#luacomps
                do local c = luacomps[z]
                    if ComponentGetValue2(c,"script_source_file") == "mods/Apotheosis/files/scripts/magic/creature_shift_new/player_shift_update.lua" then
                        local x,y = EntityGetTransform(v)
                        local pp = EntityGetInRadiusWithTag(x,y,512,"c_shifted") or {}
                        for h=1,#pp do
                            EntityRemoveTag(pp[h]"c_shifted")
                        end
                        valid = false
                        break
                    end
                end

                if valid then
                    EntityAddComponent2(
                        v,
                        "LuaComponent",
                        {
                            execute_on_added = true,
                            script_source_file = "mods/Apotheosis/files/scripts/magic/creature_shift_new/player_shift_update.lua",
                            execute_every_n_frame = 180, --Updates every 3 seconds
                            remove_after_executed = false,
                            execute_times=-1
                        }
                    )
                end
            end
        end

        if ModIsEnabled("fungal_timer") and not debug_no_limits then
            local player_list = EntityGetWithTag("player_unit")
            for i,v in ipairs(player_list) do
                
                local x, y = EntityGetTransform( v )
                local cid = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_status_creatureshift_cd_visual.xml", x, y )
                EntityAddChild( v, cid )
            end
        end

    end
end
