
local entity_id = GetUpdatedEntityID()
local player_id = EntityGetRootEntity(entity_id)
local pos_x, pos_y = player_id
local owner_id = 0

--This function changes the thief into "flee" mode after successfully stealing your gold
function thiefFleeMode(thief_id)
    local animalcomp = EntityGetFirstComponentIncludingDisabled(thief_id,"AnimalAIComponent")
    ComponentSetValue2(animalcomp,"attack_ranged_entity_file","mods/apotheosis/files/entities/projectiles/melee/thief_tele_escape.xml") --Note: Tele escape won't work until he's given a stain map!!
    ComponentSetValue2(animalcomp,"attack_ranged_max_distance",300)

    local luacomp = EntityGetFirstComponentIncludingDisabled(thief_id,"LuaComponent")
    ComponentSetValue2(luacomp,"script_shot","mods/Apotheosis/files/scripts/animals/hiisi_thief_throw.lua")

    EntitySetComponentsWithTagEnabled(thief_id,"invincible",true)
end

if EntityHasTag(player_id,"player_unit") == true then
    local comps = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")
    for k=1,#comps
    do local v = comps[k]
        if ComponentGetValue2(v,"name") == "projectile_who_shot" then --This says projectile, but actually gives the ID of the creature who shot the projectile that caused the status effect
            owner_id = ComponentGetValue2(v,"value_int")
            break
        end
    end
end

if owner_id ~= 0 then
    local walletcomp = EntityGetFirstComponentIncludingDisabled(player_id,"WalletComponent")
    local gold = ComponentGetValue2(walletcomp,"money") or 0
    if gold > 0 then
        gold = gold / 2
        ComponentSetValue2(walletcomp,"money",gold)
    end

    local thiefgoldcomps = EntityGetComponentIncludingDisabled(owner_id,"VariableStorageComponent")
    for k=1,#thiefgoldcomps
    do local v = thiefgoldcomps[k]
        if ComponentGetValue2(v,"name") == "thief_gold" then
            ComponentSetValue2(v,"value_int",gold)
            GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/goldnugget/create", pos_x, pos_y );
            thiefFleeMode(owner_id)
            break
        end
    end
end
