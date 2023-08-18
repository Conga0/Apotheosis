--Hello yes thank you Graham for letting me "borrow" this :) - Spoop

if #EntityGetWithTag("player_unit") < 1 then 
    print("no playor?") 
return end -- don't speak when there's no player
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
SetRandomSeed(x + GameGetFrameNum(), y + 1394)
-- how talkative Mr. Heretical is
local rate = 10

if rate < 1 then return end
if Random(1, rate) == 1 then

    print("dialogue should happen now?")

    local worldstatecomp = EntityGetFirstComponent(GameGetWorldStateEntity(), "WorldStateComponent") or 0
    local random = Random(1, 10)

-- part of the old system, you're probably better off replacing this with some new system so it's more intuitive for what we're doing
DIALOGUE_IDLE = {
    {"Heretic", "Greetings mortal!", "What is it that you seek?", "Bleh bleh!", "ABCDEFGHIJKLMNOPQRSTUVWXYZ"},
}

function Speak(entity, text, pool)

    print("did we get this far?")

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
        _tags = "enabled_in_world, graham_speech_text",
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
        _tags= "graham_speech_quiet",
        execute_every_n_frame = 180,
        script_source_file="mods/apotheosis/files/scripts/items/heretical_eye_dialogue_quiet.lua"
    })
end

-- also part of old system, I was just too lazy to redo it, sorry!
    local name = "Heretic"
    for i = 1, #DIALOGUE_IDLE do
        if DIALOGUE_IDLE[i][1] == name then
            local type = Random(2, #DIALOGUE_IDLE[i])
            Speak(entity_id, tostring(DIALOGUE_IDLE[i][type]), "IDLE")
            break
        end
    end
end