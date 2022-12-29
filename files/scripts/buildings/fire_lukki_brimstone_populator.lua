dofile_once("data/scripts/lib/utilities.lua")

function collision_trigger(brimstone_id)

    --Check to make sure brimstone isn't in the player's inventory
    local parent = EntityGetParent(brimstone_id)
    if parent == 0 then
        --if 1 == 1 then
        if GameHasFlagRun( "apotheosis_fire_lukki_boss_summoned" ) ~= true then
            local entity_id    = GetUpdatedEntityID()
            local pos_x, pos_y = EntityGetTransform( brimstone_id )

            --Makes sure boss can only spawn inside the lava lake instead of inside rock
            if ModIsEnabled("purgatory") then
                if pos_x >= 8610 then pos_x = 8610 end
                if pos_x <= 8264 then pos_x = 8264 end
            else
                if pos_x >= 3046 then pos_x = 3046 end
                if pos_x <= 2631 then pos_x = 2631 end
            end

            --GamePlaySound( "data/audio/Desktop/event_cues.snd", "event_cues/greed_curse/create", pos_x, pos_y)
            local players = EntityGetWithTag("player_unit")
            for i,v in ipairs(players) do
                local x,y = EntityGetTransform(v)
                GamePlaySound( "data/audio/Desktop/animals.bank", "animals/boss_centipede/destroy_face", x, y );
            end

            if ModIsEnabled("nightmare") or ModIsEnabled("purgatory") then
                local eid = EntityLoad( "data/entities/animals/gold_bosses/boss_fire_lukki/boss_fire_lukki.xml", pos_x, pos_y + 150 )
            else
                local eid = EntityLoad( "data/entities/animals/boss_fire_lukki/boss_fire_lukki.xml", pos_x, pos_y + 150 )
            end
            
            GameAddFlagRun("apotheosis_fire_lukki_boss_summoned")
            --EntityKill( brimstone_id )
        end
        EntityKill( entity_id )
        --GamePrint("Brimstone Eaten")
    end
    --GamePrint("Collision Detected")
end