
function reject_player(player_id)
    local entity_id = GetUpdatedEntityID()
    local x,y = EntityGetTransform(entity_id)
    EntityInflictDamage( player_id, 0.4, "DAMAGE_CURSE", "$status_apotheosis_brain_damage_perma_name", "NONE", 0, 0, entity_id, x, y, 100 )
    local p_x, p_y = EntityGetTransform(player_id)
    local cdcomp = EntityGetFirstComponentIncludingDisabled(player_id,"CharacterDataComponent")
    local vel_x = p_x - x
    local vel_y = p_y - y
    ComponentSetValue2(cdcomp,"mVelocity",vel_x * 50,vel_y * 50)

    local stun = EntityLoad("data/entities/misc/effect_electricity.xml",x,y)
    EntityAddChild(player_id,stun)

    local plyr_dmgcomp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")
    ComponentSetValue2(plyr_dmgcomp,"is_on_fire",true)
    ComponentSetValue2(plyr_dmgcomp,"mIsOnFire",true)
    ComponentSetValue2(plyr_dmgcomp,"mFireDurationFrames",180)
    ComponentSetValue2(plyr_dmgcomp,"mFireFramesLeft",180)

    GamePrint("$item_apotheosis_dispell_key_cursed_desc_reveal")
    GamePlaySound( "data/audio/Desktop/explosion.bank", "explosions/electric", x, y )
end

function interacting(entity_who_interacted, entity_interacted, interactable_name)
    reject_player(entity_who_interacted)
end

function collision_trigger()
    local entity_id = GetUpdatedEntityID()
    local x,y = EntityGetTransform(entity_id)
    EntityKill(entity_id)
    EntityLoad("mods/Apotheosis/files/entities/items/wands/custom/spell_book.xml",x,y)
end