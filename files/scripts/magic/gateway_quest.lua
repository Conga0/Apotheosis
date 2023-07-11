
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

function Activate(gate_id)
    local comps = EntityGetComponentIncludingDisabled(gate_id,"SpriteComponent")
    EntitySetComponentIsEnabled(gate_id,comps[3],true)
    EntityLoad("mods/apotheosis/files/biome_impl/magicegg/portal_open_emitter.xml", pos_x, pos_y)
end

if tonumber(GlobalsGetValue("apotheosis_plane_fail",0)) == 1 then
    EntitySetComponentsWithTagEnabled(entity_id,"invincible",false)
    EntitySetComponentsWithTagEnabled(entity_id,"counter",true)
elseif #EntityGetInRadiusWithTag(pos_x, pos_y, 512, "this_is_sampo") > 0 then
    local targets = EntityGetInRadius(pos_x, pos_y, 36)
    for k=1,#targets
    do local v = targets[k]
        if EntityGetName(v) == "lukki_portal" then
            EntityKill(v)
            Activate(entity_id)
            GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/bullet_lightning/create", pos_x, pos_y )
            GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/angered_the_gods/create", pos_x, pos_y )
            GameTriggerMusicEvent( "music/oneshot/dark_03", true, pos_x, pos_y )
            break
        end
    end
end

--[[
]]--

