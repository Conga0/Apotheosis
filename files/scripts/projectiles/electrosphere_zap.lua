
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ProjectileComponent")
local shooter_id = ComponentGetValue2(projcomp,"mWhoShot") or 0
local sound = false

--Handles if it should attack a target or not
function friendlyfireCheck(target_id,projectilecomponent,caster_id)
    if EntityGetFirstComponentIncludingDisabled(target_id,"DamageModelComponent") == nil or EntityGetParent(target_id) ~= 0 then
        return false
    end

    if ComponentGetValue2(projectilecomponent,"friendly_fire") == true then
        return true
    elseif target_id ~= caster_id then
        return true
    else
        return false
    end
end

--All of this is to grab the correct damage values from the origin projectile
local damagetable = {
    {
        name = "PROJECTILE",
        dmg = ComponentGetValue2(projcomp,"damage") or 0,
    },
}

local damagetypes = {
    "melee",
    "explosion",
    "electricity",
    "slice",
    "ice",
    "curse",
    "drill",
    "fire",
}

for k=1,#damagetypes
do  local v = damagetypes[k]
    local tbl = {
        name = string.upper(v),
        dmg = (ComponentObjectGetValue2( projcomp, "damage_by_type", v ) or 0),
    }

    if tbl.dmg ~= 0 then
        table.insert(damagetable,tbl)
    end
end

local targets = EntityGetInRadiusWithTag(pos_x,pos_y,60,"hittable")
for k=1,#targets
do local v = targets[k]
    --Check we aren't doing self-damage, or damage to things inside inventories, or damage to things which can't take damage
    if friendlyfireCheck(v,projcomp,shooter_id) then

        --Play audio up to one time when shooting
        if sound == false then
            GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/chain_bolt/create", pos_x, pos_y )
            sound = true
        end

        --Graphics
        --Here we load an entity to trail a draw, then tell that trail to draw from the projectile to the target
        --Conga: Could be optimised with the new GameCreateCosmeticParticle function? Uncertain if worth the effort
        local targ_x, targ_y = EntityGetTransform(v)
        local child = EntityLoad("mods/apotheosis/files/entities/animators/electrosphere_fx.xml", targ_x, targ_y)
        local comp = EntityGetFirstComponentIncludingDisabled(child,"ParticleEmitterComponent")
        ComponentSetValue2(comp, "mExPosition", pos_x, pos_y)

        --Damage
        --Here we deal damage equal to what the main projectile has
        --Maybe it'd be better to load a clone of the main projectile ontop of the enemy and give it the extra entities? prooobably not good to load *another* entity every shot though
        for z=1,#damagetable
        do local c = damagetable[z]
            EntityInflictDamage( v, c.dmg, table.concat({"DAMAGE_",c.name}), "$spell_apotheosis_electrosphere_name", "NONE", 0, 0, shooter_id )

            --Unlike burn or electric damage, The frozen effect isn't handled innately through ice damage, so we need to insert it here
            if c.name == "ICE" then
                if EntityHasTag(v,"robot") == false and GameGetGameEffectCount( v, "STUN_PROTECTION_FREEZE" ) < 1 and GameGetGameEffectCount( v, "PROTECTION_FREEZE" ) < 1 then
                    local child = EntityLoad("data/entities/misc/effect_frozen.xml",pos_x,pos_y)
                    EntityAddChild(v,child)
                else
                    local child = EntityLoad("data/entities/misc/effect_frozen_speed_up.xml",pos_x,pos_y)
                    EntityAddChild(v,child)
                end
            end
        end
    end
end