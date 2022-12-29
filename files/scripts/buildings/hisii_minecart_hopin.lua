dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 24

local targets = EntityGetInRadius( x, y, r )

local player = EntityGetWithTag("player_unit")
if #player >= 1 then
	for i,v in ipairs( targets ) do
		if ( v ~= entity_id ) and ( EntityGetName( v ) == "minecart_hisii_hopin" ) then
			--GamePrint("HISII MINECART LUA CHECK")
			local target_x,target_y = EntityGetTransform( v )
			GameDropAllItems( entity_id )
			local eid = EntityLoad( "data/entities/animals/hisii_minecart.xml", target_x, target_y - 2 )
			EntityKill ( v )
			EntityKill ( entity_id )

			if ModIsEnabled("purgatory") or ModIsEnabled("nightmare") then
				local comp = EntityGetFirstComponent( eid, "DamageModelComponent" )

				local health = ComponentGetValue2( comp, "hp" )
				local health_max = ComponentGetValue2( comp, "max_hp" )

				health = health * 2
				health_max = health_max * 2

				ComponentSetValue( comp, "max_hp", tostring(health_max) )
				ComponentSetValue( comp, "hp", tostring(health) )
			end
		end
	end
end