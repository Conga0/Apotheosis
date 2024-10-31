local me = GetUpdatedEntityID()
local comp = EntityGetFirstComponent(me, "VariableStorageComponent", "boss_reworks_armor")
if comp == nil then
    local health = EntityGetFirstComponent(me, "DamageModelComponent")
    if not health then return end
    EntityAddComponent2(me, "VariableStorageComponent", {
        _tags="boss_reworks_armor",
        value_float=0,
    })
    EntityAddComponent2(me, "LuaComponent", {
        script_damage_about_to_be_received="mods/apotheosis/files/scripts/animals/boss_armor_strong.lua",
        execute_every_n_frame=-1,
    })
else
    local this = GetUpdatedComponentID()
    if ComponentGetValue2(this, "mTimesExecuted") % 2 == 0 then
        ComponentSetValue2(comp, "value_float", ComponentGetValue2(comp, "value_float") * 0.9885140203529) -- decay by 50% over 60f
    end
end