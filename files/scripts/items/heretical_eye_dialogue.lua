dofile_once("data/scripts/lib/utilities.lua") --Tired Sinning
--Hello yes thank you Graham for letting me "borrow" this :) - Spoop

if #EntityGetWithTag("player_unit") < 1 then 
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
    local size_x = 0.8
    local size_y = 0.8

    local offset_y = 26
    local alpha = 0.8

    ---- All dialogue handling should go above this point ----

    -- here lies some terrible width code that has since been replaced
    -- thank you to Evaisa (and Copi) for making this not trash
    local gui = GuiCreate()
    GuiStartFrame(gui)
    local offset_x = GuiGetTextDimensions( gui, text, size_x ) * 0.75
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
        execute_every_n_frame = 120 + (#text * 10), --Starting at 2 seconds, every letter adds 10 frames to the dialogue duration.
        script_source_file="mods/apotheosis/files/scripts/items/heretical_eye_dialogue_quiet.lua"
    })
end

--List of one-time dialogue events
local events = {
    {
        --Initial dialogue after being slain
        trigger = function()
            local d_opts = {"Screw You","Now what?","...","Paskiainen"}
            local dialogue = d_opts[math.random(1,#d_opts)]
            return true, dialogue
        end
    },
    {
        --Being shown the surface
        trigger = function()
            local entity_id = GetUpdatedEntityID()
            local pos_x, pos_y = EntityGetTransform(entity_id)
            local worldEntity = GameGetWorldStateEntity()
            local comp = EntityGetFirstComponentIncludingDisabled(worldEntity,"WorldStateComponent")
            local time = ComponentGetValue2(comp,"time")
            if pos_y < 0 and (time < 0.30 or time > 0.80) then
                local d_opts = {"What is that strange light?","It's so bright","It's blinding up here. Take me back."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --Being taken outside of the Temple of Sacrligious Remains
        trigger = function()
            local entity_id = GetUpdatedEntityID()
            local pos_x, pos_y = EntityGetTransform(entity_id)
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome ~= "$biome_evil_temple" and currbiome ~= "???" then
                local d_opts = {"Don't humiliate me like this. Take me home.","HEY! Where are you taking me?","I'm not even allowed to rest in my own home.","HEY! I'M BEING KIDNAPPED! HELP ME!","You're a sicko, you know that?","This place is filthy."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --Being brought to the perk creation altar
        trigger = function()
            local altar = EntityGetWithName( "apotheosis_perk_creation_altar" )
            local a_x, a_y = EntityGetTransform(altar)
            if get_distance(x,y,a_x,a_y) < 300 then
                local d_opts = {"My pride and joy"}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --Being taken into the Wizard's Den
        trigger = function()
            local entity_id = GetUpdatedEntityID()
            local pos_x, pos_y = EntityGetTransform(entity_id)
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_wizardcave" then
                local d_opts = {"Not this place...","I remember this place.. The host was a real sucker for the gods, not nearly as much as I was though.","Hey, if you see an abnormally large wizard, do to him what you did to me, will you?","Hey, mind pouring some blood from my home onto these should've-been rejects? They'll get the message."}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --Being taken into the Throne Room
        trigger = function()
            local entity_id = GetUpdatedEntityID()
            local pos_x, pos_y = EntityGetTransform(entity_id)
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            local dialogue = "Not this guy.."
            if currbiome == "$biome_mestari_secret" then
                if EntityGetWithName( "$animal_boss_wizard" ) ~= 0 then
                    return true, dialogue
                elseif GameHasFlagRun("apotheosis_mom_dead") then
                    dialogue = "This place.. I don't sense his presence.. Did you already kill that bastard?"
                    return true, dialogue
                else
                    dialogue = "This place.. Where'd he run off to?"
                    return true, dialogue
                end
            else
                return false
            end
        end
    },
    {
        --Being taken into the Plane of Yggdrasil
        trigger = function()
            local entity_id = GetUpdatedEntityID()
            local pos_x, pos_y = EntityGetTransform(entity_id)
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "biome_plane_yggdrasil" then
                local d_opts = {"This isn't what I expected","This is the last place I thought you'd take me","What the hell?"}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
            else
                return false
            end
        end
    },
    {
        --Being taken into the Empyrean
        trigger = function()
            local entity_id = GetUpdatedEntityID()
            local pos_x, pos_y = EntityGetTransform(entity_id)
            local currbiome = BiomeMapGetName( x, y )
            currbiome = tostring(currbiome)
            if currbiome == "$biome_empyrean" then
                local d_opts = {"Is this...?","Finally...","...","I feel sorry"}
                local dialogue = d_opts[math.random(1,#d_opts)]
                return true, dialogue
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