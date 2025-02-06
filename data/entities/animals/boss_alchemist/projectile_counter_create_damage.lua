dofile_once("data/scripts/lib/utilities.lua")
local last_frame = -100000

--Conga: Doing this the quick and dirty way for now, planned to be fixed when I'm less sleepy; but I can't release Tuonela with this as is due to worms spawning ontop of alchemists,
--resulting in thousands of shields spawning and the game crawling to a halt.
--Fix your game Nolla!!!

function damage_received( damage )
	local entity_id = GetUpdatedEntityID()
	local frame = GameGetFrameNum()
	local vcomp = 0
	local cumulative = 0.0
	local dcomp = 0

	local comps = EntityGetComponent(entity_id,"VariableStorageComponent")
	for k=1,#comps
	do comp = comps[k]
		if ComponentGetValue2(comp,"name") == "shield_cd_data" then
			vcomp = comp
			last_frame = ComponentGetValue2(comp,"value_int")
		end
	end

	if (frame <= last_frame + 60*3) then return end

	local s = EntityGetComponent( entity_id, "VariableStorageComponent" )
	if ( s ~= nil ) then
		for i,v in ipairs( s ) do
			local name = ComponentGetValue2( v, "name" )
			
			if ( name == "damage_received" ) then
				cumulative = ComponentGetValue2( v, "value_float" )
				
				cumulative = cumulative + damage
				
				ComponentSetValue2( v, "value_float", cumulative )
				dcomp = v
			end
		end
	end
	
	--print( tostring(cumulative) .. ", " .. tostring(dcomp) )
	
	if ( damage >= 2.0 ) or ( cumulative >= 3.0 ) then
		local x, y = EntityGetTransform( entity_id )

		local eid = EntityLoad( "data/entities/animals/boss_alchemist/projectile_counter.xml", x, y )
		EntityAddChild( entity_id, eid )
		ComponentSetValue2(vcomp,"value_int",GameGetFrameNum())
		
		if ( dcomp ~= NULL_ENTITY ) then
			cumulative = cumulative - 3.0
			ComponentSetValue2( dcomp, "value_float", cumulative )
		end
	end
end