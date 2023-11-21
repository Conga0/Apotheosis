
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

function Activate(gate_id)
    local comps = EntityGetComponentIncludingDisabled(gate_id,"SpriteComponent")
    EntitySetComponentIsEnabled(gate_id,comps[3],true)
    EntityLoad("mods/apotheosis/files/biome_impl/magicegg/portal_open_emitter.xml", pos_x, pos_y)
end

-- Conga: 
-- What if this was openned with the knowledge of kings instead?
-- I would like to have the requirements for this quest tie into everything else you've done in some way or another, make it feel like a nice conclusionary quest to all you've done in Apotheosis
-- Currently makes use of:
-- Heretic Boss
-- Fire Lukki/Knowledge of Kings quest
-- 
-- 
-- Note: Update orb room hints after finalizing this, moreso make sure they still accurately reflect the steps needed to open the portal
-- Same goes for "A message from beyond" hinting to what you need to properly ascend
--
-- Maybe you could use mass materia conversion of the Knowledge of Kings to turn it into something to open the portal? The Knowledge of Gods? /shrug
-- Special song needs to be played you learn from visiting an apotheosis biome?

if tonumber(GlobalsGetValue("apotheosis_plane_fail",0)) == 1 then
    EntitySetComponentsWithTagEnabled(entity_id,"invincible",false)
    EntitySetComponentsWithTagEnabled(entity_id,"counter",true)
    GameAddFlagRun("apotheosis_heretalk_portal_fail")
else
    --Detect Sampo's presence & enable helper entity if it's found
    --Conga: Leave this disabled until it's time for release
    --[[
    ]]--
    local sampo = EntityGetInRadiusWithTag(pos_x, pos_y, 512, "this_is_sampo") or {}
    if #sampo > 0 and EntityGetParent(sampo[1]) ~= 0 and HasFlagPersistent("apotheosis_card_unlocked_radarfound") then
        --Enable press e to sampo?
        local helper = EntityGetWithTag("apotheosis_portal_helper")[1]
        EntitySetComponentsWithTagEnabled(helper,"lurker_data",true)
    else
        local helper = EntityGetWithTag("apotheosis_portal_helper")[1]
        EntitySetComponentsWithTagEnabled(helper,"lurker_data",false)
    end
end

--[[
]]--

