
local entity_id = GetUpdatedEntityID()
local player_id = EntityGetParent(entity_id)
local pos_x, pos_y = EntityGetTransform(player_id)

--Check if the player has a plasma shield of any kind, if so, disable it
local shieldren = EntityGetAllChildren(player_id)
for k=1,#shieldren do
    local v = shieldren[k]
    if EntityHasTag(v,"energy_shield") then
        local comp = EntityGetFirstComponentIncludingDisabled(v,"EnergyShieldComponent")
        ComponentSetValue2(comp,"energy",0)
    end
end
