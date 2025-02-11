--[[
--if the player leaves the stone behind, then spawn a couple corrupt masters and pretend Heretic has it now
local entity_id = GetUpdatedEntityID()
local parent = EntityGetParent(entity_id)
if parent == 0 then

    EntitySetComponentsWithTagEnabled( entity_id, "enabled_by_liquid", true)

    local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
    ComponentSetValue2( timercomp, "value_float", 0)
    ComponentSetValue2( timercomp, "value_int", 0)

    local comp_id = GetUpdatedComponentID()
    EntitySetComponentIsEnabled(entity_id,comp_id,false)
end
]]--
--Well this script no longer serves that functionality seeing as it's already basically done on it's own...
--instead it's here for checking for cheaters and warning them of the horrors of potential bugs accordingly!

if not ModIsEnabled("raksa") then
    local entity_id = GetUpdatedEntityID()

    local pos_x, pos_y = EntityGetTransform(entity_id)
    if not GameHasFlagRun("apotheosis_flesh_boss_stone_cheated") then
	GameAddFlagRun("apotheosis_flesh_boss_stone_cheated")
	GamePrintImportant( "$log_apotheosis_stone_heretic_cheater_warning_name", "$log_apotheosis_stone_heretic_cheater_warning_desc" )
	EntityLoad( "mods/Apotheosis/files/entities/particles/cheater_warning.xml", pos_x, pos_y )
	GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/angered_the_gods/create", pos_x, pos_y )
	GameScreenshake( 150 )
    end
    EntityLoad( "mods/Apotheosis/files/entities/items/books/book_stone_heretic_cheater_warning.xml", pos_x, pos_y )

    EntityKill(entity_id)
else
    EntityLoad( "mods/Apotheosis/files/entities/items/pickups/stone_heretic.xml", pos_x, pos_y )
    EntityKill(entity_id)
end