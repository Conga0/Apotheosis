
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local orbital_count = 6

for i=1,orbital_count do

    local eid = EntityLoad( "data/entities/animals/enchanted_books/enchanted_book_fire_flame.xml", x, y )

	if ( eid ~= nil ) then
		EntityAddChild( entity_id, eid )
		
		local comp = EntityGetFirstComponent( eid, "VariableStorageComponent", "wizard_orb_id" )
		if ( comp ~= nil ) then
			ComponentSetValue2( comp, "value_int", i-1 )
		end
	end
end

local comps = EntityGetComponentIncludingDisabled(entity_id,"LuaComponent")
for k=1,#comps
do local v = comps[k]
	if ComponentGetValue2(v,"script_source_file") == "data/entities/animals/enchanted_books/enchanted_book_fire_orbit_init.lua" then
		ComponentSetValue2(v,"script_source_file","")
		ComponentSetValue2(v,"execute_every_n_frame",-1)
		break
	end
end