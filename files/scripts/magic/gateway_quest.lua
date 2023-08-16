
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
elseif #EntityGetInRadiusWithTag(pos_x, pos_y, 512, "this_is_sampo") > 0 then
    local targets = EntityGetInRadius(pos_x, pos_y, 36)
    for k=1,#targets
    do local v = targets[k]
        if EntityGetName(v) == "knowledge_of_kings_fx" then
            EntityKill(v)
            Activate(entity_id)
            GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/bullet_lightning/create", pos_x, pos_y )
            GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/angered_the_gods/create", pos_x, pos_y )
            GameTriggerMusicEvent( "music/oneshot/dark_03", true, pos_x, pos_y )

            --Disables this script from triggering again
            --Note: Replace this with a script that makes it so pressing E on the portal teleports you to another plane of existence
            --Only enable said script after a second or so, to make sure the player doesn't butter fingers E and accidentally enter
            local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"LuaComponent")
            EntitySetComponentIsEnabled(entity_id,comp,false)

            --Enable Press E to enter interaction
            --Note: Only enable this when the Planes are finished, or if you're testing
            --EntitySetComponentsWithTagEnabled(entity_id,"lurker_data",true)
            break
        end
    end
end

--[[
]]--

