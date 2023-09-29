
local path = "apotheosis_teleporter_secret_"
local flag_01 = GameHasFlagRun(path .. "mines")
local flag_02 = GameHasFlagRun(path .. "coalmine")
local flag_03 = GameHasFlagRun(path .. "snowydepths")
local flag_04 = GameHasFlagRun(path .. "hiisibase")
local flag_05 = GameHasFlagRun(path .. "jungle")
local flag_06 = GameHasFlagRun(path .. "vault")
local flag_fail = GameHasFlagRun(path .. "failed")

if flag_01 and flag_02 and flag_03 and flag_04 and flag_05 and flag_06 then
    if flag_fail ~= true then
        local entity_id = GetUpdatedEntityID()
        local pos_x, pos_y = EntityGetTransform(entity_id)
        EntityLoad("mods/apotheosis/files/entities/buildings/teleport_ending_alt_created.xml", pos_x, pos_y)
		AddFlagPersistent( "apotheosis_card_unlocked_omega_cross" )
		AddFlagPersistent( "apotheosis_card_unlocked_omega_cross_spell" )
        EntityKill(entity_id)
    end
end