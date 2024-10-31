
local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local comp = EntityGetFirstComponent(entity_id,"VariableStorageComponent")
local spellid = ComponentGetValue2(comp,"value_string")
local spellcheck = EntityGetInRadiusWithTag(pos_x,pos_y,32,"card_action") or {}

if #spellcheck < 1 then
    CreateItemActionEntity( spellid, pos_x, pos_y - 4 )
end

EntityKill(entity_id)
