function damage_received( damage, desc, entity_who_caused, is_fatal )
	if not EntityGetIsAlive( entity_who_caused ) then
		return
	end

	--Removes the effect after 30 seconds (failsafe)
	local frame = GameGetFrameNum()
	local last_frame = tonumber( GlobalsGetValue( "apotheosis_swapper_curse", "-1800" ) )

	if frame >= last_frame + 1810 then
		local entity_id = GetUpdatedEntityID()
		local lua_list = EntityGetComponent(entity_id, "LuaComponent")
		for i,v in ipairs(lua_list) do
			local scriptpath = ComponentGetValue2(v, "script_damage_received")
			if (scriptpath == "mods/Apotheosis/files/scripts/status_effects/plagiarize_swapper.lua") then
				EntityRemoveComponent(entity_id, v)
			end
		end
		return
	end

	local entity_a    = GetUpdatedEntityID()
	local xa,ya = EntityGetTransform( entity_a )
	
	local entity_b = entity_who_caused
	local xb,yb = EntityGetTransform( entity_b )

	if not EntityHasTag(entity_b,"mortal") or EntityHasTag(entity_b,"no_swap") or EntityHasTag(entity_a,"no_swap") or damage < 0 then return end

	EntitySetTransform( entity_a, xb, yb )
	EntitySetTransform( entity_b, xa, ya )

	GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/swapper/swap", xb, yb );
end
