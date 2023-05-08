
function shot()
    --Disables Thief's ability to throw teleportatium to escape after his initial throw
    local entity_id = GetUpdatedEntityID()

    local animalcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent")
    ComponentSetValue2(animalcomp,"attack_ranged_entity_file","")
    ComponentSetValue2(animalcomp,"attack_ranged_max_distance",0)
    ComponentSetValue2(animalcomp,"attack_ranged_enabled",false)
end