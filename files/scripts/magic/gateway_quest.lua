
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

function Activate(gate_id)
    local comps = EntityGetComponentIncludingDisabled(gate_id,"SpriteComponent")
    EntitySetComponentIsEnabled(gate_id,comps[3],true)
    EntityLoad("mods/Apotheosis/files/biome_impl/magicegg/portal_open_emitter.xml", pos_x, pos_y)
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

--Debug Data
--[[
local sampo = EntityGetInRadiusWithTag(pos_x, pos_y, 512, "this_is_sampo") or {}
if #sampo > 0 and EntityGetParent(sampo[1]) ~= 0 then GamePrint("Found Sampo") end
if HasFlagPersistent("apotheosis_card_unlocked_radarfound") then GamePrint("Found Radar Park Permanent") end
if GameHasFlagRun("apotheosis_radar_perk_taken") then GamePrint("Found Radar Park") end
if GameHasFlagRun("apotheosis_everything") ==false then GamePrint("Found Everything absent") end
]]--

if tonumber(GlobalsGetValue("apotheosis_plane_fail",0)) == 1 then
    EntitySetComponentsWithTagEnabled(entity_id,"invincible",false)
    EntitySetComponentsWithTagEnabled(entity_id,"counter",true)
    GameAddFlagRun("apotheosis_heretalk_portal_fail")
    GameAddFlagRun("apotheosis_stone_obsolete")
else
    --Detect Sampo's presence & enable helper entity if it's found
    --Conga: Leave this disabled until it's time for release
    --[[
    ]]--
    local sampo = EntityGetInRadiusWithTag(pos_x, pos_y, 512, "this_is_sampo") or {}
    local radar_stones = EntityGetInRadiusWithTag(pos_x,pos_y,512,"poopstone") or {}
    local stone_id = 0
    for k=1,#radar_stones
    do local v = radar_stones[k]
	local comp = EntityGetFirstComponentIncludingDisabled(v,"PhysicsImageShapeComponent")
	if ComponentGetValue2(comp,"image_file") == "mods/Apotheosis/files/items_gfx/goldnugget_01_alt_radar.png" then
	    stone_id = v
	    break
	end
    end
    --No longer uses the persistent flag, meaning you need to get the planes radar
    --If you don't have the planes perk then if you have the stone then you'll be able to be let through
    --However if it's the everything seed then you'll be denied and have to get the perk, shouldn't matter though since Heretic gives the perk I believe
    if #sampo > 0 and EntityGetParent(sampo[1]) ~= 0 and (GameHasFlagRun("apotheosis_radar_perk_taken") == true or (stone_id > 0 and EntityGetParent(stone_id) ~= 0 and GameHasFlagRun("apotheosis_everything") == false)) then
        --Enable press e to sampo?
        local helper = EntityGetWithTag("apotheosis_portal_helper")[1]
        EntitySetComponentsWithTagEnabled(helper,"lurker_data",true)
	-- v This is so heretic doesn't yell through the planes each time the guiding stone is atomized and reconstructed when traveling through dimensions
	GameAddFlagRun("apotheosis_planes_portal_completed")
    else
        local helper = EntityGetWithTag("apotheosis_portal_helper")[1]
        EntitySetComponentsWithTagEnabled(helper,"lurker_data",false)
    end
end

--[[
]]--

