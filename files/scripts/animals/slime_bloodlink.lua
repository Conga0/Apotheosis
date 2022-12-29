dofile_once("data/scripts/lib/utilities.lua")

function damage_received( dmg, msg, source )
	local entity_id = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform( entity_id )
	local player = EntityGetInRadiusWithTag(pos_x, pos_y, 92, "player_unit")
	if #player >= 1 then 

		GamePrint("Damage taken & player found, do dmg")
	
		if ( source ~= nil ) and ( source ~= NULL_ENTITY ) and ( source ~= entity_id ) then
			local hm = EntityGetTransform( source )
			
			if ( hm ~= nil ) then
				EntityInflictDamage( source, dmg, "DAMAGE_CURSE", "$damage_orb_blood", "DISINTEGRATED", 0, 0, entity_id )
			end
		else
			--[[
			local pls = EntityGetInRadiusWithTag( x, y, 160, "player_unit" )
			if ( #pls > 0 ) then
				local pl = pls[1]
				
				EntityInflictDamage( pl, dmg, "DAMAGE_CURSE", "$damage_orb_blood", "DISINTEGRATED", 0, 0, entity_id )
			end
			]]--
		end
		
		local comp = EntityGetFirstComponent( entity_id, "DamageModelComponent" )
		if ( comp ~= nil ) then
			local max_hp = ComponentGetValue2( comp, "max_hp" )
			ComponentSetValue2( comp, "hp", max_hp )
		end
	end
end