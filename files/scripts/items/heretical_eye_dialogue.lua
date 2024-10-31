--Devoted seeker of dissident utterings, know this. 
--We are watching you.
--[[
                                          
              ####%%%%%%####              
          ######################          
        ############::==++++######        
      ######++==##++..==++++++######      
    ##########==++::  ::++==++########    
    ####++++##==::::  ::::==++##++####    
  ######++==++++::..  ::::++++==++++####  
  ######++====::::      ::::====++######  
  %%##++++++==::::      ::::++########%%  
  %%##++======::..      ..::====++++##%%  
  %%######++==::::      ::::========##%%  
  ####++======::::      ::::====########  
  ######++##++==::::  ..::++======######  
    ########====::::  ::::++++==++####    
    ######++======::  ::==++##########    
      ######++==++==..++##==++######      
        ######==##==::####++######        
          ######################          
              ####%%%%%%####              
                                          
]]--
dofile_once("data/scripts/lib/utilities.lua") --Tired Sinning
--Hello yes thank you Graham for letting me "borrow" this :) - Spoop

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local cam_x, cam_y, cam_w, cam_h = GameGetCameraBounds()
local radius = math.floor((cam_w / 4) * 3)

-- Specific scenario for the Sheep Ending
if #EntityGetWithTag("player_unit") < 1 and #EntityGetInRadiusWithTag(x,y,radius,"player_unit") < 1 and not GameHasFlagRun("apotheosis_heretalk_end_sheep_2") then 
    --Debug Data
    --print("no playor?") 
return end -- don't speak when there's no player
--Conga: Might be funny if he made fun of your death
--"You crawl into my tomb, crack my coffin open, rend MY flesh apart, but you die to a purple freak because he turned you into a sheep? You're pathetic"
--Spoop: Maaayyybee...
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
math.randomseed(x+y)
SetRandomSeed(x + GameGetFrameNum(), y + 1394)
-- how talkative Mr. Heretical is
local rate = 10
-- how big Mr. Heretical's text is
local size_x = 0.8
local size_y = 0.8
-- how hard to hear Mr. Heretical is
local alpha = 0.8
-- bags of many support
local stashed = false
if ModIsEnabled("bags_of_many") and EntityGetParent(entity_id) ~= 0 then
    local parent_id = EntityGetParent(entity_id)
    local player_id = EntityGetParent(parent_id)
    if EntityHasTag(player_id, "bags_of_many") then
	alpha = alpha - 0.2
	stashed = true
    end
end
-- what tone of voice Mr. Heretical uses when speaking
local tone = "norm"
-- "norm" is normal speech
-- "power" is when he's being intimidating or imposing
-- "gossip" is when he makes an off handed comment or something
-- ^ one of the sounds sort of sound like a laugh so you could also use it for when he's joking
-- "quiet" is when he's trying to be quiet, only really used in the introduction
-- "yell" is when he's screaming at you, only really used for mountain altar (and now destroying the stone :) )
-- "long" is when there's a lot of dialogue, mostly when informing/scolding you of something
-- "pained" is when he's dying, only one use scenario
-- will default to "norm" if nothing is given
local stone_over = false
-- if Mr. Heretical is pouting, then when true this will overwrite that and have him say something
local num = 0
-- used for checking the number of the current message more easily

--Move functions outside of checks so they can be accessed from the file globally*
function Speak(entity, text, pool)

    --Debug Data
    --print("did we get this far?")

    --Prevents Heretic from inturrupting himself (speaking again if he's already speaking)
    local textComponent = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent", "graham_speech_text")
    if textComponent then return end

    local old_text = text
    local x, y = EntityGetTransform(entity_id)
    SetRandomSeed(entity_id + x + 2352, GameGetFrameNum() - y + 24806)

    local offset_y = 26

    ---- All dialogue handling should go above this point ----

    -- here lies some terrible width code that has since been replaced
    -- thank you to Evaisa (and Copi) for making this not trash
    local gui = GuiCreate()
    GuiStartFrame(gui)
    local offset_x = GuiGetTextDimensions( gui, text, size_x ) * 0.625
    GuiDestroy(gui)

    EntityAddTag(entity, "graham_speaking")
    EntityAddComponent2(entity, "SpriteComponent", {
        _tags = "enabled_in_world, enabled_in_hand, enabled_in_inventory, graham_speech_text",    --Conga: This could be tag optimised... Spoop: sShhuhshshshush...
        image_file = "mods/Apotheosis/files/fonts/font_pixel_flesh.xml",
        emissive = true,
        is_text_sprite = true,
        offset_x = offset_x,
        offset_y = offset_y,
        alpha = alpha,
        update_transform = true,
        update_transform_rotation = false,
        text = text,
        has_special_scale = true,
        special_scale_x = size_x,
        special_scale_y = size_y,
        z_index = -9000,
        never_ragdollify_on_death = true
    })

    local luacomp = EntityGetFirstComponentIncludingDisabled(entity, "LuaComponent", "graham_speech_quiet")
    if luacomp then EntityRemoveComponent(entity, luacomp) end

    EntityAddComponent2(entity, "LuaComponent", {
        _tags= "enabled_in_world, enabled_in_hand, enabled_in_inventory, graham_speech_quiet",
        execute_every_n_frame = 120 + (#text * rate), --Starting at 2 seconds, every letter adds 10 frames to the dialogue duration.
        script_source_file="mods/Apotheosis/files/scripts/items/heretical_eye_dialogue_quiet.lua"
    })
end

--List of one-time dialogue events
--Not so one-time now >:) -Spoop
local events = {
    {
        trigger = function()
            if GameHasFlagRun("heretic_dead_dead") then
                stone_over = true
                rate = 2
                alpha = 0.7
                local d_opts = {"...Help me."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "pained"
                return true, dialogue
            end
            return false
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("heretic_dead_dead") then
                stone_over = true
                rate = 2
                alpha = 0.6
                local d_opts = {"I'm decaying..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "pained"
                return true, dialogue
            end
            return false
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("heretic_dead_dead") then
                stone_over = true
                rate = 2
                alpha = 0.5
                local d_opts = {"...Please."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "quiet"
                return true, dialogue
            end
            return false
        end
    },
    {
        trigger = function()
            local stone_death = EntityGetInRadiusWithTag( x, y, 400, "curse" ) or {}
            for cd=1,#stone_death do
                if EntityGetName(stone_death[cd]) == "stone_heretic_death_check" then
                    stone_over = true
                    size_x = 1.0
                    size_y = 1.0
                    local d_opts = {"NOOO!"}
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    rate = 2
                    tone = "yell"
                    GameScreenshake( 50 )
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
            	stone_over = true
                    size_x = 0.9
                    size_y = 0.9
            	local d_opts = {"You witless idiot!"}
            	local dialogue = d_opts[math.random(1,#d_opts)]
                rate = 2
            	tone = "yell"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
            	stone_over = true
            	local d_opts = {"What were you thinking?"}
            	local dialogue = d_opts[math.random(1,#d_opts)]
                rate = 2
            	tone = "power"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
            	stone_over = true
            	local d_opts = {"You are an utter fool!"}
            	local dialogue = d_opts[math.random(1,#d_opts)]
                rate = 2
            	tone = "power"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
            	stone_over = true
            	local d_opts = {"Barely understanding the ramifications of your mindless actions!"}
            	local dialogue = d_opts[math.random(1,#d_opts)]
                rate = 3
            	tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
            	stone_over = true
            	local d_opts = {"You are undeserving of any potential that stone held within!"}
            	local dialogue = d_opts[math.random(1,#d_opts)]
                rate = 2
            	tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
            	stone_over = true
            	local d_opts = {"And undeserving of any further utterances from me!"}
            	local dialogue = d_opts[math.random(1,#d_opts)]
                rate = 2
            	tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
            	stone_over = true
            	local d_opts = {"You lost."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	tone = "power"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 12
            local currbiome = BiomeMapGetName( x, y )
            local heretic_unstashed = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsBodyComponent" )
            if not GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") then
		tone = "power"
                local d_opts = {"You shouldn't be tampering with things out of your understanding..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                rate = 2
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+1))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+2))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+3))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+4))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+5))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+6))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+7))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+8))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+9))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+10))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+11))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+12))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+13))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+14))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+15))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+16))
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 13
            local heretic_unstashed = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsBodyComponent" )
            if ComponentGetIsEnabled(heretic_unstashed) == false then
            	local d_opts = {"What is it?","Well, what do you have to say?","Look who it is..."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+3))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+4))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+5))
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 14
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
            	local d_opts = {"Can you hear me in that mind of yours?"}
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 15
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) and HasFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_03") then
                local d_opts = {"You look betrayed... odd."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local d_opts = {"Kirottu!","Royhkea!"}
            local dialogue = d_opts[math.random(1,#d_opts)]
	    tone = "power"
            rate = 2
            size_x = 1.0
            size_y = 1.0
            alpha = 0.5
            return true, dialogue
        end
    },
    {
        trigger = function()
            local d_opts = {"ugh..."}
            local dialogue = d_opts[math.random(1,#d_opts)]
	    tone = "quiet"
            rate = 2
            size_x = 0.75
            size_y = 0.75
            alpha = 0.35
            return true, dialogue
        end
    },
    {
        trigger = function()
            local d_opts = {"...alchemist..","...curses.."}
            local dialogue = d_opts[math.random(1,#d_opts)]
	    tone = "quiet"
            rate = 2.5
            size_x = 0.6
            size_y = 0.6
            alpha = 0.3
            return true, dialogue
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") and GameHasFlagRun("apotheosis_heretalk_id_14") and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
		local time_spent = 14400
		local initial_frame = 0
                local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
		initial_frame = tonumber(ComponentGetValue2( timercomp, "value_string"))
		local fled = tonumber(GlobalsGetValue("HERETIC_COWARDLY", "0"))
		if GameHasFlagRun( "apotheosis_miniboss_boss_flesh_monster_stone" ) then
		    fled = fled - 1
		end
		if (initial_frame + time_spent >= GameGetFrameNum()) and (fled >= 4) then
            	    local d_opts = {"...You know, I have to mention..."}
            	    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 20
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
		local fled = tonumber(GlobalsGetValue("HERETIC_COWARDLY", "0"))
		if GameHasFlagRun( "apotheosis_miniboss_boss_flesh_monster_stone" ) then
		    fled = fled - 1
		end
            	local d_opts = {"Was it really necessarily for you to flee from me " .. fled .. " times?" }
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 21
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
		local fled = tonumber(GlobalsGetValue("HERETIC_COWARDLY", "0"))
		if GameHasFlagRun( "apotheosis_miniboss_boss_flesh_monster_stone" ) then
		    fled = fled - 1
		end
		if fled > 10 then
            	    local d_opts = {"That was quite excessive..."}
		    if GameHasFlagRun("apotheosis_heretalk_cynical") then
            	        d_opts = {"You were rather irritating..."}
			tone = "power"
		    end
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_heretalk_id_14") then
                local hstone = nil
                local herestones = EntityGetInRadiusWithTag( x, y, 175, "poopstone" ) or {}
                for bp=1,#herestones do
                    local shapecomp = EntityGetFirstComponentIncludingDisabled(herestones[bp],"PhysicsImageShapeComponent")
                    if ComponentGetValue2(shapecomp,"image_file") == "mods/Apotheosis/files/items_gfx/goldnugget_01_alt_heretic.png" then
                        hstone = herestones[bp]
                    end
	        end
                local stone_held = EntityGetFirstComponentIncludingDisabled( hstone, "SpriteComponent" )
                local stone_body = EntityGetFirstComponentIncludingDisabled( hstone,"PhysicsBodyComponent")
                if hstone ~= nil and ( ComponentGetIsEnabled(stone_held) == true or ( ComponentGetIsEnabled( stone_body ) == true and EntityGetParent(hstone) == 0 ))then
                    local d_opts = {"That stone holds within' quite the potential..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
            	    tone = "gossip"
                    return true, dialogue
                end
                return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 23
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
            	local d_opts = {"You'd do well keeping it safe."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 24
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if GameHasFlagRun("apotheosis_heretalk_id_14") and currbiome == "$biome_evil_temple" then
		local time_spent = 7200
		local initial_frame = 0
                local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
		initial_frame = tonumber(ComponentGetValue2( timercomp, "value_string"))
		if (initial_frame + time_spent >= GameGetFrameNum()) then
                    local d_opts = {"...This place was forged by us."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 25
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) and currbiome ~= "$biome_evil_temple" and currbiome ~= "???" and currbiome ~= "$biome_orbroom" then
                local d_opts = {"I see you're ready to leave...","Not quite fond of my home?","I suppose that place was getting a little monotonous anyways...","...Not very appreciative of the architecture?","Intriguing..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
	--Since everyone seems to be focused on the finding his home part, just something to get people off his case
        trigger = function()
            num = 26
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"Do you have anything interesting to show?","Do you have something to accomplish?"}
                local dialogue = d_opts[math.random(1,#d_opts)]
            	tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_heretalk_id_14") then
                local worldEntity = GameGetWorldStateEntity()
                local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")
                local time = ComponentGetValue2(comp,"time")
                if y < 0 and (time < 0.30 or time > 0.80) then
                    local d_opts = {"Bright out...","The blinding light from above is not something I expected to see so soon."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
                end
                return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_heretalk_id_14") then
                local worldEntity = GameGetWorldStateEntity()
                local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")
                local time = ComponentGetValue2(comp,"time")
                if y < 0 and (time < 0.30 or time > 0.80) then
                    local d_opts = {"I'm more used to dark catacombs.","It burns lightly."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
                end
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local dialogue = "It can't be..."
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "apotheosis_portal" ) ~= 0 then
            	stone_over = true
            	tone = "power"
		if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
		    dialogue = "It can't be... If only a certain stone was still around."
		    tone = "long"
		end
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "_EMPTY_" then
                if #EntityGetInRadiusWithTag( x, y, 250, "apotheosis_portal" ) ~= 0 then
                    if GameHasFlagRun("apotheosis_heretalk_portal_complete") and tonumber(GlobalsGetValue("apotheosis_plane_fail",0)) ~= 1 then
                        stone_over = true
                        local dialogue = "This is... an impressive feat..."
            		tone = "power"
                        if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                            local d_opts = {"PARDON ME?","WHAT.","HUH?"}
                            dialogue = d_opts[math.random(1,#d_opts)]
                        end
			return true, dialogue
                    elseif GameHasFlagRun("apotheosis_heretalk_portal_fail") and tonumber(GlobalsGetValue("apotheosis_plane_fail",0)) == 1 then
                        stone_over = true
                        GameAddFlagRun("apotheosis_heretalk_broken")
                	local d_opts = {"Oh, you took one too many detours. I believe you serve no more use to me.","You lost your path, I believe you can throw me out now."}
            		tone = "long"
                	local dialogue = d_opts[math.random(1,#d_opts)]
                        if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                            dialogue = "..."
                            tone = "quiet"
                        end
                	return true, dialogue
		    else
                        return false
		    end
                else
                    return false
                end
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local perk_altar = EntityGetInRadiusWithTag( x, y, 300, "curse" ) or {}
            if currbiome == "???" then
                for pa=1,#perk_altar do
                    if EntityGetName(perk_altar[pa]) == "apotheosis_perk_creation_altar" then
            	        local d_opts = {"My pride and joy..."}
			tone = "gossip"
                        local dialogue = d_opts[math.random(1,#d_opts)]
                        return true, dialogue
                    end
	        end
	        return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "ending_sampo_spot_mountain" ) ~= 0 then
            	local d_opts = {"Ah... the altar."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_held = EntityGetFirstComponentIncludingDisabled( entity_id, "SpriteComponent" )
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "ending_sampo_spot_mountain" ) ~= 0 and ComponentGetIsEnabled(heretic_held) == true then
            	stone_over = true
            	local d_opts = {"I heavily wouldn't advise this..."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
		if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
		    dialogue = "I wouldn't recommend this..."
		end
		tone = "power"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 34
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "ending_sampo_spot_mountain" ) ~= 0 and EntityGetWithName( "heretic_killer" ) ~= 0 and ComponentGetIsEnabled( heretic_body ) == true and EntityGetParent(entity_id) == 0 and GameHasFlagRun("heretic_near_death") then
            	stone_over = true
            	rate = 1.0
           	size_x = 1.0
           	size_y = 1.0
            	GameRemoveFlagRun("apotheosis_heretalk_id_" .. tostring(num+1))
            	GameRemoveFlagRun("apotheosis_heretalk_id_" .. tostring(num+2))
            	GameRemoveFlagRun("apotheosis_heretalk_id_" .. tostring(num+3))
            	local d_opts = {"STOP!","TAKE ME OFF OF THIS ALTAR!","I BEG OF YOU!"}
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "yell"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 35
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "ending_sampo_spot_mountain" ) ~= 0 and EntityGetWithName( "heretic_killer" ) ~= 0 and ComponentGetIsEnabled( heretic_body ) == true and EntityGetParent(entity_id) == 0 and GameHasFlagRun("heretic_near_death") then
            	stone_over = true
            	rate = 1.0
           	size_x = 1.0
           	size_y = 1.0
            	GameRemoveFlagRun("apotheosis_heretalk_id_" .. tostring(num-1))
            	GameRemoveFlagRun("apotheosis_heretalk_id_" .. tostring(num+1))
            	GameRemoveFlagRun("apotheosis_heretalk_id_" .. tostring(num+2))
            	GameRemoveFlagRun("apotheosis_heretalk_id_" .. tostring(num+3))
            	local d_opts = {"STOP!","TAKE ME OFF OF THIS ALTAR!","I BEG OF YOU!"}
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "yell"
            	return true, dialogue
            else
                return false
            end
        end
    },
	--Bleh
--[[
    {
        --Thrown onto Mountain Altar 3
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "ending_sampo_spot_mountain" ) ~= 0 and EntityGetWithName( "heretic_killer" ) ~= 0 and ComponentGetIsEnabled( heretic_body ) == true and EntityGetParent(entity_id) == 0 then
            	rate = 2.5
           	size_x = 1.0
           	size_y = 1.0
            	GameRemoveFlagRun("apotheosis_heretalk_id_20")
            	GameRemoveFlagRun("apotheosis_heretalk_id_21")
            	local d_opts = {"TAKE ME OFF OF THIS ALTAR!"}
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        --Thrown onto Mountain Altar 4
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "ending_sampo_spot_mountain" ) ~= 0 and EntityGetWithName( "heretic_killer" ) ~= 0 and ComponentGetIsEnabled( heretic_body ) == true and EntityGetParent(entity_id) == 0 then
            	rate = 2.5
           	size_x = 1.0
           	size_y = 1.0
            	GameRemoveFlagRun("apotheosis_heretalk_id_20")
            	GameRemoveFlagRun("apotheosis_heretalk_id_21")
            	local d_opts = {"IMMEDIATELY!"}
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        --Thrown onto Mountain Altar 5
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "ending_sampo_spot_mountain" ) ~= 0 and EntityGetWithName( "heretic_killer" ) ~= 0 and ComponentGetIsEnabled( heretic_body ) == true and EntityGetParent(entity_id) == 0 then
            	rate = 1.0
           	size_x = 1.0
           	size_y = 1.0
            	GameRemoveFlagRun("apotheosis_heretalk_id_20")
            	GameRemoveFlagRun("apotheosis_heretalk_id_21")
            	local d_opts = {"QUICK!"}
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        --Thrown onto Mountain Altar 6
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "ending_sampo_spot_mountain" ) ~= 0 and EntityGetWithName( "heretic_killer" ) ~= 0 and ComponentGetIsEnabled( heretic_body ) == true and EntityGetParent(entity_id) == 0 then
            	rate = 2.5
           	size_x = 1.0
           	size_y = 1.0
            	GameRemoveFlagRun("apotheosis_heretalk_id_20")
            	GameRemoveFlagRun("apotheosis_heretalk_id_21")
            	local d_opts = {"BEFORE IT'S TOO LATE!"}
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        --Thrown onto Mountain Altar 7
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "ending_sampo_spot_mountain" ) ~= 0 and EntityGetWithName( "heretic_killer" ) ~= 0 and ComponentGetIsEnabled( heretic_body ) == true and EntityGetParent(entity_id) == 0 then
            	rate = 2.5
           	size_x = 1.0
           	size_y = 1.0
            	GameRemoveFlagRun("apotheosis_heretalk_id_13")
            	GameRemoveFlagRun("apotheosis_heretalk_id_15")
            	GameRemoveFlagRun("apotheosis_heretalk_id_16")
            	GameRemoveFlagRun("apotheosis_heretalk_id_17")
            	GameRemoveFlagRun("apotheosis_heretalk_id_18")
            	GameRemoveFlagRun("apotheosis_heretalk_id_19")
            	GameRemoveFlagRun("apotheosis_heretalk_id_20")
            	GameRemoveFlagRun("apotheosis_heretalk_id_21")
            	local d_opts = {"I BEG OF YOU!"}
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	return true, dialogue
            else
                return false
            end
        end
    },
]]--
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "ending_sampo_spot_mountain" ) ~= 0 and GameHasFlagRun("heretic_near_death") and EntityGetWithName( "heretic_killer" ) == 0 then
		stone_over = true
		local d_opts = {"Nearly..."}
		tone = "gossip"
		if GameHasFlagRun("apotheosis_heretalk_cynical") or GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
            	    d_opts = {"Don't do that again..."}
		    tone = "power"
		end
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 37
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if GameHasFlagRun("heretic_near_death") and EntityGetWithName( "heretic_killer" ) == 0 and GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
            	stone_over = true
            	local d_opts = {"..."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "quiet"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 38
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if GameHasFlagRun("heretic_near_death") and EntityGetWithName( "heretic_killer" ) == 0 and GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
            	stone_over = true
            	local d_opts = {"I don't wish to know what they would do to me..."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 39
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if GameHasFlagRun("heretic_near_death") and EntityGetWithName( "heretic_killer" ) == 0 and GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-2)) and GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
            	local d_opts = {"Mmmm... donuts..."}
            	if GameHasFlagRun("heretic_near_death") then
            	    GameRemoveFlagRun("heretic_near_death")	
		end
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
            	return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local prison_spot = EntityGetInRadiusWithTag( x, y, 250, "gate_monster" ) or {}
            if currbiome == "???" then
                for ps=1,#prison_spot do
                    if EntityGetName(prison_spot[ps]) == "apotheosis_flesh_boss_inert" then
                        stone_over = true
            	        local d_opts = {"Changing reality will only make you imprisoned like myself..."}
                        local dialogue = d_opts[math.random(1,#d_opts)]
			tone = "power"
                        return true, dialogue
                    end
	        end
	        return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "miniboss" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$creep_apotheosis_boss_flesh_monster_name" then
                    stone_over = true
                    local d_opts = {"Tampering with fate will do you no good..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "power"
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local prison_spot = EntityGetInRadiusWithTag( x, y, 250, "gate_monster" ) or {}
            if currbiome == "???" then
		local check = 0
                for ps=1,#prison_spot do
                    if EntityGetName(prison_spot[ps]) == "apotheosis_prison_check" then
            	        check = check + 1
                    elseif EntityGetName(prison_spot[ps]) == "apotheosis_flesh_boss_inert" then
            	        check = check - 1
                    end
	        end
                if check == 1 then
            	    local d_opts = {"My imprisonment was unjust..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "power"
                    return true, dialogue
                end
	        return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_orbroom" then
                local d_opts = {"I was never very fond of these...","I believe more in finding your own knowledge."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_orbroom" then
                local d_opts = {"I overheard once that they decrypted unseen scribings within' these tablets..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_desert_pit" then
                local d_opts = {"I suppose nothing lasts.","Our work seems long gone.","Not quite the place it once was...","Do you know what this place once was?"}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_wizardcave" then
                local d_opts = {"Bad memories come with this temple...","Not a very welcoming place to return to..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --Attempt to make it so he talks twice about something, but seems to not work
        --Oh it sure does work now past Spoop : )
        trigger = function()
            num = 47
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"I suppose their appraisal of the gods hasn't gotten them much farther...","Wonder if he is still around..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "power"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local dialogue = "You..."
            local boss_wizar = EntityGetInRadiusWithTag( x, y, 200, "boss_wizard" ) or nil
            local fellow = nil
            for bp=1,#boss_wizar do
		fellow = boss_wizar[bp]
		break
            end
            if (fellow ~= nil and EntityGetName(fellow) == "$animal_boss_wizard" ) then
                stone_over = true
                GameAddFlagRun("apotheosis_heretalk_mom_alive")
		tone = "power"
                return true, dialogue
            elseif GameHasFlagRun("apotheosis_mom_dead") and currbiome == "$biome_mestari_secret" then
                dialogue = "Hmm... I don't sense his presence..."
                return true, dialogue
            elseif currbiome == "$biome_mestari_secret" then
                dialogue = "Hmm... Curious, where's he run off to..."
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_mestari_secret" and GameHasFlagRun("apotheosis_mom_dead") then
                if GameHasFlagRun("apotheosis_heretalk_mom_alive") then
                    stone_over = true
                    local d_opts = {"Farewell, Warden.","His power never last.","How far he has fallen."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
                    return true, dialogue
                else
                    dialogue = "Seems he's already been taken care of..."
		    tone = "gossip"
                    return true, dialogue
		end
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_plane_yggdrasil" then
                stone_over = true
                local d_opts = {"Astonishing..."}
                if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                    d_opts = {"Astonishing... what are you?"}
                end
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_plane_yggdrasil" then
                stone_over = true
                local d_opts = {"The tales were true..."}
                if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                    d_opts = {"...no matter."}
                end
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_plane_yggdrasil" then
                stone_over = true
                local d_opts = {"A realm of vast overgrowth and ascended beings."}
                if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                    d_opts = {"This is the realm of vast overgrowth and ascended beings."}
                end
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_plane_magic" then
                stone_over = true
                local d_opts = {"This knowledge is astounding..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_plane_magic" then
                stone_over = true
                local d_opts = {"A realm of encaptured dreams and exalted magic."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_plane_technology" then
                stone_over = true
                local d_opts = {"Can you comprehend how far we are?"}
                if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                    d_opts = {"This is... hm."}
                end
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_plane_technology" then
                stone_over = true
                local d_opts = {"A realm of destruction and failed experiments."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_plane_technology" then
                stone_over = true
                local d_opts = {"We're so close..."}
                if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                    d_opts = {"You're getting closer..."}
                end
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" then
                stone_over = true
                local d_opts = {"Is this...?","Finally...","I can't believe it..."}
                if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                    d_opts = {"This..."}
                end
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" then
                stone_over = true
                local dialogue = "Continue forward, just a bit further."
                if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                    dialogue = "Yes... it's right up ahead."
                end
		tone = "power"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 60
            local parallel = GetParallelWorldPosition(x, y)
            if parallel ~= 0 and tonumber(GlobalsGetValue("apotheosis_plane_fail",0)) == 1 then
                stone_over = true
            	local d_opts = {"You've made a grave mistake..."}
                if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                    d_opts = {"...Hm."}
                elseif GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num+1)) then
                    d_opts = {"Oh, I see. You appear to have already made quite the grave mistake..."}
                    tone = "long"
                end
            	local dialogue = d_opts[math.random(1,#d_opts)]
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+1))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+2))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+3))
		tone = "power"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 61
            local parallel = GetParallelWorldPosition(x, y)
            if parallel ~= 0 then
            	local d_opts = {"Leave while you still can!"}
		tone = "power"
                if GameHasFlagRun("apotheosis_everything") == true then
                    --Seeds aren't canon so I can be as silly as I want!
                    d_opts = {"Ugh, I never liked these parts of the world anyhow, too much power creep ya know?"}
		    tone = "long"
                end
            	local dialogue = d_opts[math.random(1,#d_opts)]
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+1))
                GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+2))
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local worldsize = tonumber((ModTextFileGetContent("data/compatibilitydata/worldsize.txt") or 35840))
            worldsize = worldsize * 0.475
            if currbiome == "_EMPTY_" and x > worldsize or x < (worldsize * -1) then
            	local d_opts = {"I wouldn't go there...","I'd reconsider this expedition..."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "power"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local worldsize = tonumber((ModTextFileGetContent("data/compatibilitydata/worldsize.txt") or 35840))
            worldsize = worldsize * 0.475
            if currbiome == "_EMPTY_" and x > worldsize or x < (worldsize * -1) then
            	local d_opts = {"You'd cause something irreversible..."}
                if GameHasFlagRun("apotheosis_everything") == true then
                    d_opts = {"...I just really don't like going over there."}
                end
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "power"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" and GameHasFlagRun("apotheosis_heretalk_end_1") then
                stone_over = true
            	rate = 5
            	local d_opts = {"...Fortunate."}
                if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                    d_opts = {"...You're the keyholder, aren't you?"}
                elseif GameHasFlagRun("apotheosis_heretalk_end_upset") then
                    d_opts = {"...Fool."}
                end
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" and GameHasFlagRun("apotheosis_heretalk_end_2") then
                stone_over = true
            	local d_opts = {"I must commend you, you did a lot of work."}
                if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                    d_opts = {"Well, in spite of your status, you're still filled with arrogance."}
                    tone = "long"
                end
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" and GameHasFlagRun("apotheosis_heretalk_end_3") then
                stone_over = true
            	local d_opts = {"However, I believe it's time we part ways..."}
                if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                    d_opts = {"And that arrogance is your downfall."}
                end
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" and GameHasFlagRun("apotheosis_heretalk_end_sheep_1") then
                stone_over = true
            	rate = 5
            	local d_opts = {"...No."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" and GameHasFlagRun("apotheosis_heretalk_end_sheep_1") then
                stone_over = true
            	local d_opts = {"Something's wrong..."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "power"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" and GameHasFlagRun("apotheosis_heretalk_end_sheep_2") then
                stone_over = true
            	local d_opts = {"..."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	rate = 20
		tone = "quiet"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" and GameHasFlagRun("apotheosis_heretalk_end_sheep_2") then
                stone_over = true
            	local d_opts = {"Disappointing..."}
                if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                    d_opts = {"...Fool."}
                end
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "power"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local guiding_stone = EntityGetInRadiusWithTag(x,y,150,"poopstone")[1] or nil
            if guiding_stone ~= nil then
            local sprite_comp = EntityGetComponentIncludingDisabled(guiding_stone,"PhysicsImageShapeComponent")[1]
            local image_file = ComponentGetValue2(sprite_comp,"image_file")
            local radar_perk = 0
            local player_id = EntityGetInRadiusWithTag(x,y,20,"player_unit")[1] or nil
            local lua_comps = EntityGetComponentIncludingDisabled(player_id,"LuaComponent") or nil
            if lua_comps ~= nil then
                for i = 1, #lua_comps do
		    if ComponentGetValue2(lua_comps[i], "script_source_file") == "mods/Apotheosis/files/scripts/perks/plane_radar.lua" then
 		   	radar_perk = 1
		    end
	        end
	    end	
            if GameHasFlagRun("apotheosis_heretalk_guiding_stone") and (image_file == "mods/Apotheosis/files/items_gfx/goldnugget_01_alt_radar.png" or radar_perk == 1 ) then
                stone_over = true
                local d_opts = {"That's... curious..."}
                if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                    d_opts = {"You..."}
                end
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
            else
                return false
	    end
        end
    },
    {
        trigger = function()
            num = 72
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                stone_over = true
                GameAddFlagRun("apotheosis_heretalk_cynical")
                local d_opts = {"...What exactly are you?"}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "power"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local perk_altar = EntityGetInRadiusWithTag( x, y, 250, "curse" ) or {}
            if currbiome == "???" and GameHasFlagRun("apotheosis_heretalk_cynical") then
                for pa=1,#perk_altar do
                    if EntityGetName(perk_altar[pa]) == "apotheosis_perk_creation_altar" then
            	        local d_opts = {"Hmm, do you see anything... interesting?"}
                        local dialogue = d_opts[math.random(1,#d_opts)]
			tone = "gossip"
                        return true, dialogue
                    end
	        end
	        return false
            else
                return false
            end
        end
    },
    {
	--I'm very good at coding :) -Spoop
        trigger = function()
            num = 74
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local radar_perk = 0
                local player_id = EntityGetInRadiusWithTag(x,y,20,"player_unit")[1] or nil
                local lua_comps = EntityGetComponentIncludingDisabled(player_id,"LuaComponent") or nil
                if lua_comps ~= nil then
                    for i = 1, #lua_comps do
		        if ComponentGetValue2(lua_comps[i], "script_source_file") == "mods/Apotheosis/files/scripts/perks/plane_radar.lua" then
 		        	radar_perk = 1
		        end
	            end
	        end	
                if GameHasFlagRun("apotheosis_heretalk_cynical") and player_id ~= nil and radar_perk == 1 then
                    local d_opts = {"Oh good, you figured it out."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
                    return true, dialogue
                else
                    return false
                end
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_esoteric_den" then
                local d_opts = {"We aren't meant to be here..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "power"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_esoteric_den" then
                local d_opts = {"What are you attempting to search for? Nightmares?"}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
-- Misc. Stuff (I just want him to seem quite interactive :P [And you sure did that past Spoop!])
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_fun" then
                local d_opts = {"A filthy place...","A grimy place..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 78
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"Overridden with spores and lost devices..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_pyramid" then
                local d_opts = {"Do you know how ancient this structure really is..?"}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_liquidcave" then
                local d_opts = {"Their greed overtook them..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_robobase" then
                local d_opts = {"The automatons are always planning something..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_vault" then
                local d_opts = {"Seems even they begin to rust eventually."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if ModIsEnabled("grahamsperks") then
                local lukki = EntityGetInRadiusWithTag( x, y, 175, "lukki" ) or nil
                for lp=1,#lukki do
                    if EntityGetName(lukki[lp]) == "$animal_lukki_dark" then
                        local d_opts = {"Strange..."}
                        local dialogue = d_opts[math.random(1,#d_opts)]
                        return true, dialogue
                    end
                end
                return false
            end
            return false
        end
    },
    {
	--Wink wink nudge nudge ;)
        trigger = function()
            if ModIsEnabled("grahamsperks") then
                local lukki = EntityGetInRadiusWithTag( x, y, 175, "lukki" ) or nil
                for lp=1,#lukki do
                    if EntityGetName(lukki[lp]) == "$animal_lukki_dark" then
                        local d_opts = {"I remember these arachnids being more insatiable..."}
                        local dialogue = d_opts[math.random(1,#d_opts)]
                        return true, dialogue
                    end
                end
                return false
            end
            return false
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_winter_caves" then
                local d_opts = {"Are you lost?"}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 86
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"They are."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "power"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_lava_excavation" then
                local d_opts = {"A warm place...","This cavern is boiling..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_lava_excavation" then
                local d_opts = {"This appears to be a nesting site for flame infused invertebrates."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
-- You know what this is for...
--[[
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_ant_hell" then
                local d_opts = {"...I sense something."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_ant_hell" then
                local d_opts = {"Something that these ants carry seems familiar..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
]]--
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_slime_hell" then
                local d_opts = {"...Filthy"}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_slime_hell" and GameHasFlagRun("apotheosis_heretalk_cynical") then
                local d_opts = {"You seem to exhibit quite the longing for... visually pleasing environments..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if currbiome == "$biome_wizardcave" and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true then
		local timer = 0
                local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
		timer = ComponentGetValue2( timercomp, "value_float")
		if (timer >= 600) then
                    local d_opts = {"Pick me up."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_boss_arena" then
                local d_opts = {"..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "quiet"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local work = EntityGetClosestWithTag( x, y, "ending_sampo_spot_underground" ) or {}
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_boss_victoryroom" and work == nil and (y >= 100 or y <= -100) then
                local d_opts = {"As above, so below..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_boss_victoryroom" and #EntityGetInRadiusWithTag( x, y, 250, "ending_sampo_spot_underground" ) ~= 0 then
                local d_opts = {"You can do better than to meddle with this mechanism..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "power"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_underwater" then
                local d_opts = {"Dreary atmosphere..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_underwater" then
                local d_opts = {"The salt is irritating my eye..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_unstashed = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsBodyComponent" )
            if #EntityGetInRadiusWithTag( x, y, 30, "black_hole" ) ~= 0 and ComponentGetIsEnabled(heretic_unstashed) == true then
                local d_opts = {"Really now?","You'll have to try harder than that."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_unstashed = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsBodyComponent" )
            if #EntityGetInRadiusWithTag( x, y, 30, "black_hole" ) ~= 0  and ComponentGetIsEnabled(heretic_unstashed) == true then
                local d_opts = {"A futile attempt..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_unstashed = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsBodyComponent" )
            if #EntityGetInRadiusWithTag( x, y, 30, "black_hole" ) ~= 0  and ComponentGetIsEnabled(heretic_unstashed) == true then
                local d_opts = {"I will not be indulging this."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if #EntityGetInRadiusWithTag( x, y, 250, "boss_centipede" ) ~= 0 then
                local d_opts = {"The great tinkerer."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "power"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if #EntityGetInRadiusWithTag( x, y, 250, "boss_centipede" ) ~= 0 then
                local d_opts = {"Not even I have much knowledge on its true nature..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "miniboss" ) or {}
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$animal_boss_pit" then
                    local d_opts = {"Hm, a disruptive wand conjurer."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "long"
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "miniboss" ) or {}
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$animal_boss_robot" then
                    local d_opts = {"Quite the construct."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "miniboss" ) or {}
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$animal_boss_limbs" then
                    local d_opts = {"A rather disappointing specimen."}
		    if GameHasFlagRun("apotheosis_heretalk_cynical") then
            	        d_opts = {"A rather disappointing specimen... wouldn't you know..."}
		    end
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            local boss_gate = EntityGetInRadiusWithTag( x, y, 200, "gate_monster" ) or nil
            for bp=1,#boss_gate do
                if (EntityGetName(boss_gate[bp]) == "$animal_gate_monster_a") or (EntityGetName(boss_gate[bp]) == "$animal_gate_monster_b") or (EntityGetName(boss_gate[bp]) == "$animal_gate_monster_c") or (EntityGetName(boss_gate[bp]) == "$animal_gate_monster_d") then
                    local d_opts = {"...Excessive."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "curse_NOT" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$animal_fish_giga" then
                    local d_opts = {"Hm, so it wasn't just a tall tale..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            local boss_dragon = EntityGetInRadiusWithTag( x, y, 200, "boss_dragon" ) or nil
            for bp=1,#boss_dragon do
                if EntityGetName(boss_dragon[bp]) == "$animal_boss_dragon" then
            	    local d_opts = {"Hm, a scaled pike?"}
		    if GameHasFlagRun("apotheosis_heretalk_cynical") then
            	    	d_opts = {"A mere infantile pike?.. You could find more extraordinary beasts to fell than this..."}
		    	tone = "long"
		    end
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "miniboss" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$animal_boss_ghost" then
                    local d_opts = {"I don't seem to have any recollection of this otherworldly skull..."}
		    tone = "long"
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "miniboss" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$animal_boss_alchemist" then
                    local d_opts = {"A failure."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 325, "touchmagic_immunity" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$animal_maggot_tiny" then
                    local d_opts = {"A monstrously overgrown maggot, living off of deceased giants."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "long"
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "miniboss" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$creep_apotheosis_boss_fire_lukki_name" then
                    local d_opts = {"An adult fireborn arachnid, I've never been very fond of their kind."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "long"
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 200, "miniboss" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$enemy_apotheosis_boss_toxic_worm" then
                    local d_opts = {"This large vermiform seems to excrete large amounts of radioactivity as it undergoes its metamorphosis."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "long"
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 200, "miniboss" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$enemy_apotheosis_boss_toxic_worm" then
                    local d_opts = {"You've caught it at an inopportune moment."}
		    if GameHasFlagRun("apotheosis_heretalk_cynical") then
            	        d_opts = {"It seems upset at your inopportune timing."}
			tone = "gossip"
		    end
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            if #EntityGetInRadiusWithTag( x, y, 200, "apotheosis_blob_boss" ) ~= 0 and #EntityGetInRadiusWithTag( x, y, 200, "miniboss" ) ~= 0 then
                local d_opts = {"Curious, I wonder what caused them to conglomerate so rapidly."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "boss_ghost_helper" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$enemy_apotheosis_boss_musical_ghost" then
                    local d_opts = {"A symphony that will forever remain unheard."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "miniboss" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$enemy_apotheosis_angel" then
                    local d_opts = {"Ugh."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "power"
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "touchmagic_immunity" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$enemy_apotheosis_forest_monolith" then
                    local d_opts = {"...?"}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "quiet"
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "touchmagic_immunity" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$enemy_apotheosis_forest_monolith" then
		    local mdmgcomp = EntityGetFirstComponentIncludingDisabled(boss[bp],"DamageModelComponent")
                    local mhp = ComponentGetValue2( mdmgcomp, "hp")
                    local mmax_hp = ComponentGetValue2( mdmgcomp, "max_hp")
                    if mhp ~= nil and mhp < 3999 then
                	local d_opts = {"...What are you attempting to do?"}
			tone = "power"
			if GameHasFlagRun("apotheosis_heretalk_cynical") then
            	            d_opts = {"...Have you devolved to lunacy? Why are you beating up this rock?"}
           	            tone = "long"
			end
                	local dialogue = d_opts[math.random(1,#d_opts)]
                	return true, dialogue
                    end
                end
            end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 200, "touchmagic_immunity" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "apotheosis_monolith_dead_check" then
                    local d_opts = {"Hm, well I'm sure that was fun while it lasted... I supppose..."}
		    if GameHasFlagRun("apotheosis_heretalk_cynical") then
            	        d_opts = {"Well that was quite the nice waste of time."}
		    end
		    tone = "gossip"
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            if #EntityGetInRadiusWithTag( x, y, 200, "big_friend" ) ~= 0 then
                local d_opts = {"This creature is the embodiment of Nature and used their spit to form the very ground of the world we stand upon."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 121
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"Did I make that all up?... potentially."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "touchmagic_immunity" ) or {}
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$enemy_apotheosis_abyssum_monster" then
                    stone_over = true
                    local d_opts = {"Hm, I feel strangely cold..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "quiet"
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "miniboss" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$creep_apotheosis_boss_water_lukki_name" then
                    --local d_opts = {"Is that the grand beast..?", "Something feels... off..."}
                    --local dialogue = d_opts[math.random(1,#d_opts)]
                    local dialogue = "Something feels... off..."
		    tone = "gossip"
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "miniboss" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$creep_apotheosis_boss_water_lukki_name" then
                    local d_opts = {"How is this thing supposed to be a Sukelluskello if I haven't seen a single aqua mine?","Is this an overgrown Sukelluskello? I haven't seen a single aqua mine."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "long"
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local perk_altar = EntityGetInRadiusWithTag( x, y, 60, "curse" ) or {}
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if currbiome == "???" and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true then
                for pa=1,#perk_altar do
                    if EntityGetName(perk_altar[pa]) == "apotheosis_perk_creation_altar" then
            	        local d_opts = {"...Did you expect me to turn into a perk?"}
		        if GameHasFlagRun("apotheosis_heretalk_cynical") then
            	            d_opts = {"...What? Did you expect me to turn into a perk?"}
		        end
			tone = "gossip"
                        local dialogue = d_opts[math.random(1,#d_opts)]
                        return true, dialogue
                    end
	        end
	        return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 126
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
            	local d_opts = {"Sadly, we could only make it function on stones of condensed energy."}
		tone = "long"
		if GameHasFlagRun("apotheosis_heretalk_cynical") then
            	    d_opts = {"It only works on stones."}
		    tone = "power"
		end
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local perk_altar = EntityGetInRadiusWithTag( x, y, 300, "curse" ) or {}
            if currbiome == "???" and #EntityGetInRadiusWithTag( x, y, 300, "forge_item_convert" ) ~= 0 then
                for pa=1,#perk_altar do
                    if EntityGetName(perk_altar[pa]) == "apotheosis_perk_creation_altar" then
            	        local d_opts = {"Fortunate that it's still usable."}
                        local dialogue = d_opts[math.random(1,#d_opts)]
			tone = "gossip"
                        return true, dialogue
                    end
	        end
	        return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 128
            local corrupt_death = EntityGetInRadiusWithTag( x, y, 175, "curse" ) or {}
            for cd=1,#corrupt_death do
                if EntityGetName(corrupt_death[cd]) == "wizard_corrupt_death_check" then
                    stone_over = true
                    local d_opts = {"You couldn't stop at me, could you?", "How humane of you...", "They're undeserving of this.", "Have you no honor for the pained?", "Was their current punishment not enough to you?"}
                    if GameHasFlagRun("apotheosis_heretalk_depressed") then
                        d_opts = {"Why?", "And yet you still pain them...", "Ugh...", "..."}
	                tone = "power"
                    elseif GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                        d_opts = {"...ugh.", "you...", "...", "..."}
	                tone = "quiet"
                        rate = 2
                        size_x = 0.75
                        size_y = 0.75
                        alpha = 0.35
                    end
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    GameRemoveFlagRun("apotheosis_heretalk_id_" .. tostring(num))
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            num = 129
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local corrupt_death = EntityGetInRadiusWithTag( x, y, 175, "curse" ) or {}
            for cd=1,#corrupt_death do
                if EntityGetName(corrupt_death[cd]) == "wizard_corrupt_death_check" then
                    stone_over = true
                    local d_opts = {"You couldn't stop at me, could you?", "How humane of you...", "They're undeserving of this.", "Have you no honor for the pained?", "Was their current punishment not enough to you?"}
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    GameRemoveFlagRun("apotheosis_heretalk_id_" .. tostring(num-1))
                    GameRemoveFlagRun("apotheosis_heretalk_id_" .. tostring(num))
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if (currbiome == "$biome_plane_yggdrasil" or currbiome == "$biome_plane_magic" or currbiome == "$biome_plane_technology") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true then
            	local d_opts = {"Hm? What is it?"}
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
	--Lil unsure on these two
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if (currbiome == "$biome_plane_yggdrasil" or currbiome == "$biome_plane_magic" or currbiome == "$biome_plane_technology") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true then
            	local d_opts = {"I would prefer not being left under the will of the gods."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "power"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if currbiome == "$biome_wizardcave" and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true then
            	local d_opts = {"I do not want to be left here."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if #EntityGetInRadiusWithTag( x, y, 175, "boss_ghost_helper" )  ~= 0 then
                local d_opts = {"These otherworldly entities struggle to hide from my gaze."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(GlobalsGetValue("HERETIC_REGROWTH",0)) > 0 then
                local d_opts = {"I'm a bit more resilient than that."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(GlobalsGetValue("HERETIC_REGROWTH",0)) == 2 then
                local d_opts = {"You're quite the uncoordinated one."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(GlobalsGetValue("HERETIC_REGROWTH",0)) == 3 then
                local d_opts = {"Carefulness is not within' your dictionary."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(GlobalsGetValue("HERETIC_REGROWTH",0)) == 4 then
                local d_opts = {"It still does not work."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(GlobalsGetValue("HERETIC_REGROWTH",0)) == 5 then
                local d_opts = {"I would appreciate much less peril."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(GlobalsGetValue("HERETIC_REGROWTH",0)) == 6 then
                local d_opts = {"Perhaps you would do a better job handling the sun?"}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(GlobalsGetValue("HERETIC_REGROWTH",0)) == 7 then
                local d_opts = {"..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "quiet"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(GlobalsGetValue("HERETIC_REGROWTH",0)) == 8 then
                local d_opts = {"I'm returning to my catacombs next time..."}
		if GameHasFlagRun("apotheosis_heretalk_cynical") then
            	    d_opts = {"......"}
		    tone = "quiet"
		else
		    tone = "power"
		end
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(GlobalsGetValue("HERETIC_REGROWTH",0)) > 8 and #EntityGetInRadiusWithTag( x, y, 130, "player_unit" ) ~= 0 then
                local d_opts = {"Perhaps you'll exhibit more caution."}
		tone = "power"
		if GameHasFlagRun("apotheosis_heretalk_cynical") then
            	    d_opts = {"............"}
		    tone = "quiet"
		end
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(GlobalsGetValue("HERETIC_REGROWTH",0)) > 9 then
                local d_opts = {"I'm no longer humoring this."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "power"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_vanilla_ending2") then
                stone_over = true
            	local d_opts = {"The world, reborn anew, the many inhabitants now invigorated by the joy of life."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 145
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                stone_over = true
                local d_opts = {"Yet, I struggle to find such a virtue."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 146
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                stone_over = true
                local d_opts = {"My followers, still left with melded faces and twisted tissue."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 147
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                stone_over = true
                local d_opts = {"Living a burden instated by the gods."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 148
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                stone_over = true
                local d_opts = {"The same ones now compelling them to smile."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 149
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                stone_over = true
                local d_opts = {"..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "quiet"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 150
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                stone_over = true
                GameAddFlagRun("apotheosis_heretalk_depressed")
                local d_opts = {"The fate sickens me..."}
                if GameHasFlagRun("ending_game_completed_with_34_orbs") then
                    d_opts = {"Well, was it worth it?"}
                end
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 151
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) and GameHasFlagRun("ending_game_completed_with_34_orbs") then
                stone_over = true
            	local d_opts = {"Do you feel empowered?"}
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_vanilla_ending0") then
                stone_over = true
            	local d_opts = {"Farewell."}
                if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                    d_opts = {"...Farewell."}
                elseif GameHasFlagRun("apotheosis_heretalk_cynical") then
                    d_opts = {"...You were on the cusp of something more..."}
                    tone = "long"
                end
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_vanilla_ending1_gold") or GameHasFlagRun("apotheosis_vanilla_ending1_toxic") then
                stone_over = true
            	local d_opts = {"A rather dull fate..."}
                if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                    d_opts = {"...A dull fate."}
                elseif GameHasFlagRun("apotheosis_heretalk_cynical") and not GameHasFlagRun("apotheosis_heretalk_broken") then
                    d_opts = {"...Strange."}
                end
                tone = "gossip"
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 154
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                stone_over = true
            	local d_opts = {"Riches with no value."}
                if GameHasFlagRun("apotheosis_heretalk_cynical") then
                    d_opts = {"You were on the cusp of something more..."}
                elseif GameHasFlagRun("apotheosis_vanilla_ending1_toxic") then
                    d_opts = {"Virulent riches with no value."}
                end
                tone = "gossip"
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 155
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                stone_over = true
                tone = "gossip"
            	local d_opts = {"At least I'm shinier..."}
                if GameHasFlagRun("apotheosis_heretalk_cynical") or GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
                    d_opts = {"..."}
                    tone = "quiet"
                end
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        --I wanted to do more with these but I can't think of anything good right now
        --The original idea was to have them go on small anecdotes for some of them
        trigger = function()
            if tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 0 and not GameHasFlagRun("apotheosis_planes_entered") then
                local d_opts = {"..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "quiet"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 0 and not GameHasFlagRun("apotheosis_planes_entered") then
                local d_opts = {"So the cycle continues..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) % 2 == 0 and tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 0 and not GameHasFlagRun("apotheosis_planes_entered") then
                local d_opts = {"More lifeforms emerge from the world's reconstructions..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) % 3 == 0 and tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 0 and not GameHasFlagRun("apotheosis_planes_entered") then
                local d_opts = {"The ground beneath the mountain unravels..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            -- Conga removed this feature and I don't want to reorder everything again so false not equal false :p
            if false ~= false and tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) % 5 == 0 and tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 0 and not GameHasFlagRun("apotheosis_planes_entered") then
                local d_opts = {"The earth rises from below..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) % 7 == 0 and tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 0 and not GameHasFlagRun("apotheosis_planes_entered") then
                local d_opts = {"Nature's body shifts..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) == 8 and tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 0 and not GameHasFlagRun("apotheosis_planes_entered") then
                local d_opts = {"Well..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) == 8 and tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 0 and not GameHasFlagRun("apotheosis_planes_entered") then
                local d_opts = {"Now the test of endurance..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) == 18 and tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 0 and not GameHasFlagRun("apotheosis_planes_entered") then
                local d_opts = {"..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "quiet"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) == 18 and tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 0 and not GameHasFlagRun("apotheosis_planes_entered") then
                local d_opts = {"This is getting to be quite the monotonous trial..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) == 28 and tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 0 and not GameHasFlagRun("apotheosis_planes_entered") then
                local d_opts = {"Well, end of the line..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) == 28 and tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 0 and not GameHasFlagRun("apotheosis_planes_entered") then
                local d_opts = {"I hope you learnt of something through this journey..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") and GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 and not GameHasFlagRun("apotheosis_heretalk_broken") then
		local timer = 0
                local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
		timer = ComponentGetValue2( timercomp, "value_float")
		if (timer >= 1200) then
            	    local d_opts = {"...Apologies for the bleeding, it is a byproduct of my corrupted form."}
            	    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "long"
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") and GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 and not GameHasFlagRun("apotheosis_heretalk_broken") then
		local timer = 0
                local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
		timer = ComponentGetValue2( timercomp, "value_float")
		if (timer >= 3600) then
            	    local d_opts = {"...So how long do you plan on keeping me here?"}
            	    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 170
            local heretic_unstashed = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsBodyComponent" )
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num+1)) and ComponentGetIsEnabled(heretic_unstashed) == false then
                local d_opts = {"Thank you."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
		--locks you out of the other limit dialogue if you picked up prematurely, muahahahaha
		GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+1))
		GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+2))
		GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+3))
		GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+4))
		GameAddFlagRun("apotheosis_heretalk_id_" .. tostring(num+5))
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") and GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 and not GameHasFlagRun("apotheosis_heretalk_broken") then
		local timer = 0
                local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
		timer = ComponentGetValue2( timercomp, "value_float")
		if (timer >= 216000) then
            	    local d_opts = {"Do you plan on leaving me here for the rest of eternity?"}
            	    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "long"
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") and GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 and not GameHasFlagRun("apotheosis_heretalk_broken") then
		local timer = 0
                local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
		timer = ComponentGetValue2( timercomp, "value_float")
		if (timer >= 216000) then
            	    local d_opts = {"I've already been subjugated to eons of stagnant living within a cage before."}
            	    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "long"
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") and GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 and not GameHasFlagRun("apotheosis_heretalk_broken") then
		local timer = 0
                local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
		timer = ComponentGetValue2( timercomp, "value_float")
		if (timer >= 216000) then
            	    local d_opts = {"I would expect you to show some intrigue in an entity such as myself."}
            	    if HasFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_03") then
            	        d_opts = {"Although, you seem to exhibit a certain unease from my form..."}
            	    end
            	    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "long"
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") and GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 and not GameHasFlagRun("apotheosis_heretalk_broken") then
		local timer = 0
                local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
		timer = ComponentGetValue2( timercomp, "value_float")
		if (timer >= 216000) then
            	    local d_opts = {"Well, you can continue on with your ruthless corpse frolicking."}
		    if GameHasFlagRun("apotheosis_heretalk_cynical") then
            	        d_opts = {"Well, you could at the very least bring me to the ends of that guide you found."}
		    end
            	    if HasFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_03") then
            	        d_opts = {"Almost as if you know something that I do not..."}
            	    end
		    tone = "long"
            	    local dialogue = d_opts[math.random(1,#d_opts)]
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") and GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 and not GameHasFlagRun("apotheosis_heretalk_broken") then
		local timer = 0
                local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
		timer = ComponentGetValue2( timercomp, "value_float")
		if (timer >= 216000) then
            	    local d_opts = {"You'll be running in the dark however..."}
		    if GameHasFlagRun("apotheosis_heretalk_cynical") then
            	        d_opts = {"Perhaps the end would finally answer the questions that consume me."}
		    end
            	    if HasFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_03") then
            	        d_opts = {"How bizarre."}
            	    end
            	    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "long"
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_heretalk_id_14") then
                local evil_eye = nil
                local evil_eyes = EntityGetInRadiusWithTag( x, y, 175, "evil_eye" ) or {}
                for bp=1,#evil_eyes do
                    local evil_light = EntityGetFirstComponentIncludingDisabled(evil_eyes[bp],"LightComponent")
                    local evil_ui = EntityGetFirstComponentIncludingDisabled(evil_eyes[bp],"UIInfoComponent")
                    local ui_name = ComponentGetValue2(evil_ui,"name")
                    if ComponentGetIsEnabled( evil_light ) == true and ui_name == "$item_evil_eye" then
                        evil_eye = evil_eyes[bp]
                    end
	        end
                local evil_held = EntityGetFirstComponentIncludingDisabled( evil_eye, "SpriteComponent" )
                local evil_body = EntityGetFirstComponentIncludingDisabled( evil_eye,"PhysicsBodyComponent")
	        if evil_eye ~= nil and ( ComponentGetIsEnabled(evil_held) == true or ( ComponentGetIsEnabled( evil_body ) == true and EntityGetParent(evil_eye) == 0 )) then
                    local d_opts = {"This malicious eyeball seems quite dimwitted compared to a certain other..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "long"
                    return true, dialogue
	        end
                return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "helpless_animal" ) or {}
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$enemy_apotheosis_fish_red" then
                    stone_over = true
                    local d_opts = {"What. It's real?"}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            num = 178
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"Well felicitations to you, I suppose..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local book = EntityGetInRadiusWithTag( x, y, 175, "scroll" ) or {}
            for bp=1,#book do
                local book_ui = EntityGetFirstComponentIncludingDisabled(book[bp],"UIInfoComponent")
		local book_name = ComponentGetValue2( book_ui, "name")
                if book_name == "$book_apotheosis_realquest_tale_name" or book_name == "$book_apotheosis_realquest_name" or book_name == "$book_apotheosis_realquest_alt_name" then
                    local d_opts = {"Writing of a fisherman's ramblings."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            num = 180
            if not GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-2)) then
                local book = EntityGetInRadiusWithTag( x, y, 175, "scroll" ) or {}
                for bp=1,#book do
                    local book_ui = EntityGetFirstComponentIncludingDisabled(book[bp],"UIInfoComponent")
		    local book_name = ComponentGetValue2( book_ui, "name")
                    if book_name == "$book_apotheosis_realquest_tale_name" or book_name == "$book_apotheosis_realquest_name" or book_name == "$book_apotheosis_realquest_alt_name" then
                        local d_opts = {"You don't actually believe this nonsense, do you?"}
                        local dialogue = d_opts[math.random(1,#d_opts)]
		        tone = "gossip"
                        return true, dialogue
                    end
	        end
	    end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "touchmagic_immunity" ) or {}
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$animal_parallel_tentacles" then
                    local d_opts = {"The servants are restless."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "touchmagic_immunity" ) or {}
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$animal_parallel_alchemist" then
                    local d_opts = {"His image reused."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "touchmagic_immunity" ) or {}
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$enemy_apotheosis_boss_toxic_worm_parallel" then
                    local d_opts = {"Hm... I'm not quite sure what that..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            num = 184
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
            	local d_opts = {"...is for..."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "quiet"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_heretalk_id_14") then
                local wandstone = nil
                local wandstones = EntityGetInRadiusWithTag( x, y, 175, "poopstone" ) or {}
                for bp=1,#wandstones do
                    local shapecomp = EntityGetFirstComponentIncludingDisabled(wandstones[bp],"PhysicsImageShapeComponent")
                    if ComponentGetValue2(shapecomp,"image_file") == "data/items_gfx/goldnugget_01.png" then
                        wandstone = wandstones[bp]
                    end
	        end
                local stone_held = EntityGetFirstComponentIncludingDisabled( wandstone, "SpriteComponent" )
                local stone_body = EntityGetFirstComponentIncludingDisabled( wandstone,"PhysicsBodyComponent")
	        if wandstone ~= nil and ( ComponentGetIsEnabled(stone_held) == true or ( ComponentGetIsEnabled( stone_body ) == true and EntityGetParent(wandstone) == 0 )) then
                    local d_opts = {"Hm... this is his..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "long"
                    return true, dialogue
	        end
                return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local sun = EntityGetInRadiusWithTag( x, y, 400, "seed_e" ) or {}
            for bp=1,#sun do
                local sspritecomp = EntityGetComponentIncludingDisabled(sun[bp],"SpriteComponent")[2]
                if ComponentGetValue2(sspritecomp,"image_file") == "data/props_gfx/sun_big.png" then
                    local d_opts = {"The great celestial body of the above."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            local dsun = EntityGetInRadiusWithTag( x, y, 400, "seed_f" ) or {}
            for bp=1,#dsun do
                local sspritecomp = EntityGetComponentIncludingDisabled(dsun[bp],"SpriteComponent")[2]
                if ComponentGetValue2(sspritecomp,"image_file") == "data/props_gfx/sun_big_dark.png" then
                    local d_opts = {"The great celestial void of the below."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            num = 188
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) or GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-2)) then
                local d_opts = {"You've put in quite the effort to rebuild such an object."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
	    else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 189
            local heretic_held = EntityGetComponentIncludingDisabled( entity_id, "SpriteComponent" )[2]
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-2)) or GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-3)) and ComponentGetIsEnabled(heretic_held) == true and (#EntityGetInRadiusWithTag( x, y, 400, "seed_e" ) > 0 or #EntityGetInRadiusWithTag( x, y, 400, "seed_f" ) > 0) then
                local d_opts = {"No, subsuming me with it will not destroy me."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
	    else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 190
            local heretic_held = EntityGetComponentIncludingDisabled( entity_id, "SpriteComponent" )[2]
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) and ComponentGetIsEnabled(heretic_held) == true and (#EntityGetInRadiusWithTag( x, y, 400, "seed_e" ) > 0 or #EntityGetInRadiusWithTag( x, y, 400, "seed_f" ) > 0) then
                local d_opts = {"...Or you're attempting to blind me, both are futile."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
	    else
                return false
            end
        end
    },
    {
        trigger = function()
            local letters = { "c", "d" }
            for la=1,#letters do
                local seed = EntityGetInRadiusWithTag( x, y, 250, "seed_" .. letters[la] ) or {}
                for bp=1,#seed do
                    local sspritecomp = EntityGetFirstComponentIncludingDisabled(seed[bp],"SpriteComponent")
                    if ComponentGetValue2(sspritecomp,"image_file") == "data/particles/fog_of_war_hole_huge.png" then
                        local d_opts = {"Ah, a seedling of what's to come, it still requires further nurturing."}
                        local dialogue = d_opts[math.random(1,#d_opts)]
                        return true, dialogue
                    end
	        end
            end
            return false
        end
    },
    {
        trigger = function()
            local heretic_held = EntityGetComponentIncludingDisabled( entity_id, "SpriteComponent" )[2]
            if ComponentGetIsEnabled(heretic_held) == true then
                local sunb = EntityGetInRadiusWithTag( x, y, 250, "seed_d" ) or {}
                for bp=1,#sunb do
                    local sspritecomp = EntityGetComponentIncludingDisabled(sunb[bp],"SpriteComponent")[2]
                    if ComponentGetValue2(sspritecomp,"image_file") == "data/props_gfx/sun_small.png" then
                        local d_opts = {"I do not recommend throwing me at it, my current form may corrupt it."}
                        local dialogue = d_opts[math.random(1,#d_opts)]
			tone = "long"
                        return true, dialogue
                    end
	        end
            end
            return false
        end
    },
    {
        trigger = function()
            local letters = { "a", "b" }
            for la=1,#letters do
                local seed = EntityGetInRadiusWithTag( x, y, 250, "seed_" .. letters[la] ) or {}
                for bp=1,#seed do
                    local sspritecomp = EntityGetFirstComponentIncludingDisabled(seed[bp],"SpriteComponent")
                    if ComponentGetValue2(sspritecomp,"image_file") == "data/items_gfx/sunseed.png" or ComponentGetValue2(sspritecomp,"image_file") == "data/items_gfx/sunseed_2.png" then
                        local sun_held = EntityGetFirstComponentIncludingDisabled( seed[bp], "SpriteComponent" )
                        local sun_body = EntityGetFirstComponentIncludingDisabled( seed[bp],"PhysicsBodyComponent")
	                if ( ComponentGetIsEnabled(seed_held) == true or ( ComponentGetIsEnabled( seed_body ) == true and EntityGetParent(seed[bp]) == 0 )) then
                            local d_opts = {"Ah, you seem to have discovered a dormant marvel."}
                            local dialogue = d_opts[math.random(1,#d_opts)]
                            return true, dialogue
	                end
                    end
	        end
            end
            return false
        end
    },
    {
        trigger = function()
            num = 194
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"I've never particularly researched how to rebirth it."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local explosions = EntityGetInRadiusWithTag( x, y, 120, "big_explosion" )
            local seas = EntityGetInRadiusWithTag( x, y-100, 120, "sea_of_lava" )
            local beams = EntityGetInRadiusWithTag( x, y, 120, "beam_from_sky" )
            local nukes = EntityGetInRadiusWithTag( x, y, 120, "nuke_giga" )
            if ( #explosions > 1 ) or ( #seas > 0 ) or ( #beams > 0 ) or ( #nukes > 0 )  then
                local d_opts = {"...Ahem."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local explosions = EntityGetInRadiusWithTag( x, y, 120, "big_explosion" )
            local seas = EntityGetInRadiusWithTag( x, y-100, 120, "sea_of_lava" )
            local beams = EntityGetInRadiusWithTag( x, y, 120, "beam_from_sky" )
            local nukes = EntityGetInRadiusWithTag( x, y, 120, "nuke_giga" )
            if ( #explosions > 1 ) or ( #seas > 0 ) or ( #beams > 0 ) or ( #nukes > 0 )  then
                local d_opts = {"...Less of this please."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local explosions = EntityGetInRadiusWithTag( x, y, 120, "big_explosion" )
            local seas = EntityGetInRadiusWithTag( x, y-100, 120, "sea_of_lava" )
            local beams = EntityGetInRadiusWithTag( x, y, 120, "beam_from_sky" )
            local nukes = EntityGetInRadiusWithTag( x, y, 120, "nuke_giga" )
            if ( #explosions > 1 ) or ( #seas > 0 ) or ( #beams > 0 ) or ( #nukes > 0 )  then
                local d_opts = {"..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "quiet"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 198
            if tonumber(GlobalsGetValue("HERETIC_UNFORGED",0)) > 0 then
                GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num+4))
                GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num+5))
                GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num+6))
                local d_opts = {"Ugh, it was sickenly divine within' there..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 199
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"I apologize for any outputted wands, my form is rather unstable."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if tonumber(GlobalsGetValue("HERETIC_UNFORGED",0)) > 1 then
                local d_opts = {"Blegh, perhaps you can enter next time."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 201
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"You'd likely appreciate it much more than me..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if ModIsEnabled("anvil_of_destiny") and tonumber(GlobalsGetValue("HERETIC_UNFORGED",0)) == 0 then
                for i, entity in ipairs(EntityGetInRadius(x, y, 175)) do
                    if EntityGetName(entity) == "anvil_of_destiny" then
                        local d_opts = {"Ah, quite the intriguing structure this is."}
                        local dialogue = d_opts[math.random(1,#d_opts)]
                        return true, dialogue
                    end
                end
                return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 203
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) and tonumber(GlobalsGetValue("HERETIC_UNFORGED",0)) == 0 then
                local d_opts = {"It has an arsenal of possible effects, mattering on what you combine."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if ModIsEnabled("anvil_of_destiny") and tonumber(GlobalsGetValue("HERETIC_UNFORGED",0)) == 0 then
                local heretic_held = EntityGetFirstComponentIncludingDisabled( entity_id, "SpriteComponent" )
                if ComponentGetIsEnabled(heretic_held) == true then
                    for i, entity in ipairs(EntityGetInRadius(x, y, 175)) do
                        if EntityGetName(entity) == "anvil_of_destiny" then
            	            stone_over = true
            	            local d_opts = {"...I don't believe this would work."}
            	            local dialogue = d_opts[math.random(1,#d_opts)]
		            if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
		                dialogue = "...Um."
		            end
                            tone = "gossip"
            	            return true, dialogue
                        end
                    end
                    return false
                else
                    return false
                end
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_14") == false and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
		local kicked = 0
                local kickcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[2]
		kicked = ComponentGetValue2( kickcomp, "value_int")
		if (kicked >= 2) then
            	    local d_opts = {"..."}
            	    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "quiet"
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 206
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
		local kicked = 0
                local kickcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[2]
		kicked = ComponentGetValue2( kickcomp, "value_int")
		local kicks = 0
		kicks = tonumber(GlobalsGetValue("HERETIC_KICKED"))
		if kicks == nil then
		    kicks = 0
		end
		if (kicks >= 100) and (kicked <= 50) and not GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num+11)) then
            	    local d_opts = {"Your leg seems to be quite spastic around me."}
            	    local dialogue = d_opts[math.random(1,#d_opts)]
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 207
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
		local kicks = 0
		kicks = tonumber(GlobalsGetValue("HERETIC_KICKED"))
		if kicks == nil then
		    kicks = 0
		end
                local d_opts = {"You've kicked me about " .. tostring(kicks) .. " times total now..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
		local kicked = 0
                local kickcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[2]
		kicked = ComponentGetValue2( kickcomp, "value_int")
		if (kicked >= 5) then
            	    local d_opts = {"Yes, hello, I see you."}
            	    local dialogue = d_opts[math.random(1,#d_opts)]
                    tone = "gossip"
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
		local kicked = 0
                local kickcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[2]
		kicked = ComponentGetValue2( kickcomp, "value_int")
		if (kicked >= 10) then
            	    local d_opts = {"You're quite good at kicking, I can see that."}
            	    local dialogue = d_opts[math.random(1,#d_opts)]
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
		local kicked = 0
                local kickcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[2]
		kicked = ComponentGetValue2( kickcomp, "value_int")
		if (kicked >= 15) then
            	    local d_opts = {"There's much worse things that you can commit."}
            	    local dialogue = d_opts[math.random(1,#d_opts)]
                    tone = "gossip"
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
		local kicked = 0
                local kickcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[2]
		kicked = ComponentGetValue2( kickcomp, "value_int")
		if (kicked >= 20) then
            	    local d_opts = {"...You're fairly adamant about this."}
            	    local dialogue = d_opts[math.random(1,#d_opts)]
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
		local kicked = 0
                local kickcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[2]
		kicked = ComponentGetValue2( kickcomp, "value_int")
		if (kicked >= 30) then
            	    local d_opts = {"Perhaps you should consider tying your spell casting to your legs?"}
            	    local dialogue = d_opts[math.random(1,#d_opts)]
                    tone = "gossip"
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 213
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"Just a thought..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
		local kicked = 0
                local kickcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[2]
		kicked = ComponentGetValue2( kickcomp, "value_int")
		if (kicked >= 50) then
            	    local d_opts = {"That's 50 kicks in a row now..."}
            	    local dialogue = d_opts[math.random(1,#d_opts)]
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 215
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"Perhaps you should consider druid soccer..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 216
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"The ball certainly would be a bit harder to kick than me."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 217
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
		local kicked = 0
                local kickcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[2]
		kicked = ComponentGetValue2( kickcomp, "value_int")
		if (kicked >= 100) then
            	    local d_opts = {"100 kicks..."}
            	    if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-11)) then
            	        d_opts = {"You've now kicked me 100 times a row, not just total..."}
                        tone = "long"
            	    end
            	    local dialogue = d_opts[math.random(1,#d_opts)]
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
		local kicked = 0
                local kickcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[2]
		kicked = ComponentGetValue2( kickcomp, "value_int")
		if (kicked >= 150) then
            	    local d_opts = {"Apologies for my silence, I don't have much else to say about this..."}
            	    local dialogue = d_opts[math.random(1,#d_opts)]
                    tone = "long"
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
		local kicked = 0
                local kickcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[2]
		kicked = ComponentGetValue2( kickcomp, "value_int")
		if (kicked > 200) then
            	    local d_opts = {"Over 200 kicks now..."}
            	    local dialogue = d_opts[math.random(1,#d_opts)]
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 220
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"I can't say I have any medals to give for any of this..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
		local kicked = 0
                local kickcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[2]
		kicked = ComponentGetValue2( kickcomp, "value_int")
		if (kicked > 300) then
            	    local d_opts = {"300..."}
            	    local dialogue = d_opts[math.random(1,#d_opts)]
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 222
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"...I'm not narrating these anymore."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "power"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_14") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
		local kicked = 0
                local kickcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[2]
		kicked = ComponentGetValue2( kickcomp, "value_int")
		if (kicked > 500) then
            	    local d_opts = {"At the end of time, as the world shifts back into the marshlands it was constructed atop of... you will still be kicking."}
            	    local dialogue = d_opts[math.random(1,#d_opts)]
            	    tone = "long"
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if GameHasFlagRun("apotheosis_heretalk_id_14") and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
		local kicked = 0
                local kickcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[2]
		kicked = ComponentGetValue2( kickcomp, "value_int")
		local streak_attempt = ComponentGetValue2( kickcomp, "value_bool")
		local kick_streak = tonumber(ComponentGetValue2( kickcomp, "value_string"))
		if (streak_attempt == true) and (kicked == 0) and (kick_streak >= 10) then
                    ComponentSetValue2( kickcomp, "value_boolean", false)
                    local period = "."
                    if (kick_streak > 150) then
                        period = "!"
                    elseif (kick_streak >= 30) then
                        period = "..."
                    end
            	    local dialogue = (tostring(kick_streak) .. " kicks" .. period)
                    tone = "power"
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 225
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local kickcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[2]
		local kick_streak = tonumber(ComponentGetValue2( kickcomp, "value_string"))
		ComponentSetValue2( kickcomp, "value_bool", false)
                local d_opts = {"Good job."}
                if (kick_streak >= 500) then
                    d_opts = {"I'm sorry for your loss."}
                elseif (kick_streak >= 300) then
                    d_opts = {"You've finally tired..."}
                    tone = "gossip"
                elseif (kick_streak >= 150) then
                    d_opts = {"Bored?"}
                    tone = "gossip"
                elseif (kick_streak >= 100) then
                    d_opts = {"Leaving it off on a high note I see..."}
                elseif (kick_streak < 100) and GameHasFlagRun("apotheosis_heretalk_cynical") then
                    d_opts = {"Good job."}
		    tone = "power"
                elseif (kick_streak >= 30) then
                    d_opts = {"...Yeah."}
                    tone = "gossip"
                end
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 226
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) and GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-2)) then
                local d_opts = {"This line breaks the dialogue script if it tries to play apparently."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "quiet"
                GameRemoveFlagRun("apotheosis_heretalk_id_" .. tostring(num-1))
                GameRemoveFlagRun("apotheosis_heretalk_id_" .. tostring(num-2))
                return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local here = EntityGetInRadiusWithTag( x, y, 175, "apotheosis_heretic" ) or {}
            for bp=1,#here do
                if here[bp] ~= entity_id and EntityGetName(here[bp]) == "apotheosis_heretic_eye_pickup" then
                    stone_over = true
                    local d_opts = {"Hello."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            local here = EntityGetInRadiusWithTag( x, y, 175, "apotheosis_heretic" ) or {}
            for bp=1,#here do
                if here[bp] ~= entity_id and EntityGetName(here[bp]) == "apotheosis_heretic_eye_pickup" then
                    stone_over = true
                    local d_opts = {"Hi."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            if ModIsEnabled("InventoryBags") then
		local bagged = false
                local bagcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[3]
		bagged = ComponentGetValue2( bagcomp, "value_bool")
		if (bagged == true) then
            	    local d_opts = {"...Are you attempting to stuff me in this bag?"}
            	    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "long"
            	    return true, dialogue
		end
		return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 230
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"I will not be entering such a place..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "power"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local cats = 0
            local cat = EntityGetInRadiusWithTag( x, y, 200, "acid" ) or {}
            for bp=1,#cat do
                local audiocomp = EntityGetFirstComponentIncludingDisabled(cat[bp],"AudioComponent")
                if ComponentGetValue2(audiocomp,"event_root") == "apotheosis/kittycat" then
                    cats = cats + 1
                end
	    end
            if cats >= 10 then
                local d_opts = {"This is an unhealthy amount of felines..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "gossip"
                return true, dialogue
            end
            return false
        end
    },
    {
        trigger = function()
            if (stashed == true) then
            	local d_opts = {"...It's quite stuffy in here."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if (stashed == true) then
            	local d_opts = {"I feel I'm being treated much like a knickknack..."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_vault" then
                local d_opts = {"You know there was once tales of giants who wandered these lands..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 235
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"It was said that their eventual corpses sank deep below the soil, to then be feasted upon by various lifeforms..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "islandspirit" ) or {}
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$animal_islandspirit" then
                    local d_opts = {"Ah, this elk apparition..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "islandspirit" ) or {}
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$animal_islandspirit" then
                    local d_opts = {"I've had it appear before me a few times in the past...","I've encountered it in the past..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "long"
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "islandspirit" ) or {}
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$animal_islandspirit" then
                    local d_opts = {"Quite the nuisance..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "miniboss" ) or {}
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$animal_boss_sky" then
                    local d_opts = {"What is this..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "miniboss" ) or {}
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$animal_boss_sky" then
                    local d_opts = {"Is this... you?"}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "miniboss" ) or {}
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$animal_boss_meat" then
                    local d_opts = {"This mass of flesh holds quite the curse over these rotting caverns..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "long"
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "miniboss" ) or {}
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$animal_boss_meat" then
                    --It is funny how many ideas the devs accidentally ended up using from Apoth with that update :p -S
                    local d_opts = {"Well, it seems it shares some of my prior characteristics..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        trigger = function()
            --Funny non-canon lines :)
            if GameHasFlagRun("apotheosis_towerclimb") then
                local d_opts = {"Odd... do you feel that strange surge of energy?"}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            elseif GameHasFlagRun("apotheosis_nightmode") then
                local d_opts = {"What a horrible night to have a curse..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "gossip"
                return true, dialogue
            elseif GameHasFlagRun("apotheosis_hardmode") then
                local d_opts = {"The least you could do is not take that meddling perk."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "gossip"
                return true, dialogue
            elseif GameHasFlagRun("apotheosis_missingmagic") then
                local d_opts = {"You appear to be having trouble using your spells..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "gossip"
                return true, dialogue
            elseif GameHasFlagRun("apotheosis_alchemistdream") then
                local d_opts = {"Have you noticed there's been a heightened surge of alchemical energy as of late?"}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            elseif GameHasFlagRun("apotheosis_addict") then
                local d_opts = {"Hold on... have you been shifting again?"}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "power"
                return true, dialogue
            elseif GameHasFlagRun("apotheosis_poverty") then
                local d_opts = {"Hmph, poor!"}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "gossip"
                return true, dialogue
            elseif GameHasFlagRun("apotheosis_downunder") then
                local d_opts = {"I feel as if my mind's been twisted the wrong way..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            elseif GameHasFlagRun("apotheosis_everything") then
                local d_opts = {"Hm, why has the world undergone such a drastic metamorphosis?"}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            end
            return false
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_towerclimb") then
                local d_opts = {"I'm sensing more lifeforms than typical within' these caverns..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            elseif GameHasFlagRun("apotheosis_nightmode") then
                local d_opts = {"The least you could do is not take that meddling perk on this fine night."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            elseif GameHasFlagRun("apotheosis_missingmagic") then
                local d_opts = {"Still but a novice are you?"}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "gossip"
                return true, dialogue
            elseif GameHasFlagRun("apotheosis_addict") then
                local d_opts = {"I told you to lay off those powders!"}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "power"
                return true, dialogue
            elseif GameHasFlagRun("apotheosis_downunder") then
                local d_opts = {"The world doesn't look the same as it used to."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            elseif GameHasFlagRun("apotheosis_everything") then
                local d_opts = {"I can barely comprehend what kind of force would cause such a thing."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            end
            return false
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_everything") then
                local d_opts = {"Although... some of the details seem, strangely familiar..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            end
            return false
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_jungle_fleshy" then
                local d_opts = {"Uhhhh..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local altar_check = EntityGetInRadiusWithTag( x, y, 965, "gate_monster" ) or {}
            if currbiome == "$biome_empyrean" and EntityGetParent(entity_id) ~= 0 and not GameHasFlagRun("apotheosis_ending_cutscene") then
		local check = false
                for ac=1,#altar_check do
                    if EntityGetName(altar_check[ac]) == "apotheosis" then
            	        check = true
                    end
	        end
                if check == false then
            	    local d_opts = {"Go back."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "power"
                    return true, dialogue
                end
	        return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local altar_check = EntityGetInRadiusWithTag( x, y, 965, "gate_monster" ) or {}
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if currbiome == "$biome_empyrean" and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and not GameHasFlagRun("apotheosis_ending_cutscene") then
		local check = false
                for ac=1,#altar_check do
                    if EntityGetName(altar_check[ac]) == "apotheosis" then
            	        check = true
                    end
	        end
                if check == false then
            	    local d_opts = {"I see..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
                end
	        return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local altar_check = EntityGetInRadiusWithTag( x, y, 965, "gate_monster" ) or {}
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if currbiome == "$biome_empyrean" and not GameHasFlagRun("apotheosis_ending_cutscene") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true then
		local check = false
                for ac=1,#altar_check do
                    if EntityGetName(altar_check[ac]) == "apotheosis" then
            	        check = true
                    end
	        end
                if check == false then
            	    local d_opts = {"I hope you know this will change nothing..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "power"
                    return true, dialogue
                end
	        return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_evil_temple" then
            local room_spot = EntityGetInRadiusWithTag( x, y, 110, "gate_monster" ) or {}
		local check = false
                for rs=1,#room_spot do
                    if EntityGetName(room_spot[rs]) == "apotheosis_room1_check" then
            	        check = true
                    end
	        end
                if check then
            	    local d_opts = {"This place is in poor condition..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
                    return true, dialogue
                end
	        return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 251
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"These flasks used to have real substances within'..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 252
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"Now... it's all red."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_evil_temple" then
            local room_spot = EntityGetInRadiusWithTag( x, y, 110, "gate_monster" ) or {}
		local check = false
                for rs=1,#room_spot do
                    if EntityGetName(room_spot[rs]) == "apotheosis_room2_check" then
            	        check = true
                    end
	        end
                if check then
            	    local d_opts = {"..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "quiet"
                    return true, dialogue
                end
	        return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_evil_temple" then
            local room_spot = EntityGetInRadiusWithTag( x, y, 75, "gate_monster" ) or {}
		local check = false
                for rs=1,#room_spot do
                    if EntityGetName(room_spot[rs]) == "apotheosis_evil_slab" then
            	        check = true
                    end
	        end
                if check then
            	    local d_opts = {"I used to fashion many a device upon this wedge..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    return true, dialogue
                end
	        return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 255
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"It likely still functions in forgery..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "???" and GameHasFlagRun("apotheosis_heretalk_perk_creation_defiled") then
                local perk_altar = EntityGetInRadiusWithTag( x, y, 150, "curse" ) or {}
                for pa=1,#perk_altar do
                    if EntityGetName(perk_altar[pa]) == "apotheosis_perk_creation_altar" then
            	        local d_opts = {"This altar is undeserving of such destruction..."}
			tone = "power"
                        local dialogue = d_opts[math.random(1,#d_opts)]
                        return true, dialogue
                    end
	        end
	        return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "necromancer_shop" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$animal_necromancer_shop" then
                    local d_opts = {"Oh... one of these...", "Oh, it's the sentinel of minor defilement...", "Oh, it's the dispatcher of the gods busywork."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            num = 258
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"Dispatch it quickly, please.","I can't stand the sight of them...","I do not have a good history with them."}
                if( GlobalsGetValue("TEMPLE_PEACE_WITH_GODS") == "1" ) then
                    d_opts = {"You seem safe now, but there's some occurrences they won't turn a blind eye to..."}
                    tone = "long"
                end
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "necromancer_super" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$animal_necromancer_super" then
                    local d_opts = {"Glad to see I'm not the only one who's summoned these..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
                    return true, dialogue
                end
            end
            return false
        end
    },
    {
        trigger = function()
            num = 260
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"I recommend disabling their shields.","I recommend you distort their carbon particles.","I recommend you neutralize their scepter."}
                if( GlobalsGetValue("TEMPLE_PEACE_WITH_GODS") == "1" ) then
                    d_opts = {"You feared their pursuit enough to acquire a showing of peace?"}
                end
                local dialogue = d_opts[math.random(1,#d_opts)]
                tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 261
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"Is that within' your capabilities?","Are you capable of achieving that?"}
                tone = "gossip"
                if( GlobalsGetValue("TEMPLE_PEACE_WITH_GODS") == "1" ) then
                    d_opts = {"I would keep an eye on them... They will betray your trust if you take a stumble too far..."}
                    tone = "long"
                end
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if ModIsEnabled("grahamsperks") and GameHasFlagRun("apotheosis_heretalk_id_14") then
                local evil_eye = nil
                local evil_eyes = EntityGetInRadiusWithTag( x, y, 175, "evil_eye" ) or {}
                for bp=1,#evil_eyes do
                    local evil_light = EntityGetFirstComponentIncludingDisabled(evil_eyes[bp],"LightComponent")
                    local evil_ui = EntityGetFirstComponentIncludingDisabled(evil_eyes[bp],"UIInfoComponent")
                    local ui_name = ComponentGetValue2(evil_ui,"name")
                    if ComponentGetIsEnabled( evil_light ) == true and ui_name == "$graham_cybereye_name" then
                        evil_eye = evil_eyes[bp]
                    end
	        end
                local evil_held = EntityGetFirstComponentIncludingDisabled( evil_eye, "SpriteComponent" )
                local evil_body = EntityGetFirstComponentIncludingDisabled( evil_eye,"PhysicsBodyComponent")
	        if evil_eye ~= nil and ( ComponentGetIsEnabled(evil_held) == true or ( ComponentGetIsEnabled( evil_body ) == true and EntityGetParent(evil_eye) == 0 )) then
                    local d_opts = {"In spite of its cybernetics, this eye has not learnt to speak."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "long"
                    return true, dialogue
	        end
                return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_heretalk_id_14") then
                local gourd = nil
                local gourds = EntityGetInRadiusWithTag( x, y, 175, "gourd" ) or {}
                for bp=1,#gourds do
                    local gourd_ui = EntityGetFirstComponentIncludingDisabled(gourds[bp],"UIInfoComponent")
                    local ui_name = ComponentGetValue2(gourd_ui,"name")
                    if ui_name == "$item_apotheosis_gourd_holy_name" then
                        gourd = gourds[bp]
                    end
	        end
                local gourd_held
                if gourd ~= nil then
                    local gourd_held = EntityGetComponentIncludingDisabled( gourd, "SpriteComponent" )[2]
                end
                local gourd_body = EntityGetFirstComponentIncludingDisabled( gourd,"PhysicsBodyComponent")
	        if gourd ~= nil and ( ComponentGetIsEnabled(gourd_held) == true or ( ComponentGetIsEnabled( gourd_body ) == true and EntityGetParent(gourd) == 0 )) then
                    local d_opts = {"Ugh."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "power"
                    return true, dialogue
	        end
                return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_heretalk_id_14") then
                local gourd = nil
                local gourds = EntityGetInRadiusWithTag( x, y, 175, "gourd" ) or {}
                for bp=1,#gourds do
                    local gourd_ui = EntityGetFirstComponentIncludingDisabled(gourds[bp],"UIInfoComponent")
                    local ui_name = ComponentGetValue2(gourd_ui,"name")
                    if ui_name == "$item_apotheosis_gourd_holy_name" then
                        gourd = gourds[bp]
                    end
	        end
                if gourd ~= nil then
                    local gourd_held = EntityGetComponentIncludingDisabled( gourd, "SpriteComponent" )[2]
                end
                local gourd_body = EntityGetFirstComponentIncludingDisabled( gourd,"PhysicsBodyComponent")
	        if gourd ~= nil and ( ComponentGetIsEnabled(gourd_held) == true or ( ComponentGetIsEnabled( gourd_body ) == true and EntityGetParent(gourd) == 0 )) then
                    local d_opts = {"A sickening produce..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "power"
                    return true, dialogue
	        end
                return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 265
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"I am glad to now be immune to its effects..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if GameHasFlagRun("apotheosis_heretalk_id_14") then
                local gourd = nil
                local gourds = EntityGetInRadiusWithTag( x, y, 175, "gourd" ) or {}
                for bp=1,#gourds do
                    local gourd_ui = EntityGetFirstComponentIncludingDisabled(gourds[bp],"UIInfoComponent")
                    local ui_name = ComponentGetValue2(gourd_ui,"name")
                    if ui_name == "$item_gourd" then
                        gourd = gourds[bp]
                    end
	        end
                local gourd_held = EntityGetFirstComponentIncludingDisabled( gourd, "SpriteComponent" )
                local gourd_body = EntityGetFirstComponentIncludingDisabled( gourd,"PhysicsBodyComponent")
	        if gourd ~= nil and ( ComponentGetIsEnabled(gourd_held) == true or ( ComponentGetIsEnabled( gourd_body ) == true and EntityGetParent(gourd) == 0 )) then
                    local d_opts = {"This vegetable always exhibited a peculiar energy..."}
                    local dialogue = d_opts[math.random(1,#d_opts)]
		    tone = "gossip"
                    return true, dialogue
	        end
                return false
            else
                return false
            end
        end
    },
    {
        trigger = function()
            num = 267
            if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(num-1)) then
                local d_opts = {"I wonder what potential it holds..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        trigger = function()
            if #EntityGetInRadiusWithTag( x, y, 250, "secret_fruit" ) ~= 0 then
                local d_opts = {"...Oh dear."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
}

--Cycles through events table and runs their trigger function, will skip an entry if it's already been spoken
--Conga: No fucking way this is optimised lmao
--Spoop: Haha... yeah...
for k=1,#events do
    if not GameHasFlagRun(table.concat({"apotheosis_heretalk_id_",k})) and events[k].trigger() == true and EntityHasTag(entity_id,"graham_speaking") == false then
      if ((stone_over == true) or not GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed")) then
        local bool, dialogue = events[k].trigger()
        Speak(entity_id, dialogue)
	if (tone ~= "quiet") then
            GamePrint(table.concat({GameTextGetTranslatedOrNot("$item_apotheosis_heretical_eye_name"),": ",dialogue}))
	end
	if (tone == "norm") then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/heretical_eye/speech_norm", x, y );
	elseif (tone == "power") then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/heretical_eye/speech_power", x, y );
	elseif (tone == "gossip") then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/heretical_eye/speech_gossip", x, y );
	elseif (tone == "quiet") then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/heretical_eye/speech_quiet", x, y );
	elseif (tone == "yell") then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/heretical_eye/speech_yell", x, y );
	elseif (tone == "long") then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/heretical_eye/speech_long", x, y );
	elseif (tone == "pained") then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/heretical_eye/speech_pained", x, y );
	else
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/heretical_eye/speech_norm", x, y );
	end
        print("what's heretic thinking about: " .. tostring(k))
        GameAddFlagRun(table.concat({"apotheosis_heretalk_id_",k}))
        break
      end
    end
end

--Debug Data
--GamePrint(tostring(BiomeMapGetName( x, y )))
--if "$biome_mestari_secret" == tostring(BiomeMapGetName( x, y )) then
--    GamePrint("Match Found")
--end

--Kick script?
--"Oi! Quit that", "You don't have to kick me"
-- Meh, maybe... - Spoop