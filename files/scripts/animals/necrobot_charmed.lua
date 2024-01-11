
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local radius = 144

local targets = EntityGetInRadiusWithTag( x, y, radius, "mortal" )
local found = false
local charmTest = GameGetGameEffectCount( entity_id, "CHARM" )

for i,v in ipairs( targets ) do
	if ( EntityHasTag( v, "player_unit" ) == true ) and charmTest >= 1 then
		local found = false

		local children = EntityGetAllChildren(v)
		for k=1,#children do
			if EntityGetName(children[k]) == "apotheosis_respawn_temp" then
				found = true
			end
		end
		
		if found == false then
			local c = EntityLoad("mods/apotheosis/files/entities/misc/effect_respawn_temporary.xml", x, y)
			EntityAddChild(v,c)
		end
	end
end