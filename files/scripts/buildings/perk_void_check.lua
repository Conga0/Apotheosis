dofile_once("data/scripts/perks/perk.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local void_count = tonumber(GlobalsGetValue( "APOTHEOSIS_VOID_COUNT", "0" ))

local perks = EntityGetInRadiusWithTag(pos_x, pos_y, 300, "item_perk" )
for k=1,#perks
do local v = perks[k]
    local x, y = EntityGetTransform(v)
    SetRandomSeed(x, y)
    if Random(1,void_count + 2) >= 3 and (void_count >= 1) then
        perk_spawn( x, y, "APOTHEOSIS_VOID" )
        EntityKill(v)
    elseif Random(1,300) == 1 and GameHasFlagRun("apotheosis_perk_mimic_reveal") == false then
    --elseif Random(1,400) == 1 then
        EntityLoad("data/entities/animals/mimic_perk_twwe.xml", x, y)
        EntityKill(v)
        --GamePrint("Spawning Perk Mimic")
    end
end

EntityKill(entity_id)
