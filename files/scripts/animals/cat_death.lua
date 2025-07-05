function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
    if EntityHasTag(entity_thats_responsible, "player_unit") then
        ModSettingSet("Apotheosis.cat_kills", (ModSettingGet("Apotheosis.cat_kills") or 0) + 1)
    end
    ModSettingSet("Apotheosis.cat_deaths", (ModSettingGet("Apotheosis.cat_deaths") or 0) + 1)
end