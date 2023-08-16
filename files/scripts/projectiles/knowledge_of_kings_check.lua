
local entity_id = GetUpdatedEntityID()
local pos_x,pos_y = EntityGetTransform(entity_id)
EntityLoad("mods/apotheosis/files/entities/particles/circle_king.xml", pos_x, pos_y)

if HasFlagPersistent( "apotheosis_card_unlocked_secret_knowledge_of_kings" ) or GameHasFlagRun( "apotheosis_card_unlocked_secret_knowledge_of_kings_complete_2" ) then
    GamePrint("$secretmessage_apotheosis_kingly_alreadydone")
elseif GameHasFlagRun( "apotheosis_card_unlocked_secret_knowledge_of_kings_complete" ) == false then
    GamePrint("$secretmessage_apotheosis_kingly_cheater")
else
    
    -- flag to make sure it doesn't appear in future runs
    AddFlagPersistent( "apotheosis_card_unlocked_secret_knowledge_of_kings" )
    AddFlagPersistent( "apotheosis_card_unlocked_secret_knowledge_of_kings_spell" )
    GameAddFlagRun( "apotheosis_card_unlocked_secret_knowledge_of_kings_complete" )
    GameAddFlagRun( "apotheosis_card_unlocked_secret_knowledge_of_kings_complete_2" )
    GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
    GameTriggerMusicEvent( "music/oneshot/heaven_03", true, pos_x, pos_y )


    --Gives Cape after casting "The Knowledge of Kings" spell
    local players = EntityGetWithTag("player_unit")
    for i,player in ipairs(players) do
        EntityAddComponent2(
            player,
            "LuaComponent",
            {
                script_source_file="data/apotheosis_gfx/player_cape_colour_append.lua",
                execute_every_n_frame=1,
                execute_times=1,
                remove_after_executed=true
            }
        )
    end

	local message_title = "$secretmessage_apotheosis_capeget_name"
	local message_desc = "$secretmessage_apotheosis_capeget_desc"

    --Previously this rolled the credits, but this has been moved into to the "Ascension" ending
    --local player_id = EntityGetWithTag("player_unit")[1]
    --local x,y = EntityGetTransform(player_id)
	--local credits = EntityLoad("mods/Apotheosis/files/entities/the_end/credits_horscht_wait.xml", x, y)
    --EntityAddChild(player_id,credits)
	
	GamePrintImportant( message_title, message_desc )

end
