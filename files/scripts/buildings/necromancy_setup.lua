local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local radius = 144

local targets = EntityGetInRadiusWithTag( x, y, radius, "mortal" )
local found = false

for k=1,#targets
do v = targets[k]
	if ( EntityHasTag( v, "player_unit" ) == false ) and ( EntityHasTag( v, "necrobot_NOT" ) == false ) then
		local file = EntityGetFilename( v )
		
		if ( file ~= nil ) and ( #file > 0 ) and ( string.find( file, "entities/animals/" ) ~= nil ) then
			EntityAddComponent( v, "LuaComponent", 
			{ 
				script_death = "mods/apotheosis/files/scripts/status_effects/necrobot_gold.lua",
				execute_every_n_frame = "-1",
			} )
			
			local eid = EntityLoad( "data/entities/particles/tinyspark_green_sparse.xml", x, y )
			EntityAddChild( v, eid )
		end
		
		EntityAddTag( v, "necrobot_NOT" )
	end
end

EntityKill(entity_id)
