local function extract(projc, keys)
	local desc = ComponentObjectGetValue2(projc, "config", "action_description")
	-- Set up vars, iter through desc and store indicies
	local data_lim, indxs = math.max(unpack(keys)), {[0]=0}
	for i=1, data_lim do indxs[i] = desc:find("\n", (indxs[i-1]or 0)+1) end
	indxs[data_lim]=desc:len()

	-- Extract data at requested indicies
	local data = {}
	for i=1, #keys do data[i]=desc:sub((indxs[i-1]or 0)+1,indxs[i])--[[ print(tostring(i), tostring(indxs[i]))]]end
	return unpack(data)
end

return extract
-- EXAMPLE USAGE: local cast_id, thing = extract(projc, {1, 2})


--[[
	-- Extract data at requested indicies
	for i=1, #keys do if not Cache[i] then Cache[i]=desc:sub(indxs[i-1]+1,indxs[i]-1) end end
	return unpack(Cache)
]]

--[=[
	I SHOULD have set this all up right to use conga :)
	You can call WriteCToDatat(c) in the action function to automagically write the contents of c to Datat[2]
	Datat is write only, you must read from DontTouch_Data (this is how the auto-assignment max is handled)
	You can always just @ me if you need an explainer or anything!!! 
	The data will be stored as a string.char(255) -> � separated string of strings
	It is in the same order as the fields of the gunaction_config
	You can probably steal the above code used to split by newlines, swapping it out for string.char(255)
	Nominal use: 

	local extract = dofile_once("mods/Apotheosis/files/scripts/misc/proj_data.lua")
	local entity_id = GetUpdatedEntityID()
	local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
	local c_data = extract(projcomp, {2})
	
	This will spit out the � separated string for c, for which you can split the data out of
	You may need to do type conversion, or possibly use the non-2 ComponentSetValue (as this only accepts strings)
	However using ComponentSetValue is slower, so it's a tradeoff
	Sorry for my incessant rambling!!
	- Copi, tiredly writing at 2PM knowing damn well it isn't okay to wake up after sunset
	eepy seepy time for me <|:3 -zZzZ
]=]