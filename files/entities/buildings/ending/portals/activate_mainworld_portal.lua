
function item_pickup( entity_item, entity_who_picked, name )
    local entity_id = GetUpdatedEntityID()
    local pos_x, pos_y = EntityGetTransform(entity_id)
    local portal_id = EntityGetWithTag("apotheosis_portal")[1]

    function Activate(gate_id)
        local comps = EntityGetComponentIncludingDisabled(gate_id,"SpriteComponent")
        EntitySetComponentIsEnabled(gate_id,comps[3],true)
        EntityLoad("mods/apotheosis/files/biome_impl/magicegg/portal_open_emitter.xml", pos_x, pos_y - 30)
    end

    local sampo = EntityGetInRadiusWithTag(pos_x, pos_y, 512, "this_is_sampo")
    for k=1,#sampo
    do local v = sampo[k]
        EntityKill(v)
        Activate(portal_id)
        GameAddFlagRun("apotheosis_heretalk_portal_complete")
        GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/bullet_lightning/create", pos_x, pos_y )
        GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/angered_the_gods/create", pos_x, pos_y )
        GameTriggerMusicEvent( "music/oneshot/dark_03", true, pos_x, pos_y )

        --Disables this script from triggering again
        --Note: Replace this with a script that makes it so pressing E on the portal teleports you to another plane of existence
        --Only enable said script after a second or so, to make sure the player doesn't butter fingers E and accidentally enter
        local comp = EntityGetFirstComponentIncludingDisabled(portal_id,"LuaComponent")
        EntitySetComponentIsEnabled(portal_id,comp,false)

        --Enable Press E to enter interaction
        --Note: Only enable this when the Planes are finished, or if you're testing
        EntitySetComponentsWithTagEnabled(portal_id,"lurker_data",true)
        EntityKill(entity_id)
        break
    end
end
