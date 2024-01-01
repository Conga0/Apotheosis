
table.insert(streaming_events,
{
    id = "apotheosis_creature_shift",
    ui_name = "$integration_apotheosis_CREATURE_SHIFT_name",
    ui_description = "$integration_apotheosis_CREATURE_SHIFT_desc",
    ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
    ui_author = "Apotheosis",
    weight = 1.0,
    kind = STREAMING_EVENT_BAD,
    action = function(event)
        
        dofile_once("mods/Apotheosis/files/scripts/magic/creature_shift_file.lua")
        local entity_id = EntityGetWithTag("player_unit")[1]
        local x, y = EntityGetTransform( entity_id )
        creature_shift( entity_id, x, y, true )
    end,
})
