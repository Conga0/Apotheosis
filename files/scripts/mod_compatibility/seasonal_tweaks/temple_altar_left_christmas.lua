
local init_old = init

function init( x, y, w, h )
    init_old( x, y, w, h )

    if is_holiday_active("smissmass") then
        --Christmass Tree
        EntityLoad("mods/Apotheosis/files/entities/buildings/christmas/christmas_tree.xml", x+350, y+395)

        --Fairy Lights
        EntityLoad("mods/Apotheosis/files/entities/props/christmas/fairy_lights_loader.xml", x+350, y+350)
        EntityLoad("mods/Apotheosis/files/entities/props/christmas/fairy_lights_loader.xml", x+350+200, y+350)

        if day == 25 and month == 12 then
            --Spawn free presents on christmas day
        end
    end
end