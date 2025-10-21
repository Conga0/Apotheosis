
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local found = false

local targets = EntityGetInRadiusWithTag(pos_x,pos_y,130,"player_unit")
if GameGetGameEffectCount( entity_id, "CHARM" ) < 1 then
    for k=1,#targets
    do local v = targets[k]

        local plyr_x, plyr_y = EntityGetTransform(v)

        --Check if the player has a plasma shield of any kind, if so disable it
        local hit = RaytraceSurfaces(pos_x, pos_y - 10, plyr_x, plyr_y - 6)
        if not hit then
            local shieldren = EntityGetAllChildren(v)
            for z=1,#shieldren do
                if EntityHasTag(shieldren[z],"energy_shield") then
                    found = true
                    break
                end
            end
        end

        if found then
            --Play audio when sapping shields
            GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/megalaser/launch", pos_x, pos_y )
            GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/mana_fully_recharged", pos_x, pos_y )

            local c = EntityLoad("mods/Apotheosis/files/entities/misc/effect_shield_disabled.xml", pos_x, pos_y)
            EntityAddChild(v,c)

            --Graphics
            --Here we load an entity to trail a draw, then tell that trail to draw from the projectile to the target
            --Conga: Could be optimised with the new GameCreateCosmeticParticle function? Uncertain if worth the effort
            local child = EntityLoad("mods/Apotheosis/files/entities/animators/neutral_shield_fx.xml", plyr_x, plyr_y - 6)
            local comp = EntityGetFirstComponentIncludingDisabled(child,"ParticleEmitterComponent")
            ComponentSetValue2(comp, "mExPosition", pos_x, pos_y - 10)
        end
    end
end
