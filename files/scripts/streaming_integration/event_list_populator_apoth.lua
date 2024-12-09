
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

table.insert(streaming_events,
{
    id = "apotheosis_egg_volcanic_lukki_trap",
    ui_name = "$integration_apotheosis_EGG_VOLCANIC_LUKKI_TRAP_name",
    ui_description = "$integration_apotheosis_EGG_VOLCANIC_LUKKI_TRAP_desc",
    ui_icon = "data/ui_gfx/streaming_event_icons/health_plus.png",
    ui_author = "Apotheosis",
    weight = 1.0,
    kind = STREAMING_EVENT_BAD,
    delay_timer = 300,
    action_delayed = function(event)
	for i = 1, 7 do
	    local min_range = 50
	    local max_range = 250
	    
	    local entity_id = EntityGetWithTag("player_unit")[1]
	    local x, y = EntityGetTransform( entity_id )
 	    
	    local angle = Random()*math.pi*2;
	    
	    local dx = math.cos(angle)*Random(min_range, max_range);
	    local dy = math.sin(angle)*Random(min_range, max_range);
	      
	    EntityLoad("mods/Apotheosis/files/entities/props/egg_volcanic_lukki_trap.xml", x + dx, y + dy)	
	end
    end,
})
