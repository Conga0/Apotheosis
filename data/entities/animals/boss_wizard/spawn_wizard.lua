dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

SetRandomSeed( x, y * entity_id )

local opts = { "wizard_ambrosia", "wizard_duck", "wizard_jackofalltrades", "wizard_manaeater", "wizard_transmutation", "wizard_tele", "wizard_dark", "wizard_poly", "wizard_homing", "wizard_weaken", "wizard_twitchy", "wizard_neutral", "wizard_hearty", "wizard_returner" }

if ModIsEnabled("new_enemies") then
	opts = { "wizard_random", "wizard_time", "wizard_toxic", "wizard_trip", "wizard_earthquake", "wizard_water", "wizard_ambrosia", "wizard_duck", "wizard_jackofalltrades", "wizard_manaeater", "wizard_transmutation", "wizard_tele", "wizard_dark", "wizard_poly", "wizard_homing", "wizard_weaken", "wizard_twitchy", "wizard_neutral", "wizard_hearty", "wizard_returner" }
else
	opts = { "wizard_ambrosia", "wizard_duck", "wizard_jackofalltrades", "wizard_manaeater", "wizard_transmutation", "wizard_tele", "wizard_dark", "wizard_poly", "wizard_homing", "wizard_weaken", "wizard_twitchy", "wizard_neutral", "wizard_hearty", "wizard_returner" }
end

for i=1,1 do
	local rnd = Random( 1, #opts )
	EntityLoad( "data/entities/animals/" .. opts[rnd] .. ".xml", x, y )
end

EntityKill( entity_id )
