if GameHasFlagRun( "apotheosis_miniboss_boss_flesh_monster_stone" ) then
    local comp_id = GetUpdatedComponentID()
    EntityRemoveComponent(entity_id,comp_id)
end

if GameHasFlagRun("apotheosis_flesh_boss_stone_destroyed") or GameHasFlagRun("apotheosis_flesh_boss_stone_converted") then
    GameAddFlagRun( "apotheosis_miniboss_boss_flesh_monster_removed" )
end