function damage_about_to_be_received(damage, x, y, entity_thats_responsible, critical_hit_chance)
    local entity_id = GetUpdatedEntityID() 
    local damage_model_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "DamageModelComponent")
    local hp = ComponentGetValue2(damage_model_comp, "hp")
    if hp - damage > 0 then
      return damage, critical_hit_chance
    end
  
    -- Somehow check if entity_thats_responsible is the entity that should do the turning, for instance by name:
    if EntityGetName(entity_thats_responsible) == "$enemy_apotheosis_fairy" or EntityGetName(entity_thats_responsible) == "$enemy_apotheosis_fairy_big" or EntityGetName(entity_thats_responsible) == "$enemy_apotheosis_fairy_giant" then
      local entity_id = GetUpdatedEntityID()
      local damage_model_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "DamageModelComponent")
      ComponentSetValue2(damage_model_comp, "create_ragdoll", false)
      EntityRemoveComponent(entity_id, ragdoll_comp)
      local x, y = EntityGetTransform(entity_id)
      local fairy_version
      for i, comp in ipairs(EntityGetComponentIncludingDisabled(entity_id, "VariableStorageComponent") or {}) do
        if ComponentGetValue2(comp, "name") == "fairy_version" then
          fairy_version = ComponentGetValue2(comp, "value_string")
        end
      end
      if not fairy_version then
        error("No VariableStorageComponent with name='fairy_version' found")
      end
      EntityLoad(fairy_version, x, y)
    end
    return damage, critical_hit_chance
  end