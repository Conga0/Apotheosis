dofile_once("data/scripts/lib/utilities.lua") --Tired Sinning
--Hello yes thank you Graham for letting me "borrow" this :) - Spoop

-- Specific scenario for the Sheep Ending
if #EntityGetWithTag("player_unit") < 1 and not GameHasFlagRun("apotheosis_heretalk_end_sheep_2") then 
    --Debug Data
    --print("no playor?") 
return end -- don't speak when there's no player
--Conga: Might be funny if he made fun of your death
--"You crawl into my tomb, crack my coffin open, rend MY flesh apart, but you die to a purple freak because he turned you into a sheep? You're pathetic"
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
-- what tone of voice Mr. Heretical uses when speaking
local tone = "norm"
-- "norm" is normal speech
-- "power" is when he's being intimidating or imposing
-- "gossip" is when he makes an off handed comment or something
-- ^ one of the sounds sort of sound like a laugh so you could also use it for when he's joking
-- "quiet" is when he's trying to be quiet, only really used in the introduction
-- "yell" is when he's screaming at you, only really used for mountain altar
-- "long" is when there's a lot of dialogue, mostly when informing/scolding you of something
-- will default to "norm" if nothing is given

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
        _tags = "enabled_in_world, enabled_in_hand, enabled_in_inventory, graham_speech_text",    --Conga: This could be tag optimised...
        image_file = "mods/apotheosis/files/fonts/font_pixel_flesh.xml",
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
        script_source_file="mods/apotheosis/files/scripts/items/heretical_eye_dialogue_quiet.lua"
    })
end

--List of one-time dialogue events
local events = {
    {
        --1 Spawned in before Heretic was killed
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            local heretic_unstashed = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsBodyComponent" )
            if not GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") then
		tone = "power"
                local d_opts = {"You shouldn't be tampering with things out of your understanding..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                GameAddFlagRun("apotheosis_heretalk_id_2")
                GameAddFlagRun("apotheosis_heretalk_id_3")
                GameAddFlagRun("apotheosis_heretalk_id_4")
                GameAddFlagRun("apotheosis_heretalk_id_5")
                GameAddFlagRun("apotheosis_heretalk_id_6")
                GameAddFlagRun("apotheosis_heretalk_id_7")
                GameAddFlagRun("apotheosis_heretalk_id_8")
                GameAddFlagRun("apotheosis_heretalk_id_9")
                GameAddFlagRun("apotheosis_heretalk_id_10")
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --2 Just after being slain
        trigger = function()
            local d_opts = {"Kirottu!","Röyhkeä-!"}
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
        --3 Just after being slain 2
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
        --4 Just after being slain 3
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
        --5 Initial dialogue after being picked up
        trigger = function()
            local heretic_unstashed = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsBodyComponent" )
            if ComponentGetIsEnabled(heretic_unstashed) == false then
            	local d_opts = {"What is it?","Well, what do you have to say?","Look who it is..."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
                GameAddFlagRun("apotheosis_heretalk_id_2")
                GameAddFlagRun("apotheosis_heretalk_id_3")
                GameAddFlagRun("apotheosis_heretalk_id_4")
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        --6 Secondary dialogue after being picked up
        trigger = function()
            local heretic_unstashed = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsBodyComponent" )
            if ComponentGetIsEnabled(heretic_unstashed) == false then
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
        --7 Being shown the surface
        trigger = function()
            local worldEntity = GameGetWorldStateEntity()
            local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")
            local time = ComponentGetValue2(comp,"time")
            if y < 0 and (time < 0.30 or time > 0.80) then
                local d_opts = {"Bright out...","The blinding light from above is not something I expected to see so soon."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --8 Being shown the surface 2
        trigger = function()
            local worldEntity = GameGetWorldStateEntity()
            local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")
            local time = ComponentGetValue2(comp,"time")
            if y < 0 and (time < 0.30 or time > 0.80) then
                local d_opts = {"I'm more used to dark catacombs.","It burns lightly."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --9 Being taken outside of the Temple of Sacrligious Remains
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome ~= "$biome_evil_temple" and currbiome ~= "???" and currbiome ~= "$biome_orbroom" then
                local d_opts = {"I see you're ready to leave...","Not quite fond of my home?","I suppose that place was getting a little monotonous anyways...","...Not very appreciative of the architecture?","Intriguing...","I suppose it would be nice to leave."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --10 Being taken outside of the Temple of Sacrligious Remains 2
	--Since everyone seems to be focused on the finding his home part, just something to get people off his case
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome ~= "$biome_evil_temple" and currbiome ~= "???" and currbiome ~= "$biome_orbroom" then
                local d_opts = {"Do you happen have anything interesting to show?","Do you have something to accomplish?"}
                local dialogue = d_opts[math.random(1,#d_opts)]
            	tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --11 Being taken into the Planes Portal
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local dialogue = "It can't be..."
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "apotheosis_portal" ) ~= 0 then
            	tone = "power"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --12 Being shown the Planes Portal openned
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "_EMPTY_" then
                if #EntityGetInRadiusWithTag( x, y, 250, "apotheosis_portal" ) ~= 0 then
                    if GameHasFlagRun("apotheosis_heretalk_portal_complete") and tonumber(GlobalsGetValue("apotheosis_plane_fail",0)) ~= 1 then
                        local dialogue = "This is... an impressive feat..."
            		tone = "power"
			return true, dialogue
                    elseif GameHasFlagRun("apotheosis_heretalk_portal_fail") and tonumber(GlobalsGetValue("apotheosis_plane_fail",0)) == 1 then
                	local d_opts = {"One too many detours. I believe you serve no more use to me.","You lost, I believe you can throw me out now."}
            		tone = "long"
                	local dialogue = d_opts[math.random(1,#d_opts)]
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
        --13 Being brought to the perk creation altar
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local perk_altar = EntityGetInRadiusWithTag( x, y, 300, "curse" ) or {}
            if currbiome == "???" then
                for pa=1,#perk_altar do
                    if EntityGetName(perk_altar[pa]) == "apotheosis_perk_creation_altar" then
            	        local d_opts = {"My pride and joy"}
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
        --14 Being brought to the Mountain Altar
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
        --15 Held out at Mountain Altar
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_held = EntityGetFirstComponentIncludingDisabled( entity_id, "SpriteComponent" )
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "ending_sampo_spot_mountain" ) ~= 0 and ComponentGetIsEnabled(heretic_held) == true then
            	local d_opts = {"I heavily wouldn't advise this..."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "power"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        --16 Thrown onto Mountain Altar
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "ending_sampo_spot_mountain" ) ~= 0 and EntityGetWithName( "heretic_killer" ) ~= 0 and ComponentGetIsEnabled( heretic_body ) == true and EntityGetParent(entity_id) == 0 and GameHasFlagRun("heretic_near_death") then
            	rate = 1.0
           	size_x = 1.0
           	size_y = 1.0
            	GameRemoveFlagRun("apotheosis_heretalk_id_17")
            	GameRemoveFlagRun("apotheosis_heretalk_id_18")
            	GameRemoveFlagRun("apotheosis_heretalk_id_19")
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
        --17 Thrown onto Mountain Altar 2
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "ending_sampo_spot_mountain" ) ~= 0 and EntityGetWithName( "heretic_killer" ) ~= 0 and ComponentGetIsEnabled( heretic_body ) == true and EntityGetParent(entity_id) == 0 and GameHasFlagRun("heretic_near_death") then
            	rate = 1.0
           	size_x = 1.0
           	size_y = 1.0
            	GameRemoveFlagRun("apotheosis_heretalk_id_16")
            	GameRemoveFlagRun("apotheosis_heretalk_id_17")
            	GameRemoveFlagRun("apotheosis_heretalk_id_18")
            	GameRemoveFlagRun("apotheosis_heretalk_id_19")
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
        --18 Brought to Mountain Altar after thrown
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "ending_sampo_spot_mountain" ) ~= 0 and GameHasFlagRun("heretic_near_death") and EntityGetWithName( "heretic_killer" ) == 0 then
		local d_opts = {"Close one..."}
		tone = "gossip"
		if GameHasFlagRun("apotheosis_heretalk_cynical") then
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
        --19 Brought to Mountain Altar after thrown 2
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "ending_sampo_spot_mountain" ) ~= 0 and GameHasFlagRun("heretic_near_death") and EntityGetWithName( "heretic_killer" ) == 0 and GameHasFlagRun("apotheosis_heretalk_id_18") then
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
        --20 Brought to Mountain Altar after thrown 3
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "ending_sampo_spot_mountain" ) ~= 0 and GameHasFlagRun("heretic_near_death") and EntityGetWithName( "heretic_killer" ) == 0 and GameHasFlagRun("apotheosis_heretalk_id_19") then
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
        --21 Don't mind me, just here to deactivate the near death flag
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "_EMPTY_" and #EntityGetInRadiusWithTag( x, y, 250, "ending_sampo_spot_mountain" ) ~= 0 and GameHasFlagRun("heretic_near_death") and EntityGetWithName( "heretic_killer" ) == 0 and GameHasFlagRun("apotheosis_heretalk_id_19") and GameHasFlagRun("apotheosis_heretalk_id_20") then
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
        --22 Being shown his imprisoned self
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local prison_spot = EntityGetInRadiusWithTag( x, y, 250, "gate_monster" ) or {}
            if currbiome == "???" then
                for ps=1,#prison_spot do
                    if EntityGetName(prison_spot[ps]) == "apotheosis_flesh_boss_inert" then
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
        --23 Being shown his alive self
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "miniboss" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "$creep_apotheosis_boss_flesh_monster_name" then
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
        --24 Being brought to his prison spot
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
        --25 Being taken into an Orb Room, also counts the Sacreligious one
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
        --26 Being taken into the Sinkhole
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
        --27 Being taken into the Wizard's Den
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
        --28 Being taken into the Wizard's Den 2
        --Attempt to make it so he talks twice about something, but seems to not work
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_wizardcave" then
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
        --29 Being taken into the Throne Room
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local dialogue = "You..."
            if currbiome == "$biome_mestari_secret" then
                if EntityGetWithName( "$animal_boss_wizard" ) ~= 0 then
                    GameAddFlagRun("apotheosis_heretalk_mom_alive")
		    tone = "power"
                    return true, dialogue
                elseif GameHasFlagRun("apotheosis_mom_dead") then
                    dialogue = "Hmm... I don't sense his presence..."
                    return true, dialogue
                else
                    dialogue = "Hmm... Curious, where's he run off to..."
		    tone = "gossip"
                    return true, dialogue
                end
            else
                return false
            end
        end
    },
    {
        --30 Being taken into the Throne Room secondary if MoM is found dead
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_mestari_secret" and GameHasFlagRun("apotheosis_mom_dead") then
                if GameHasFlagRun("apotheosis_heretalk_mom_alive") then
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
        --31 Transported to the Yggdrasil's Plane
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_plane_yggdrasil" then
                local d_opts = {"Astonishing..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --32 Transported to the Yggdrasil's Plane 2
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_plane_yggdrasil" then
                local d_opts = {"The tales were true..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --33 Transported to the Yggdrasil's Plane 3
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_plane_yggdrasil" then
                local d_opts = {"A realm of vast overgrowth and ascended beings."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "long"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --34 Transported to the Soul Plane
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_plane_magic" then
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
        --35 Transported to the Soul Plane 2
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_plane_magic" then
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
        --36 Transported to the Tech Plane
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_plane_technology" then
                local d_opts = {"Can you comprehend how deep we are?"}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --37 Transported to the Tech Plane 2
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_plane_technology" then
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
        --38 Transported to the Tech Plane 3
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_plane_technology" then
                local d_opts = {"We're so close..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --39 Being taken into the Empyrean
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" then
                local d_opts = {"Is this...?","Finally...","I can't believe it..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --40 Being taken into the Empyrean 2
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" then
                local dialogue = "Continue forward, just a bit further."
		tone = "power"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --41 Taken to Parallel World
        trigger = function()
            local parallel = GetParallelWorldPosition(x, y)
            if parallel ~= 0 and tonumber(GlobalsGetValue("apotheosis_plane_fail",0)) == 1 then
            	local d_opts = {"You've made a grave mistake..."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
                GameAddFlagRun("apotheosis_heretalk_id_42")
                GameAddFlagRun("apotheosis_heretalk_id_43")
                GameAddFlagRun("apotheosis_heretalk_id_44")
		tone = "power"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        --42 Taken to Parallel World before Plane fail
        trigger = function()
            local parallel = GetParallelWorldPosition(x, y)
            if parallel ~= 0 then
            	local d_opts = {"Leave while you still can!"}
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "power"
                GameAddFlagRun("apotheosis_heretalk_id_43")
                GameAddFlagRun("apotheosis_heretalk_id_44")
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        --43 Taken nearby a Parallel World
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
        --44 Taken nearby a Parallel World 2
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local worldsize = tonumber((ModTextFileGetContent("data/compatibilitydata/worldsize.txt") or 35840))
            worldsize = worldsize * 0.475
            if currbiome == "_EMPTY_" and x > worldsize or x < (worldsize * -1) then
            	local d_opts = {"You'd cause something irreversible..."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "power"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        --45 Heretic Ending Dialogue
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" and GameHasFlagRun("apotheosis_heretalk_end_1") then
            	rate = 5
            	local d_opts = {"...Fortunate."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        --46 Heretic Ending Dialogue 2
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" and GameHasFlagRun("apotheosis_heretalk_end_2") then
            	local d_opts = {"I must commend you, you did a lot of work."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        --47 Heretic Ending Dialogue 3
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" and GameHasFlagRun("apotheosis_heretalk_end_3") then
            	local d_opts = {"However, I believe it's time we part ways..."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        --48 Heretic Sheep Ending Dialogue
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" and GameHasFlagRun("apotheosis_heretalk_end_sheep_1") then
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
        --49 Heretic Sheep Ending Dialogue 2
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" and GameHasFlagRun("apotheosis_heretalk_end_sheep_1") then
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
        --50 Heretic Sheep Ending Dialogue 3
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" and GameHasFlagRun("apotheosis_heretalk_end_sheep_2") then
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
        --51 Heretic Sheep Ending Dialogue 3
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" and GameHasFlagRun("apotheosis_heretalk_end_sheep_2") then
            	local d_opts = {"Disappointing..."}
            	local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "power"
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        --52 Being shown Guiding Stone
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local guiding_stone = EntityGetInRadiusWithTag(x,y,150,"seed_a")[1] or nil
            if guiding_stone ~= nil then
            local sprite_comp = EntityGetComponentIncludingDisabled(guiding_stone,"PhysicsImageShapeComponent")[1]
            local image_file = ComponentGetValue2(sprite_comp,"image_file")
            if GameHasFlagRun("apotheosis_heretalk_guiding_stone") and (image_file == "mods/apotheosis/files/items_gfx/goldnugget_01_alt_radar.png") then
                local d_opts = {"That's... curious..."}
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
        --53 Begin cynicism
        trigger = function()
            if GameHasFlagRun("apotheosis_heretalk_id_52") then
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
        --54 Guiding stone perk altar hint
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
        --55 Plane radar perk acquired
	--I'm very good at coding :) -Spoop
        trigger = function()
            local radar_perk = 0
            local player_id = EntityGetInRadiusWithTag(x,y,20,"player_unit") or nil
            local lua_comps = EntityGetComponentIncludingDisabled(player_id,"LuaComponent") or nil
            if lua_comps ~= nil then
                for i = 1, #lua_comps do
		    if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/apotheosis/files/scripts/perks/plane_radar.lua" then
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
        end
    },
    {
        --56 Being taken into Abyssum
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
        --57 Being taken into Abyssum 2
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
-- Misc. Stuff (I just want him to seem quite interactive :P)
    {
        --58 Being taken into Overgrown Caverns
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
        --59 Being taken into Overgrown Caverns 2
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_fun" then
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
        --60 Being taken into Pyramid
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
        --61 Being taken into Abandoned Alchemy Lab
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
        --62 Being taken into Power Plant
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
        --63 Being taken into Vault
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
        --64 Being taken into Lukki Lair with Graham's Things
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_rainforest_dark" and ModIsEnabled("grahamsperks") then
                local d_opts = {"Strange..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --65 Being taken into Lukki Lair with Graham's Things 2
	--Wink wink nudge nudge ;)
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_rainforest_dark" and ModIsEnabled("grahamsperks") then
                local d_opts = {"I remember these arachnids being more insatiable..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --66 Being taken into Snow Chasm
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
        --67 Being taken into Snow Chasm 2
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_winter_caves" then
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
        --68 Being taken into Core Mines
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
        --69 Being taken into Core Mines 2
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_lava_excavation" then
                local d_opts = {"It appears to be a nesting site for flame infused invertebrates."}
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
        --Being taken into Ant Hill
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
        --Being taken into Ant Hill 2
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
        --70 Being taken into Virulent Caverns
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
        --71 Being taken into Virulent Caverns 2 (Cynicism)
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
-- Mmm... nevermind I'm not smart enough rn : )
--[[
    {
        --Left in Wizard Den for too long
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_wizardcave" then
		local timer = nil
                local varcomps = EntityGetComponent( projectile_id, "VariableStorageComponent" )
		    if ( varcomps ~= nil ) then
			for j,vcomp_id in ipairs(varcomps) do
			    local name = ComponentGetValue2( vcomp_id, "name" )
					
			    if ( name == "dialogue_timer" ) then
				timer = vcomp_id
				break
			    end
			end
		    end
                if timer
                local d_opts = {"Eeee"}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
]]--
    {
        --72 Being taken into the Laboratory
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
        --73 Being taken into the Work (Above) or Work (Below)
        trigger = function()
            local work = EntityGetClosestWithTag( x, y, "ending_sampo_spot_underground" ) or {}
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_boss_victoryroom" and work == nil then
                local d_opts = {"As above, so below..."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --74 Being taken into the Work (Ending)
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
        --75 Being taken into Sunken Caverns
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
        --76 Being taken into Sunken Caverns 2
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
        --77 Trying to be destroyed by a blackhole
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_unstashed = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsBodyComponent" )
            if #EntityGetInRadiusWithTag( x, y, 30, "black_hole" ) ~= 0 and ComponentGetIsEnabled(heretic_unstashed) == true then
                local d_opts = {"Really now?"}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --78 Trying to be destroyed by a blackhole 2
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
        --79 Trying to be destroyed by a blackhole 3
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
        --80 Being shown Three Eye
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
        --81 Being shown Three Eye 2
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
        --82 Being shown Squidward
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
        --83 Being shown Three Eye's Eye
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
        --84 Being shown Three Eye's Legs
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
        --85 Being shown Gate Guardian
        trigger = function()
            local boss_gate = EntityGetInRadiusWithTag( x, y, 200, "gate_monster" ) or nil
            if #boss_gate ~= 0 then
                local d_opts = {"...Excessive."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --86 Being shown Leviathan
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
        --87 Being shown Dragon
        trigger = function()
            local boss_dragon = EntityGetInRadiusWithTag( x, y, 200, "boss_dragon" ) or nil
            if #boss_dragon ~= 0 then
                local d_opts = {"Hm, a scaled pike?"}
		if GameHasFlagRun("apotheosis_heretalk_cynical") then
            	    d_opts = {"A mere infantile pike?.. You could find more extraordinary beasts to fell than this..."}
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
        --88 Being shown Forgotten
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
        --89 Being shown High Alchemist
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
        --90 Being shown Tiny
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
        --91 Being shown Aesthete
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
        --92 Being shown Toxic Worm
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 200, "miniboss" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "Jättiläinen myrkyllinen mato" then
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
        --93 Being shown Toxic Worm 2
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 200, "miniboss" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "Jättiläinen myrkyllinen mato" then
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
        --94 Being shown Collosal Blob
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
        --95 Being shown Abandoned Orchestra
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "boss_ghost_helper" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "Hylätty orkesteri" then
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
        --96 Being shown Divine Being
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "miniboss" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "Jumalallinen olento" then
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
        --97 Being shown Monolith
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "touchmagic_immunity" ) or nil
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "Monoliitti" then
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
        --98 Being shown Monolith dead
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "touchmagic_immunity" ) or nil
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
        --99 Being shown Friend
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
        --100 Being shown Friend 2
        trigger = function()
            if #EntityGetInRadiusWithTag( x, y, 200, "big_friend" ) ~= 0 then
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
        --101 Being shown Abyssal Entity
        trigger = function()
            local boss = EntityGetInRadiusWithTag( x, y, 175, "touchmagic_immunity" ) or {}
            for bp=1,#boss do
                if EntityGetName(boss[bp]) == "Abyssaalinenolento" then
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
        --102 Thrown onto perk altar
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
        --103 Thrown onto perk altar 2
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local perk_altar = EntityGetInRadiusWithTag( x, y, 60, "curse" ) or {}
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if currbiome == "???" and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true then
                for pa=1,#perk_altar do
                    if EntityGetName(perk_altar[pa]) == "apotheosis_perk_creation_altar" then
            	        local d_opts = {"Sadly, we could only make it function on stones of condensed energy."}
			tone = "long"
		        if GameHasFlagRun("apotheosis_heretalk_cynical") then
            	            d_opts = {"It only works on stones."}
			    tone = "power"
		        end
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
        --104 When perk altar is in use
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
        --105 Killing a Corrupt Master infront of him
        trigger = function()
            local corrupt_death = EntityGetInRadiusWithTag( x, y, 175, "curse" ) or {}
            for cd=1,#corrupt_death do
                if EntityGetName(corrupt_death[cd]) == "wizard_corrupt_death_check" then
                    local d_opts = {"You couldn't stop at me, could you?", "How humane of you...", "They’re undeserving of this.", "Have you no honor for the pained?", "Was their current punishment not enough to you?"}
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    GameRemoveFlagRun("apotheosis_heretalk_id_105")
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        --106 Don't mind me, just here to get Heretic to talk about his dying servants again
        trigger = function()
            local corrupt_death = EntityGetInRadiusWithTag( x, y, 175, "curse" ) or {}
            for cd=1,#corrupt_death do
                if EntityGetName(corrupt_death[cd]) == "wizard_corrupt_death_check" then
                    local d_opts = {"You couldn't stop at me, could you?", "How humane of you...", "They’re undeserving of this.", "Have you no honor for the pained?", "Was their current punishment not enough to you?"}
                    local dialogue = d_opts[math.random(1,#d_opts)]
                    GameRemoveFlagRun("apotheosis_heretalk_id_105")
                    return true, dialogue
                end
	    end
            return false
        end
    },
    {
        --107 Thrown out at Planes
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if currbiome == "$biome_plane_yggdrasil" or currbiome == "$biome_plane_magic" or currbiome == "$biome_plane_technology" and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true then
            	local d_opts = {"Hm? What is it?"}
            	local dialogue = d_opts[math.random(1,#d_opts)]
            	return true, dialogue
            else
                return false
            end
        end
    },
    {
        --108 Thrown out at Planes 2
	--Lil unsure on these two
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if currbiome == "$biome_plane_yggdrasil" or currbiome == "$biome_plane_magic" or currbiome == "$biome_plane_technology" and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true then
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
        --109 Thrown out at Wizard Den
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
        --110 Revealing an Ethereal or Musical entity
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
        --111 New Game After Heretic Ending
        trigger = function()
            if GameHasFlagRun("apotheosis_heretalk_id_5") and HasFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_03") then
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
        --112 Bored thrown 1 [20 seconds]
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_5") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
		local timer = 0
                local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
		timer = ComponentGetValue2( timercomp, "value_float")
		if (timer >= 1200) then
            	    local d_opts = {"Are we going to get somewhere?"}
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
        --113 Bored thrown 2 [1 minute]
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_5") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
		local timer = 0
                local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
		timer = ComponentGetValue2( timercomp, "value_float")
		if (timer >= 3600) then
            	    local d_opts = {"So how long do you plan on keeping me here?"}
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
        --114 Picked up during their limit
        trigger = function()
            local heretic_unstashed = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsBodyComponent" )
            if GameHasFlagRun("apotheosis_heretalk_id_115") and ComponentGetIsEnabled(heretic_unstashed) == false then
                local d_opts = {"Thank you."}
                local dialogue = d_opts[math.random(1,#d_opts)]
		tone = "gossip"
		--locks you out of the other limit dialogue if you picked up prematurely, muahahahaha
		GameAddFlagRun("apotheosis_heretalk_id_115")
		GameAddFlagRun("apotheosis_heretalk_id_116")
		GameAddFlagRun("apotheosis_heretalk_id_117")
		GameAddFlagRun("apotheosis_heretalk_id_118")
		GameAddFlagRun("apotheosis_heretalk_id_119")
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --115 Bored thrown limit [1 hour]
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_5") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
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
        --116 Bored thrown limit 2 [1 hour]
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_5") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
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
        --117 Bored thrown limit 3 [1 hour]
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_5") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
		local timer = 0
                local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
		timer = ComponentGetValue2( timercomp, "value_float")
		if (timer >= 216000) then
            	    local d_opts = {"I would expect you to at least show some intrigue in an entity who attempts communication."}
            	    if HasFlagPersistent("apotheosis_card_unlocked_ending_apotheosis_03") then
            	        d_opts = {"Although you seem to exhibit a certain unease from my form..."}
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
        --118 Bored thrown limit 4 [1 hour]
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_5") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
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
        --119 Bored thrown limit 5 [1 hour]
        trigger = function()
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local heretic_body = EntityGetFirstComponentIncludingDisabled(entity_id,"PhysicsBodyComponent")
            if GameHasFlagRun("apotheosis_heretalk_id_5") and EntityGetParent(entity_id) == 0 and ComponentGetIsEnabled( heretic_body ) == true and #EntityGetInRadiusWithTag( x, y, 145, "player_unit" ) ~= 0 then
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
}

--Cycles through events table and runs their trigger function, will skip an entry if it's already been spoken
--Conga: No fucking way this is optimised lmao
for k=1,#events do
    if not GameHasFlagRun(table.concat({"apotheosis_heretalk_id_",k})) and events[k].trigger() == true and EntityHasTag(entity_id,"graham_speaking") == false then
        local bool, dialogue = events[k].trigger()
        Speak(entity_id, dialogue)
	if (tone == "norm") then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/heretical_eye/speech_norm", x, y );
	elseif (tone == "power") then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/heretical_eye/speech_power", x, y );
	elseif (tone == "gossip") then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/heretical_eye/speech_gossip", x, y );
	elseif (tone == "quiet") then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/heretical_eye/speech_quiet", x, y );
	elseif (tone == "yell") then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/heretical_eye/speech_yell", x, y );
	elseif (tone == "long") then
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/heretical_eye/speech_long", x, y );
	else
            GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/heretical_eye/speech_norm", x, y );
	end
        print("what's heretic thinking about: " .. tostring(k))
        GameAddFlagRun(table.concat({"apotheosis_heretalk_id_",k}))
        break
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