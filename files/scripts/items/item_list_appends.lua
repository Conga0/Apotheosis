--Thankyou Eba
local function register_item(listname, weight, entity, offset) -- use this to register an item in spawn table
    if ( type( listname ) == "string" ) then
        local newmin = spawnlists[listname].rnd_max + 1
        local newmax = newmin + weight
        local tbl = {
            value_min = newmin,
            value_max = newmax,
            offset_y = offset,
            load_entity = entity
        }
        table.insert(spawnlists[listname].spawns, tbl)
        spawnlists[listname].rnd_max = newmax
    elseif ( type( listname ) == "table" ) then
        local newmin = listname.rnd_max + 1
        local newmax = newmin + weight
        local tbl = {
            value_min = newmin,
            value_max = newmax,
            offset_y = offset,
            load_entity = entity
        }
        table.insert(listname.spawns, tbl)
        listname.rnd_max = newmax
    end
end


local items = {
    {
        weight = 3,
        entity = "data/entities/items/pickup/Apotheosis/egg_fairy.xml",
        offset = -2
    },
    {
        weight = 3,
        entity = "data/entities/items/pickup/Apotheosis/egg_mud.xml",
        offset = -2
    },
    {
        weight = 3,
        entity = "data/entities/items/pickup/Apotheosis/egg_robot.xml",
        offset = -2
    },
}

local year, month, day, hour, minute = GameGetDateAndTimeLocal()
if ((( month == 9 ) and ( day == 9 )) and ModSettingGet( "Apotheosis.seasonal_events" )) or ModSettingGet( "Apotheosis.seasonal_events_forced_cirno" ) then
    table.insert(items,{
        weight = 3,
        entity = "mods/Apotheosis/files/entities/items/pickups/orb_cirno.xml",
        offset = -2
    })
end

for i, v in ipairs(items) do
    register_item("potion_spawnlist", v.weight, v.entity, v.offset)
end