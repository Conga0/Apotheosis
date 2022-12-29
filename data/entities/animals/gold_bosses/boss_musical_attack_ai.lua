dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local orbcount = GameGetOrbCountThisRun()

local comp = EntityGetFirstComponent( entity_id, "AnimalAIComponent" )
local x,y = EntityGetTransform( entity_id )

SetRandomSeed(x, y * GameGetFrameNum())

state = Random( 1, 3 )

    if (state == 1) then
        ComponentSetValue2( comp, "attack_ranged_entity_file", "mods/Apotheosis/files/entities/projectiles/musical_attack_shotgun_homing.xml" )
        ComponentSetValue2( comp, "attack_ranged_frames_between", 100 )
        ComponentSetValue2( comp, "attack_ranged_min_distance", 0 )
        ComponentSetValue2( comp, "attack_ranged_max_distance", 300 )
        ComponentSetValue2( comp, "attack_ranged_entity_count_min", 6 )
        ComponentSetValue2( comp, "attack_ranged_entity_count_max", 8 )
    elseif (state == 2) then
        ComponentSetValue2( comp, "attack_ranged_entity_file", "mods/Apotheosis/files/entities/projectiles/meteor_npc_superhoming.xml" )
        ComponentSetValue2( comp, "attack_ranged_frames_between", 200 )
        ComponentSetValue2( comp, "attack_ranged_min_distance", 0 )
        ComponentSetValue2( comp, "attack_ranged_max_distance", 600 )
        ComponentSetValue2( comp, "attack_ranged_entity_count_min", 3 )
        ComponentSetValue2( comp, "attack_ranged_entity_count_max", 4 )
    else
        ComponentSetValue2( comp, "attack_ranged_entity_file", "mods/Apotheosis/files/entities/projectiles/summon_musical_being_bighp.xml" )
        ComponentSetValue2( comp, "attack_ranged_frames_between", 400 )
        ComponentSetValue2( comp, "attack_ranged_min_distance", 0 )
        ComponentSetValue2( comp, "attack_ranged_max_distance", 250 )
        ComponentSetValue2( comp, "attack_ranged_entity_count_min", 4 )
        ComponentSetValue2( comp, "attack_ranged_entity_count_max", 5 )
    end