local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity(entity_id)

local effectTest = GameGetGameEffectCount( entity_id, "WET" )
if effectTest >= 1 then
    if EntityHasTag(entity_id,"player_unit") then
        EntityInflictDamage( entity_id, 0.030, "DAMAGE_CURSE", "$status_apotheosis_hex_water_name", "NONE", 0, 0, 0 )
    else
        EntityInflictDamage( entity_id, 0.108, "DAMAGE_CURSE", "$status_apotheosis_hex_water_name", "NONE", 0, 0, 0 )
    end
end