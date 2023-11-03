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
        GamePlaySound( "data/audio/Desktop/materials.bank", "materials/liquid_splash_player", x, y )
        GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/mana_fully_recharged", x, y )
        GamePlaySound( "data/audio/Desktop/animals.bank", "animals/generic/jump", x, y )
        GamePrint("$log_apotheosis_fishing_caught_name")
        local exit = false
        local rarity = 1

        repeat
            local randomfish = 8
            if randomfish < fish_max then
                randomfish = fishmax
            --Debug Data
            --GamePrint("RNG max is " .. (10 - fish_max + rarity))
            if rarity >= fish_max or math.random(1,(randomfish - fish_max + rarity)) > 1 then
                exit = true
            else
                rarity = rarity + 1
                if randomfish > 8 then
                    randomfish = randomfish - 1
            end
       until(exit)

        --1 = normal fish
        --2 = large fish
        --3 = special fish

        --Stock Fish
        local fish_path = "mods/apotheosis/files/entities/projectiles/fishing/proj_fish.xml"
        local fish_type = 1

        if rarity >= 10 then
            --The [REDACTED] is real
            fish_path = "mods/apotheosis/files/entities/projectiles/fishing/proj_fish_red.xml"
            fish_type = 3
            AddFlagPersistent(table.concat({"apothe","osis_card","_unlocked_div","ine_red_fi","sh_unl","ocked"}))
            print(GameTextGetTranslatedOrNot("$log_apotheosis_fish"))

            --Load perk particle effects & audio on fish location if rarity >= 10
            EntityLoad( "data/entities/particles/image_emitters/perk_effect_pacifist.xml", x, y )
            if GameHasFlagRun("apotheosis_red_flag_angler") == false then
                GameAddFlagRun("apotheosis_red_flag_angler")
                GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/orb/create", x, y )
            end
        elseif (rarity % 2 == 0) then
            fish_path = "mods/apotheosis/files/entities/projectiles/fishing/proj_fish_large.xml"
            fish_type = 2
        end

        local fish_id = EntityLoad(fish_path, x, y)
        GameShootProjectile( player_id, x, y, plyr_x, plyr_y, fish_id )

        local fishdatatbl = {
            {
                GlobalsGetValue( "apotheosis_fish_filepath", "data/entities/animals/fish.xml" ),
                GlobalsGetValue( "apotheosis_fishgfx_filepath", "data/enemies_gfx/fish_01.xml" )
            },
            {
                GlobalsGetValue( "apotheosis_fish_large_filepath", "data/entities/animals/fish_large.xml" ),
                GlobalsGetValue( "apotheosis_fish_largegfx_filepath", "data/enemies_gfx/fish_02.xml" )
            },
            {
                "data/entities/animals/fish_red.xml",
                "mods/apotheosis/files/enemies_gfx/fish_red.xml"
            }
        }
        
        do --Prepare fish projectile for fishing
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

        GamePrintImportant( "$log_apotheosis_fishing_caught_name", table.concat({GameTextGetTranslatedOrNot("$log_apotheosis_fishing_caught_desc"),rarity}) )
        EntityKill(entity_id)
    end

--Fish Caught!
elseif math.random(1,2000) <= math.max((fish_max),8) then
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
