
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)

local sampo = EntityGetWithTag("this_is_sampo") or {}
if #sampo < 1 and GlobalsGetValue( "FINAL_BOSS_ACTIVE", "0" ) == "0" then
    EntityLoad("data/entities/animals/boss_centipede/sampo.xml",x,y+80)
end
