
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local plyr = EntityGetWithTag("player_unit") or {}
for k=1,#plyr do
    local wallet = EntityGetFirstComponentIncludingDisabled(plyr[k],"WalletComponent")
    local money = ComponentGetValue2(wallet,"money")
    if money > 1000000 then
        EntityLoad("mods/Apotheosis/files/entities/items/pickups/perk_no_gold.xml",pos_x,pos_y)
        EntityLoad("mods/Apotheosis/files/entities/buildings/divine_knowledge_particles.xml",pos_x,pos_y)
        EntityKill(entity_id)
    end
end