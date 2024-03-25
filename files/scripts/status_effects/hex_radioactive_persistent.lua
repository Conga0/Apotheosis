local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity(entity_id)

local effectTest = GameGetGameEffectCount( entity_id, "RADIOACTIVE" )
if effectTest >= 1 then
    if EntityHasTag(entity_id,"player_unit") then
        EntityInflictDamage( entity_id, 0.030, "DAMAGE_CURSE", "$status_apotheosis_hex_radioactive_name", "NONE", 0, 0, 0 )
    else
        EntityInflictDamage( entity_id, 0.108, "DAMAGE_CURSE", "$status_apotheosis_hex_radioactive_name", "NONE", 0, 0, 0 )
    end
end

--[[
--Note to copi, since I know you'll be snooping around here, This is fully functional (presumably) but I just wasn't sure if I wanted to implement it, so moved it to be commented out.
local dmg = 0.030
--Original amount was 0.030 for player, 0.108 for monsters, unscaled


local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
if comp then

    local hp = ComponentGetValue2(comp,"max_hp")
    local dmgscaled = dmg * (hp / 4)

    EntityInflictDamage( entity_id, dmgscaled, "DAMAGE_CURSE", "$status_apotheosis_hex_radioactive_name", "NONE", 0, 0, 0 )
end
]]--
