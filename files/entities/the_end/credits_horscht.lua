dofile_once("data/scripts/lib/utilities.lua")

local lines = {
  " ",
  "$credits_apotheosis_line_01",
  " ",
  "Conga Lyne",
  "$credits_apotheosis_line_04",
  " ",
  "HinoGuchi Sorako",
  "$credits_apotheosis_line_07",
  " ",
  "Spoopy",
  "$credits_apotheosis_line_10",
  "$credits_apotheosis_line_11",
  " ",
  "Squirrelly",
  "$credits_apotheosis_line_14",
  " ",
  "Blueberry",
  "$credits_apotheosis_line_17",
  " ",
  "Horscht",
  "$credits_apotheosis_line_horscht",
  " ",
  "Copi",
  "$credits_apotheosis_line_20",
  " ",
  "$credits_apotheosis_line_22",
  "Freakstritch",
  "Moriko Yumi",
  "Voksivs",
  "Tanksy Plays",
  "Clemfandongo",
  "Aliasbot",
  "DunkOrSlam's Community",
  "DunkOrSlam",
  "FuryForged",
  "Ismoh",
  "Graham",
  "DayleonFefe",
  "Pneumoania",
  "Elleedy",
  "Zolkarn",
  "Vexilus_",
  "Xytio",
  "$credits_apotheosis_line_39",
  " ",
  " ",
  " ",
  "$credits_apotheosis_line_43",
  "$credits_apotheosis_line_44",
  "$credits_apotheosis_line_45",
  " ",
  " ",
  " ",
}

local entity_id = GetUpdatedEntityID()
local player = EntityGetWithTag("player_unit")[1]

gui = gui or GuiCreate()
GuiStartFrame(gui)
roll_credits_progress = (roll_credits_progress or -1) - 0.295 * (accelerate and 15 or 1)

if not do_once and roll_credits_progress <= 0 then
  do_once = true
  local player = EntityGetWithTag("player_unit")[1]
  if player then
    GameTriggerMusicFadeOutAndDequeueAll()
    GamePlaySound( "data/audio/Desktop/music.bank", "music/credits/02", pos_x, pos_y );
  end
end


--Noooo I don't want the Noita to die in these credits!
if roll_credits_progress < -3800 then
    EntityKill(GetUpdatedEntityID())
end

GuiLayoutBeginVertical(gui, 50, 100)
GuiOptionsAddForNextWidget(gui, GUI_OPTION.Align_HorizontalCenter)
GuiImage(gui, 2, 0, roll_credits_progress, "mods/Apotheosis/files/entities/the_end/credits_title_new.png", 1, 1, 1)
for i, line in ipairs(lines) do
  -- Draw black shadow first
  GuiOptionsAddForNextWidget(gui, GUI_OPTION.Align_HorizontalCenter)
  GuiColorSetForNextWidget(gui, 0, 0, 0, 1)
  GuiText(gui, 0, 0, line)
  -- Now the actual text at the same position minus one y
  local clicked, right_clicked, hovered, x, y, width, height, draw_x, draw_y, draw_width, draw_height = GuiGetPreviousWidgetInfo(gui)
  GuiOptionsAddForNextWidget(gui, GUI_OPTION.Layout_NoLayouting)
  GuiText(gui, x, y-1, line)
end
GuiLayoutEnd(gui)