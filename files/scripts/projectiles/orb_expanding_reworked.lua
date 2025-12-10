
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local proj_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"ProjectileComponent")
local vsc_data = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent") or {}
local vsc_comp = 0
for k=1,#vsc_data do
    if ComponentGetValue2(vsc_data[k],"name") == "base_damage" then
        vsc_comp = vsc_data[k]
        break
    end
end

local dmg_state = ComponentGetValue2(vsc_comp,"value_int")

function mult_damage(mult)
    local dmg = ComponentGetValue2(proj_comp,"damage")
    ComponentSetValue2(proj_comp,"damage",dmg * mult)

    local damagetypes = {
        "melee",
        "explosion",
        "electricity",
        "slice",
        "ice",
        "curse",
        "drill",
        "fire",
        "radioactive",
        "healing",
        "holy",
    }

    for k=1,#damagetypes do
        local v = damagetypes[k]
        local dmg = (ComponentObjectGetValue2( projcomp, "damage_by_type", v ) or 0)
        ComponentObjectSetValue2( projcomp, "damage_by_type", v, dmg * mult )
    end
end

function run_update()
    if dmg_state < 2 then
        if dmg_state == 1 then
            mult_damage(0.1)
        end
        ComponentSetValue2(vsc_comp,"value_int",dmg_state + 1)
        return
    end
    mult_damage(1.0265)
end

run_update()