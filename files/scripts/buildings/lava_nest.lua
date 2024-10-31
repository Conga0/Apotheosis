local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local targets = (EntityGetInRadiusWithTag(pos_x, pos_y, 30, "egg_item"))

for k=1, #targets
do local v = targets[k];
    if EntityGetName(v) == "core_mines_entry" and EntityGetParent( v ) == 0 then
        local egg_x, egg_y = EntityGetTransform( v )

        EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", egg_x, egg_y)
        local portal = false
        local portals = (EntityGetInRadiusWithTag(pos_x, pos_y, 70, "building"))
        for i=1, #portals
        do local p = portals[i];
            if EntityGetName(p) == "core_mines_portal" then
                portal = true
            end
        end
        if not portal then
            EntityLoad("mods/apotheosis/files/entities/buildings/lava_nest_portal.xml", pos_x, pos_y - 60)
        end
        local egg_amount = tonumber(GlobalsGetValue("APOTHEOSIS_EGG_VOLCANIC_TRAP_AMOUNT","3"))
        GlobalsSetValue("APOTHEOSIS_EGG_VOLCANIC_TRAP_AMOUNT",tostring(egg_amount+1))
        EntityKill( v )
        
        GamePlaySound( "data/audio/Desktop/projectiles.snd", "projectiles/magic/create", egg_x, egg_y)
    end
end
