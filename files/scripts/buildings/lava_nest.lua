local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local targets = (EntityGetInRadiusWithTag(pos_x, pos_y, 30, "egg_item"))

for k=1, #targets
do local v = targets[k];
    if EntityGetName(v) == "core_mines_entry" and EntityGetParent( v ) == 0 then
        local egg_x, egg_y = EntityGetTransform( v )

        EntityLoad("data/entities/particles/image_emitters/chest_effect.xml", egg_x, egg_y)
        EntityLoad("mods/apotheosis/files/entities/buildings/lava_nest_portal.xml", pos_x, pos_y - 60)
        EntityKill( v )
        
        GamePlaySound( "data/audio/Desktop/projectiles.snd", "projectiles/magic/create", egg_x, egg_y)
    end
end
