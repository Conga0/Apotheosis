local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local did_hit, hit_x, hit_y = Raytrace( pos_x, pos_y + 100, pos_x, pos_y + 512 )

function loadShrine(x,y)
    LoadPixelScene( "mods/Apotheosis/files/biome_impl/forest/shrine_puzzle_whisp.png", "mods/Apotheosis/files/biome_impl/forest/shrine_puzzle_whisp_colour.png", x-85, y-175, "mods/Apotheosis/files/biome_impl/forest/shrine_puzzle_whisp_background.png", true )
    EntityLoad("mods/Apotheosis/files/entities/buildings/shrine_puzzle_whisp_lantern.xml", x+2, y-103)
    EntityLoad("mods/Apotheosis/files/entities/props/glyphs/shrine_puzzle_whisp.xml", x+2, y-175)

    local targets = EntityGetInRadiusWithTag(x,y,300,"vegetation")
    for k=1,#targets do
        EntityKill(targets[k])
    end
end

if did_hit then
    loadShrine(hit_x,hit_y)
else
    loadShrine(pos_x,pos_y+200)
end


EntityKill(entity_id)