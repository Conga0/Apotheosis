-- Thank you Horscht for this nice script :) -S
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local texts = {
  "Alchemist...",
  "Yield.",
  "Give back what is mine."
}
local translation_texts = {
  "$log_apotheosis_mind_warp_norm_1",
  "$log_apotheosis_mind_warp_norm_2",
  "$log_apotheosis_mind_warp_norm_3"
}
local current_text = 1
local space_width = 20
local letter_delay = 5
local initial_delay = 180
local sentence_hold_time = 100
local pause_between_sentences = 60 -- in frames
local wiggle_speed = 0.04
local wiggle_strength = 3
local fade_in_speed = 0.05
local fade_out_speed = 0.015
local sound = "mind"
local frame_to_play_sound_at = 0

if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster_stone") then
  texts = {
    "Leave.",
    "You are not welcome here.",
    "Leave me to my work."
  }
  translation_texts = {
    "$log_apotheosis_mind_warp_stone_1",
    "$log_apotheosis_mind_warp_stone_2",
    "$log_apotheosis_mind_warp_stone_3"
  }
elseif GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") then
  texts = {
    "Fool!",
    "Imprudent imbecile!",
    "There's ramifications...",
    "To your mindless actions!"
  }
  translation_texts = {
    "$log_apotheosis_mind_warp_enrage_1",
    "$log_apotheosis_mind_warp_enrage_2",
    "$log_apotheosis_mind_warp_enrage_3",
    "$log_apotheosis_mind_warp_enrage_4"
  }
  pause_between_sentences = 30
  wiggle_speed = 0.08
  wiggle_strength = 4
  sound = "mind"
end

local function get_img(ch)
  local t = {
    ["!"] = "mods/Apotheosis/files/fonts/flesh_big/exclamation.png",
    ["'"] = "mods/Apotheosis/files/fonts/flesh_big/apostrophe.png",
    ["."] = "mods/Apotheosis/files/fonts/flesh_big/period.png",
  }
  return t[ch] or ("mods/Apotheosis/files/fonts/flesh_big/letter_%s.png"):format(ch)
end

-- Thank you ChatGPT for this perlin noise function that I don't understand at all :)
local p = {}
for i = 0, 255 do
    p[i] = i
end
for i = 0, 255 do
    local j = math.random(0, 255)
    p[i], p[j] = p[j], p[i]
end
for i = 0, 255 do
    p[256 + i] = p[i]
end

local function lerp(t, a, b)
  return a + t * (b - a)
end

local function fade(t)
  return t * t * t * (t * (t * 6 - 15) + 10)
end

local function grad(hash, x, y)
  local h = hash % 16
  local u = h < 8 and x or y
  local v = h < 4 and y or ((h == 12 or h == 14) and x or 0)
  return (h % 2 == 0 and u or -u) + (h % 4 == 0 and v or -v)
end

local function perlin_noise(x, y)
  local X = math.floor(x) % 256
  local Y = math.floor(y) % 256
  x = x - math.floor(x)
  y = y - math.floor(y)
  local u = fade(x)
  local v = fade(y)
  local A = p[X] + Y
  local B = p[X + 1] + Y
  return lerp(v, lerp(u, grad(p[A], x, y), grad(p[B], x - 1, y)), lerp(u, grad(p[A + 1], x, y - 1), grad(p[B + 1], x - 1, y - 1)))
end

local function destroy_gui()
  if gui then
    GuiDestroy(gui)
    gui = nil
  end
end

if not GetValueBool("initialised", false) then
  -- execute_on_added
  SetValueBool("initialised", true)
  frame_to_play_sound_at = GameGetFrameNum() + initial_delay
else
  -- execute_on_removed
  destroy_gui()
end

local FADE_IN, HOLD, FADE_OUT, DONE = 1, 2, 3, 4
local function create_letter(ch, x, y, t)
  local img = get_img(ch)
  local alpha = 0
  local phase = math.random() * 100
  local alpha_state = FADE_IN
  return {
    update = function()
      -- t is the delay before it starts animating, so that the letters can fade in one after the other
      -- can start negative and while it is, just increase it and do nothing
      t = t + 1
      if t < 0 then return end
      if alpha_state == FADE_IN then
        alpha = alpha + fade_in_speed
        if alpha >= 0.8 then
          alpha_state = HOLD
        end
      elseif alpha_state == FADE_OUT then
        alpha = alpha - fade_out_speed
        if alpha <= 0 then
          alpha_state = DONE
        end
      end
      phase = phase + wiggle_speed
    end,
    fade_out = function()
      alpha_state = FADE_OUT
    end,
    get_state = function()
      return alpha_state
    end,
    render = function(gui, new_id)
      local dx = perlin_noise(phase * 0.7, phase * 0.3) * wiggle_strength
      local dy = perlin_noise(phase * 0.3, phase * 0.7) * wiggle_strength
      GuiImage(gui, new_id(), x + dx, y + dy, img, alpha, 1, 1)
    end,
  }
end

local size_cache = {}
local current_hold_time = 0

function wake_up_waiting_threads()
  if frame_to_play_sound_at == GameGetFrameNum() then
    GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/heretical_eye/speech_" .. sound, pos_x, pos_y )
  end
  gui = gui or GuiCreate()
  GuiStartFrame(gui)
  GuiOptionsAdd(gui, 2) -- NonInteractive
  local screen_width, screen_height = GuiGetScreenDimensions(gui)

  local id = 1
  local new_id = function()
    id = id + 1
    return id
  end

  local text = texts[current_text]
  -- Calculate size once for each sentence and save it so we can center it on the screen
  if not size_cache[text] then
    local w, h = 0, 0
    for i=1, #text do
      local ch = text:sub(i, i)
      if ch ~= " " then
        local img = get_img(ch)
        local w2, h2 = GuiGetImageDimensions(gui, img)
        w = w + w2
        h = math.max(h, h2)
      else
        w = w + space_width
      end
    end
    size_cache[text] = { w = w, h = h }
  end
  local text_size = size_cache[text]
  -- Loop over all characters in the text string
  if not letters then
    letters = {}
    local offset_x = 0
    for i=1, #text do
      local ch = text:sub(i, i)
      if ch ~= " " then
        local img = get_img(ch)
        local char_w, char_h = GuiGetImageDimensions(gui, img)
        local t = -(i-1) * letter_delay
        if current_text > 1 then
          t = t - pause_between_sentences
        else
          t = t - initial_delay
        end
        table.insert(letters, create_letter(ch, (screen_width - text_size.w) / 2 + offset_x, (screen_height - text_size.h) / 2, t))
        offset_x = offset_x + char_w
      else
        offset_x = offset_x + space_width
      end
    end
  end
  local num_held = 0
  local num_done = 0
  for i, letter in ipairs(letters) do
    letter.update()
    letter.render(gui, new_id)
    if letter.get_state() == HOLD then
      num_held = num_held + 1
    elseif letter.get_state() == DONE then
      num_done = num_done + 1
    end
  end
  if num_held == #letters then
    current_hold_time = current_hold_time + 1
  end
  if current_hold_time == 1 then
    GamePrint(table.concat({GameTextGetTranslatedOrNot("$creep_apotheosis_boss_flesh_monster_name"),": ",GameTextGetTranslatedOrNot(translation_texts[current_text])}))
    print(table.concat({GameTextGetTranslatedOrNot("$creep_apotheosis_boss_flesh_monster_name"),": ",GameTextGetTranslatedOrNot(translation_texts[current_text])}))
  end
  if current_hold_time == sentence_hold_time then
    for i, letter in ipairs(letters) do
      letter.fade_out()
    end
    current_hold_time = 0
  end
  if num_done == #letters then
    if current_text < #texts then
      frame_to_play_sound_at = GameGetFrameNum() + pause_between_sentences
    end
    current_text = current_text + 1
    letters = nil
    if current_text > #texts then
      EntityKill(GetUpdatedEntityID())
    end
  end
  if GameHasFlagRun( "apotheosis_miniboss_boss_flesh_monster" ) then
    EntityKill(GetUpdatedEntityID())
  end
end
