
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
--local worldsize = tonumber((ModTextFileGetContent("data/compatibilitydata/worldsize.txt") or 35840)) --If the player enters West 2 or East 2, this triggers; multiply by 0.5 for West 1 and East 1
--worldsize = worldsize * 0.5
local parallel = GetParallelWorldPosition(pos_x, pos_y)

if parallel ~= 0 and GlobalsGetValue("apotheosis_plane_fail", "0") == "0" and GameHasFlagRun("apotheosis_everything") == false then

    local comps = EntityGetComponentIncludingDisabled(entity_id,"LuaComponent")
    for k=1,#comps
    do local v = comps[k]
        GlobalsSetValue("apotheosis_plane_fail", "1")
        GameScreenshake( 200 )
	EntityLoad("mods/Apotheosis/files/entities/particles/image_emitters/parallel_hint.xml", pos_x, pos_y)
	GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/bomb_holy/create", pos_x, pos_y )
	local world_id = GameGetWorldStateEntity()
	local rid = EntityLoad("mods/Apotheosis/files/entities/misc/rain_water_ice.xml", 0, 0)
	EntityAddChild( world_id, rid )
        --if ComponentGetValue2(v,"script_source_file") == "mods/Apotheosis/files/scripts/magic/player_parallel_check.lua" then   --Turn self off
        --    EntitySetComponentIsEnabled(entity_id,v,false)
        --    break
        --end
    end
end

--DONOTDELETETHIS

--Scale Vampirism Healing to be percentage based
--100 hp = 1x rate
--200 hp = 2x rate
--50,000 hp = 500x rate
--etc
--Updates every 10 seconds
local hpcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
local hp = ComponentGetValue2(hpcomp,"max_hp")
local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"IngestionComponent")
ComponentSetValue2(comp,"blood_healing_speed",math.max(0.0024 * (hp / 4), 0.0024))
--Scale suffocation damage to be percentage based
--Scales at half the default rate
--100 hp = 1x rate
--200 hp = 1x rate
--400 hp = 2x rate
--800 hp = 4x rate
--4000 hp = 20x rate
--etc
ComponentSetValue2(hpcomp,"air_lack_of_damage",math.max(0.3 * (hp / 4), 0.6))

--Removes old extra life perks
--dofile( "mods/Apotheosis/files/scripts/DEBUG/clear_extra_lifes.lua" )

--Ensure you never. Never spawn, even if you get the relevent flag mid-run.
RemoveFlagPersistent("this_should_never_spawn")

if GameHasFlagRun("apotheosis_everything") and parallel ~= 0 then
    --Have the player teleported back to the main world if they try to enter parallels in Tuonela
    local c = EntityLoad("mods/Apotheosis/files/entities/misc/tuonela_rubberband.xml",pos_x,pos_y)
	EntityLoad("mods/Apotheosis/files/entities/particles/image_emitters/parallel_hint_yellow.xml", pos_x, pos_y)
    EntityAddChild(entity_id,c)

    GamePrintImportant( "$logdesc_temple_spawn_guardian", "" )
    GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/angered_the_gods/create", pos_x, pos_y )
    GameScreenshake( 150 )
    --The PW boss spam was meant to act as a deterrent to prevent people from endlessly farming parallel world perks for easy power,
    --but this both proved ineffective and lead to frustration due to the PW boss count causing severe slow down.
    --Both of these outcomes are unintentional and much like the normal ascension quest, the only way to stop people from visiting parallel worlds is to remove them all-together.
    --Although technically there is a second option of completely reworking parallel worlds, this comes with it's own problems which I'll leave as an exercise for you, the comment viewer.
end