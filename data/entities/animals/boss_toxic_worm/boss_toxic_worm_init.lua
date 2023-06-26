
local entity_id = GetUpdatedEntityID()

local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"BossDragonComponent") --Disable Dragon Component
EntitySetComponentIsEnabled(entity_id,comp,false)

local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormComponent") --Enable worm data & AI
EntitySetComponentIsEnabled(entity_id,comp,true)
local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormAIComponent") --Enable worm data & AI
EntitySetComponentIsEnabled(entity_id,comp,true)
