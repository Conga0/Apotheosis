local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity(entity_id)

--If water protection is detected, immediately remove self
local water_immune = false

local children = EntityGetAllChildren(entity_id)
if children then
    for k=1,#children
    do v = children[k]
        if EntityGetName(v) == "apotheosis_protection_water" then
            local effect_id = GetUpdatedEntityID()
            water_immune = true
        end
    end
end

local effectTest = GameGetGameEffectCount( entity_id, "WET" )
if effectTest >= 1 and water_immune == false then
    if EntityHasTag(entity_id,"player_unit") then
        EntityInflictDamage( entity_id, 0.030, "DAMAGE_CURSE", "$status_apotheosis_hex_water_name", "NONE", 0, 0, 0 )
    else
        EntityInflictDamage( entity_id, 0.108, "DAMAGE_CURSE", "$status_apotheosis_hex_water_name", "NONE", 0, 0, 0 )
    end
end

--[[
--Note to copi, since I know you'll be snooping around here, This is fully functional (presumably) but I just wasn't sure if I wanted to implement it, so moved it to be commented out.
--I think it could work :D -Spoop
local dmg = 0.030
--Original amount was 0.030 for player, 0.108 for monsters, unscaled


local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"DamageModelComponent")
if comp then

    local hp = ComponentGetValue2(comp,"max_hp")
    local dmgscaled = dmg * (hp / 4)

    EntityInflictDamage( entity_id, dmgscaled, "DAMAGE_CURSE", "$status_apotheosis_hex_water_name", "NONE", 0, 0, 0 )
end
]]--
