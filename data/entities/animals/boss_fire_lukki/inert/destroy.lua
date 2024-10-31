
local entity_id = GetUpdatedEntityID()
if GameHasFlagRun("apotheosis_fire_lukki_boss_summoned") then
    local children = EntityGetAllChildren(entity_id)
    for k=1,#children do
        EntityKill(children[k])
    end
    EntityKill(entity_id)
end