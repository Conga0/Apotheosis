dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 24
local combo_count = 2
local cart_found = false

local targets = EntityGetInRadius( x, y, r )

local player = EntityGetWithTag("player_unit")
if #player >= 1 then
	for k=1,#targets
	do local v = targets[k]
		if ( v ~= entity_id ) and ( EntityGetName( v ) == "minecart_hisii_hopin" ) and cart_found == false then
			--GamePrint("HISII MINECART LUA CHECK")
			local target_x,target_y = EntityGetTransform( v )
			GameDropAllItems( entity_id )

			local path = "data/entities/animals/hisii_minecart.xml"
			local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"MusicEnergyAffectorComponent") or false
			if comp ~= false then --Weak Hiisi
				path = "data/entities/animals/hisii_minecart_weak.xml"
			end
			local eid = EntityLoad( path, target_x, target_y - 2 )


			local VSCComps = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")
			if VSCComps then
				for k=1,#VSCComps
				do v = VSCComps[k]
					if ComponentGetValue2(v,"name") == "cart_combo_bonus" then
						combo_count = ComponentGetValue2(v,"value_int")
					end
				end
			end

			if combo_count >= 64 then
				combo_count = 64
				local c = EntityLoad("mods/Apotheosis/files/entities/misc/drop_gold_visual.xml", x, y)
				EntityAddChild(eid,c)
			end
		
			EntityAddComponent2(
				eid,
				"VariableStorageComponent",
				{
					name="cart_combo_bonus",
					value_int=combo_count * 2,
				}
			)

			--GamePrint("combo_count is " .. combo_count)

			cart_found = true
			EntityKill ( v )
			EntityKill ( entity_id )

		end
	end
end
