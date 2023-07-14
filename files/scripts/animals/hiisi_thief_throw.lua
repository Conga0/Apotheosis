
function shot()
    --Disables Thief's ability to throw teleportatium to escape after his initial throw
    --Can fight back but won't steal gold after the 1st hit
    local entity_id = GetUpdatedEntityID()

    local animalcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent")
    ComponentSetValue2(animalcomp,"attack_ranged_entity_file","mods/apotheosis/files/entities/projectiles/melee/thief_attack_nolua.xml")
    ComponentSetValue2(animalcomp,"attack_ranged_max_distance",16)
    ComponentSetValue2(animalcomp,"attack_ranged_enabled",true)
    ComponentSetValue2(animalcomp,"attack_if_damaged_probability",50)
    ComponentSetValue2(animalcomp,"escape_if_damaged_probability",50)

    local luacomp = EntityGetFirstComponentIncludingDisabled(entity_id,"LuaComponent")
    ComponentSetValue2(luacomp,"script_material_area_checker_success","")
end