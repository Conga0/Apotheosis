local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local liquiform = RaytraceSurfacesAndLiquiform(x, y, x, y+1)
local platform = RaytracePlatforms(x, y, x, y+1)
local bob_vel = 8
local fish_max = (tonumber(GlobalsGetValue( "APOTHEOSIS_FISHING_SKILL", "0" )) + 1)
if liquiform and not platform then
    local velcomp = EntityGetFirstComponent(entity_id, "VelocityComponent") --[[@cast velcomp number]]
    local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")
    ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y-bob_vel)
    local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")
end

-- Particle logic
local vsccomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local line_target = EntityGetAllChildren(ComponentGetValue2(vsccomp,"value_int"))[1] or 0
if line_target == 0 then return end

if ComponentGetIsEnabled(EntityGetFirstComponentIncludingDisabled(ComponentGetValue2(vsccomp,"value_int"),"LuaComponent")) == false then
    EntityKill(entity_id)
end

--Draws a fishing line from the bobber to the rod
local target_x , target_y, rotation = EntityGetTransform(line_target)
if rotation > -1.57 and rotation < 1.57 then
    rotation = rotation + 0.19
else
    rotation = rotation - 0.19
end

local target_x = target_x + (math.cos( rotation ) * 26)
local target_y = target_y + (math.sin( rotation ) * 26)
local vars = EntityGetComponentIncludingDisabled(entity_id, "ParticleEmitterComponent", "disabled_at_start") or {}
for i = 1, #vars do
    if target_x and target_y then
        ComponentSetValue2(vars[i], "mExPosition", target_x, target_y)
    end
end

--local target_x = math.cos( rotation ) * 22
--local vel_y = 0 - math.cos( angle ) * 100

local isfishing = ComponentGetValue2(vsccomp,"value_bool")

--Do the Fishing
if isfishing then
    --"Fish is tugging on the bait" animation
    if math.random(1,40) == 1 then
        local velcomp = EntityGetFirstComponent(entity_id, "VelocityComponent") --[[@cast velcomp number]]
        local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")
        ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y+(bob_vel * 5))
        local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")
    end

    local player_id = EntityGetWithTag("player_unit")[1]
    local plyr_x, plyr_y = EntityGetTransform(player_id)
    local controlscomp = EntityGetFirstComponent(player_id, "ControlsComponent")

    --Reel a fish in
    if ComponentGetValue2(controlscomp, "mButtonDownLeftClick") or InputIsJoystickButtonDown(0, 48) then
        local liquid = CellFactory_GetName( ComponentGetValue2(vsccomp,"value_float") )
        GamePlaySound( "data/audio/Desktop/materials.bank", "materials/liquid_splash_player", x, y )
        GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/mana_fully_recharged", x, y )
        GamePlaySound( "data/audio/Desktop/animals.bank", "animals/generic/jump", x, y )
        local exit = false
        local rarity = 1
	local odd = false
        local throw = 1

        repeat
            --Debug Data
            --GamePrint("RNG max is " .. (10 - fish_max + rarity))
            if rarity >= fish_max or math.random(1,(8 - fish_max + rarity)) > 1 then
                exit = true
            else
                rarity = rarity + 1
            end
        until(exit)

        --1 = normal fish
        --2 = large fish
        --3 = special fish

        --Stock Fish
        local fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_fish.xml"
        local fish_type = 1
                --Debug
                --fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_firemage_weak.xml"
                --odd = true
                --fish_type = 17
                --throw = 4
        if liquid == "lava" then --fish_lava
            fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_fish_large.xml"
            fish_type = 5
        elseif liquid == "radioactive_liquid" then --fish_toxic
            fish_type = 6
        elseif liquid == "blood" then --apotheosis_leech
            odd = true
            fish_type = 8
        end

        if rarity >= 10 then
            --The [REDACTED] is real
            fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_fish_red.xml"
            fish_type = 3
            AddFlagPersistent(table.concat({"apothe","osis_card","_unlocked_div","ine_red_fi","sh_unl","ocked"}))
            print(GameTextGetTranslatedOrNot("$log_apotheosis_fish"))

            --Load perk particle effects & audio on fish location if rarity >= 10
            EntityLoad( "data/entities/particles/image_emitters/perk_effect_pacifist.xml", x, y )
            if GameHasFlagRun("apotheosis_red_flag_angler") == false then
                GameAddFlagRun("apotheosis_red_flag_angler")
                GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/orb/create", x, y )
            end
        elseif (rarity >= 6) and (rarity % 2 == 0) then
            local alternative = (math.random(1,5) == 1)
            fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_eel.xml"
            fish_type = 10
            if liquid == "lava" then
                alternative = (math.random(1,4) == 1)
                if alternative == false then
                    fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_lukki_fire_tiny.xml"
                    odd = true
                    fish_type = 11
                else --You can thank Conga for coming up with this one
                    fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_firemage_weak.xml"
                    odd = true
                    fish_type = 17
                end
            elseif liquid == "radioactive_liquid" then
                alternative = (math.random(1,2) == 1)
                if alternative == false then
                    fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_slimeshooter.xml"
                    odd = true
                    fish_type = 12
                else
                    fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_bubble_acid.xml"
                    odd = true
                    fish_type = 14
                end
            elseif liquid == "blood" then
                alternative = (math.random(1,2) == 1)
                if alternative == false then
                    fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_meatmaggot.xml"
                    odd = true
                    fish_type = 13
                else
                    fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/skull.xml"
                    odd = true
                    fish_type = -1
                    throw = 4
                end
            elseif alternative == true then
                fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_sunken_creature.xml"
                odd = true
                fish_type = 15
            end
        elseif (rarity >= 6) then
            fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_waterskull.xml"
            fish_type = 16
            odd = true
            if liquid == "lava" then --fish_flesh (replace with cooler thing later)
                fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_lukki_fire_tiny.xml"
                odd = true
                fish_type = 4
            elseif liquid == "radioactive_liquid" then --Toxic Worm Egg
                fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_summon_toxic_worm.xml"
                odd = true
                fish_type = -1
            elseif liquid == "blood" then --fish_flesh (replace with blood guy later)
                odd = true
                fish_type = 9
            end
        elseif (rarity % 2 == 0) then
            fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_fish_large.xml"
            fish_type = 2
            if liquid == "lava" then
                fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_egg_volcanic_lukki.xml"
                odd = true
                fish_type = -1
                throw = 1
            elseif liquid == "radioactive_liquid" then --fish_toxic_large
                fish_type = 7
            elseif liquid == "blood" then --fish_flesh
                odd = true
                fish_type = 9
            end
        end

        local supa_rare = (math.random(1,100) == 1)
	if rarity < 10 then
        if liquid == "lava" then
            supa_rare = (math.random(1,1000) == 1)
            if supa_rare and GameHasFlagRun( "apotheosis_fire_lukki_boss_summoned" ) ~= true then
                local players = EntityGetWithTag("player_unit")
                for i,v in ipairs(players) do
                    local p_x,p_y = EntityGetTransform(v)
                    GamePlaySound( "data/audio/Desktop/animals.bank", "animals/boss_centipede/destroy_face", p_x, p_y );
                end
                fish_path = "data/entities/animals/boss_fire_lukki/boss_fire_lukki.xml"
                odd = true
                fish_type = -1
                GameAddFlagRun("apotheosis_fire_lukki_boss_summoned")
                throw = 1
            end
        elseif liquid == "radioactive_liquid" then
            supa_rare = (math.random(1,50) == 1)
            if supa_rare then
                fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_barrel_radioactive.xml"
                odd = true
                fish_type = -1
                throw = 1
            end
        elseif liquid == "blood" then --(replace with cooler thing later)
            supa_rare = (math.random(1,100) == 1)
            if supa_rare then
                fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_meatmaggot.xml"
                odd = true
                fish_type = 13
                throw = 1
            end
        else
            supa_rare = (math.random(1,math.max(50 - ((fish_max-1)*5),25)) == 1) -- After 5 angler skills it reaches max of 1/25
            if supa_rare then
                fish_path = "mods/Apotheosis/files/entities/projectiles/fishing/proj_chest_random_clam.xml"
                odd = true
                fish_type = -1
                throw = 1
            end
        end
        end

        local mult_x = (plyr_x - x)*(throw - 1)
        local mult_y = (plyr_y - y)*(throw - 1)

        local fish_id = EntityLoad(fish_path, x, y)
        GameShootProjectile( player_id, x, y, plyr_x+mult_x, plyr_y+mult_y, fish_id )

        local fishdatatbl = {
            {
                GlobalsGetValue( "apotheosis_cs_fish_filepath", "data/entities/animals/fish.xml" ),
                GlobalsGetValue( "apotheosis_fishgfx_filepath", "data/enemies_gfx/fish_01.xml" )
            },
            {
                GlobalsGetValue( "apotheosis_cs_fish_large_filepath", "data/entities/animals/fish_large.xml" ),
                GlobalsGetValue( "apotheosis_fish_largegfx_filepath", "data/enemies_gfx/fish_02.xml" )
            },
            {
                "data/entities/animals/fish_red.xml",
                "mods/Apotheosis/files/enemies_gfx/fish_red.xml"
            },
            { --oopsie, unused
                GlobalsGetValue( "apotheosis_cs_lukki_fire_tiny_filepath", "data/entities/animals/lukki_fire_tiny.xml" ),
                GlobalsGetValue( "apotheosis_lukki_fire_tinygfx_filepath", "mods/Apotheosis/files/enemies_gfx/fire_lukki/lukki_fire_tiny.xml" )
            },
            {
                "data/entities/animals/fish_lava.xml",
                "mods/Apotheosis/files/enemies_gfx/fish_lava.xml"
            },
            {
                "data/entities/animals/fish_toxic.xml",
                "mods/Apotheosis/files/enemies_gfx/fish_toxic_01.xml"
            },
            {
                "data/entities/animals/fish_toxic_large.xml",
                "mods/Apotheosis/files/enemies_gfx/fish_toxic_02.xml"
            },
            {
                "data/entities/animals/apotheosis_leech.xml",
                "mods/Apotheosis/files/enemies_gfx/leech.xml"
            },
            {
                "data/entities/animals/fish_flesh.xml",
                "mods/Apotheosis/files/enemies_gfx/fish_flesh.xml"
            },
            {
                GlobalsGetValue( "apotheosis_cs_eel_filepath", "data/entities/animals/eel.xml" ),
                GlobalsGetValue( "apotheosis_eelgfx_filepath", "data/enemies_gfx/eel_head.png" )
            },
            {
                GlobalsGetValue( "apotheosis_cs_lukki_fire_tiny_filepath", "data/entities/animals/lukki_fire_tiny.xml" ),
                GlobalsGetValue( "apotheosis_lukki_fire_tinygfx_filepath", "mods/Apotheosis/files/enemies_gfx/fire_lukki/lukki_fire_tiny.xml" )
            },
            {
                GlobalsGetValue( "apotheosis_cs_slimeshooter_filepath", "data/entities/animals/slimeshooter.xml" ),
                GlobalsGetValue( "apotheosis_slimeshootergfx_filepath", "data/enemies_gfx/slimeshooter.xml" )
            },
            {
                GlobalsGetValue( "apotheosis_cs_meatmaggot_filepath", "data/entities/animals/meatmaggot.xml" ),
                GlobalsGetValue( "apotheosis_meatmaggotgfx_filepath", "data/enemies_gfx/meatmaggot_head.xml" )
            },
            {
                GlobalsGetValue( "apotheosis_cs_bubble_liquid_filepath", "data/entities/animals/bubbles/acid/bubble_liquid.xml" ),
                GlobalsGetValue( "apotheosis_bubble_liquidgfx_filepath", "mods/Apotheosis/files/enemies_gfx/bubble_liquid_acid.xml" )
            },
            {
                GlobalsGetValue( "apotheosis_cs_sunken_creature_filepath", "data/entities/animals/sunken_creature.xml" ),
                GlobalsGetValue( "apotheosis_sunken_creaturegfx_filepath", "mods/Apotheosis/files/enemies_gfx/sunken_creature.xml" )
            },
            {
                GlobalsGetValue( "apotheosis_cs_waterskull_filepath", "data/entities/animals/waterskull.xml" ),
                GlobalsGetValue( "apotheosis_waterskullgfx_filepath", "mods/Apotheosis/files/enemies_gfx/waterskull.png" )
            },
            {
                GlobalsGetValue( "apotheosis_cs_firemage_weak_filepath", "mods/Apotheosis/files/entities/projectiles/fishing/firemage_weak.xml" ),
                GlobalsGetValue( "apotheosis_firemage_weakgfx_filepath", "mods/Apotheosis/files/projectiles_gfx/firemage_scuba_spin.xml" )
            },
        }
        
        if fish_type ~= -1 then
        if fish_type == 10 or fish_type == 13 then --Special treatment for meatmaggot and eel
            local comp = EntityGetFirstComponentIncludingDisabled(fish_id, "ProjectileComponent")
            ComponentSetValue2(comp,"spawn_entity",fishdatatbl[fish_type][1])

            local spritecomp = EntityGetFirstComponentIncludingDisabled(fish_id, "SpriteComponent")
            ComponentSetValue2(spritecomp,"image_file",fishdatatbl[fish_type][2])
        else --Prepare fish projectile for fishing
            local comp = EntityGetFirstComponentIncludingDisabled(fish_id, "ProjectileComponent")
            ComponentSetValue2(comp,"spawn_entity",fishdatatbl[fish_type][1])

            EntityAddComponent2(
                fish_id,
                "SpriteComponent",
                {
                    _tags="character",
                    alpha=1,
                    image_file=fishdatatbl[fish_type][2],
                    rect_animation="walk"
                }
            )
        end
        end

        local caught_name = "$log_apotheosis_fishing_caught_name"
        if odd == true then
            caught_name = "$log_apotheosis_fishing_caught_weird_name"
        end

        GamePrint(caught_name)
        local rarity_text = GameTextGetTranslatedOrNot("$log_apotheosis_fishing_caught_desc")
        rarity_text = rarity_text:gsub("$0",rarity)
        GamePrintImportant( caught_name, rarity_text)
        EntityKill(entity_id)
    end

--Fish Caught!
elseif math.random(1,2000) <= math.max((fish_max),8) and RaytraceSurfacesAndLiquiform(x, y, x, y+3) and not RaytracePlatforms(x, y, x, y+3) then
    ComponentSetValue2(vsccomp,"value_bool",true)

    local velcomp = EntityGetFirstComponent(entity_id, "VelocityComponent") --[[@cast velcomp number]]
    local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")
    ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y+(bob_vel * 6))
    local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")

    GamePlaySound( "data/audio/Desktop/materials.bank", "materials/liquid_splash_player", x, y )
    GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/mana_fully_recharged", x, y )

    --Enables water particle effects
    EntitySetComponentIsEnabled(entity_id,EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteParticleEmitterComponent"),true)
end