dofile_once("data/scripts/perks/perk.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local void_count = tonumber(GlobalsGetValue( "APOTHEOSIS_VOID_COUNT", "0" ))
if void_count <= 0 then return end

local perks = EntityGetInRadiusWithTag(pos_x, pos_y, 300, "item_perk" )
for k=1,#perks
do local v = perks[k]
    local x, y = EntityGetTransform(v)
    SetRandomSeed(x, y)
    if Random(1,void_count + 2) >= 3 then
        perk_spawn( x, y, "APOTHEOSIS_VOID" )
        EntityKill(v)
    end
end

EntityKill(entity_id)