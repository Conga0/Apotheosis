dofile_once("data/scripts/lib/utilities.lua")

local lines = {
  "",
  "$credits_apotheosis_line_01",
  " ",
  "Conga Lyne",
  "$credits_apotheosis_line_04",
  " ",
  "Spoopy",
  "$credits_apotheosis_line_spoop",
  " ",
  "Copi",
  "$credits_apotheosis_line_20_new",
  " ",
  "PickledSosig",
  "$credits_apotheosis_line_sosig",
  " ",
  "HinoGuchi Sorako",
  "$credits_apotheosis_line_07",
  " ",
  "Slack",
  "$credits_apotheosis_line_slack",
  " ",
  "Alex(GoD)",
  "Blueberry",
  "$credits_apotheosis_line_17",
  " ",
  "Shug",
  "Kitten",
  "$credits_apotheosis_line_ch_trans",
  " ",
  "$credits_apotheosis_line_extrahelp",
  "Nathan",
  "Letaali",
  "Squirrelly",
  "YTea",
  "Evasia",
  "Zathers",
  "Extol",
  "Ribs",
  "Horscht",
  "InfiniteSunrise",
  " ",
  "$credits_apotheosis_line_22",
  "NollaGames",
  "Freakstritch",
  "Moriko Yumi",
  "TeoUltika",
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
  "42oblaze_it",
  "Albino",
  "DarkViperAU",
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
  " ",
  "Secret Codes:",
  "hardcore",
  "towerclimb",
  "missingmagic",
  "alchemistdream",
  "addict",
  "poverty",
  "downunder",
  "nightcore",
  "getfixedboi",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  --"Seeker of Knowledge",
  --"Some Secrets are yet to be revealed",
  --"Stake your eyes on these glyphs, for in time, it too shall change",
  " ",
  " ",
  " ",
}


--[[
  ]]--
--This acclerates the credits sequence when the player holds down spacebar or the A button on controller
local accelerate = InputIsKeyDown( 44 ) or InputIsJoystickButtonDown(0, 23)


local entity_id = GetUpdatedEntityID()
local player = EntityGetWithTag("player_unit")[1]

gui = gui or GuiCreate()
GuiStartFrame(gui)
roll_credits_progress = (roll_credits_progress or -1) - 0.375 * (accelerate and 15 or 1)


--Trigger the true run victory & vanilla noita credits
if roll_credits_progress < -1000 then --If anything breaks in the future, this was originally -850 (Conga Lyne 22/01/2024)
    --EntityKill(GetUpdatedEntityID())

    --Probably handle diff effects by scanning for a game flag to detect which ending is currently ongoing
    if GameHasFlagRun("apotheosis_ending_sheep") then
      local sheep_plyr = EntityGetWithTag("polymorphed_player")[1]
      local plyr_x, plyr_y = EntityGetTransform(sheep_plyr)
      EntityLoad("data/entities/animals/sheep.xml", plyr_x, plyr_y)
      EntityKill(sheep_plyr)
    else
      local player_id = EntityGetWithTag("player_unit")[1]
      --[[
      if GameHasFlagRun("apotheosis_ending_heretic") then
        local plyr_x, plyr_y = EntityGetTransform(player_id)
        LoadRagdoll( "data/ragdolls/player/filenames.txt", plyr_x, plyr_y, "meat", 1, 0, 0 )
      end
      ]]--
      EntityKill(player_id)
    end
    GameOnCompleted()
    GameAddFlagRun("ending_game_completed")
end

--Kill the Apotheosis credits entity
if roll_credits_progress < -1500 then
  --Cleanup
  EntityKill(GetUpdatedEntityID())
end

--Debug Data
--GamePrint("roll_credits_progress is " .. roll_credits_progress)

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
