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
    if ComponentGetValue2(controlscomp, "mButtonDownLeftClick") then
        GamePlaySound( "data/audio/Desktop/materials.bank", "materials/liquid_splash_player", x, y )
        GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/mana_fully_recharged", x, y )
        GamePlaySound( "data/audio/Desktop/animals.bank", "animals/generic/jump", x, y )
        GamePrint("You caught a fish!")
        local exit = false
        local rarity = 1

        repeat
            --Debug Data
            --GamePrint("RNG max is " .. (10 - fish_max + rarity))
            if rarity >= fish_max or math.random(1,(10 - fish_max + rarity)) > 1 then
                exit = true
            else
                rarity = rarity + 1
            end
        until(exit)

        local fish_path = "mods/apotheosis/files/entities/projectiles/fishing/proj_fish.xml"
        if rarity >= 10 then
            --The [REDACTED] is real
            fish_path = "mods/apotheosis/files/entities/projectiles/fishing/proj_fish_red.xml"
            AddFlagPersistent(table.concat({"apothe","osis_card","_unlocked_div","ine_red_fi","sh_unl","ocked"}))
            print(GameTextGetTranslatedOrNot("$log_apotheosis_fish"))

            --Load perk particle effects & audio on fish location if rarity >= 10
            EntityLoad( "data/entities/particles/image_emitters/perk_effect_pacifist.xml", x, y )
        elseif (rarity % 2 == 0) then
            fish_path = "mods/apotheosis/files/entities/projectiles/fishing/proj_fish_large.xml"
        end
        local fish_id = EntityLoad(fish_path, x, y)
        GameShootProjectile( player_id, x, y, plyr_x, plyr_y, fish_id )

        GamePrintImportant( "You caught a fish!", table.concat({"Rarity: ",rarity}) )
        EntityKill(entity_id)
    end

--Fish Caught!
elseif math.random(1,2000) <= math.max((fish_max),4) then
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