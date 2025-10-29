
local init_old = init

function init( x, y, w, h )
    init_old( x, y, w, h )

    if is_holiday_active("smissmass") then
        --Fairy Lights
        EntityLoad("mods/Apotheosis/files/entities/props/christmas/fairy_lights_loader.xml", x, y+260+80)
    end
end