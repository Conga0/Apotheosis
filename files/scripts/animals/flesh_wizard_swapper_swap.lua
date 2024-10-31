function damage_received( damage, desc, entity_who_caused, is_fatal )
	if not EntityGetIsAlive( entity_who_caused ) then
		return
	end

	local entity_id = GetUpdatedEntityID()

	local var_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent")
	local frame = ComponentGetValue2(var_comp, "value_float")
	local extra = 30 -- wait half a second before being able to teleport again

	if ( frame + extra < GameGetFrameNum() ) then

		ComponentSetValue2(var_comp, "value_float", GameGetFrameNum())

		local entity_a    = GetUpdatedEntityID()
		local xa,ya = EntityGetTransform( entity_a )
	
		local entity_b = entity_who_caused
		local xb,yb = EntityGetTransform( entity_b )

		local dist_x = xa - xb
		local dist_y = ya - yb

		local xc = xb + (dist_x / 2)
		local yc = yb + (dist_y / 2)

		if not EntityHasTag(entity_b,"mortal") or EntityHasTag(entity_b,"no_swap") or EntityHasTag(entity_a,"no_swap") or damage < 0 then return end

		EntityApplyTransform( entity_a, xc, yc )
		EntityApplyTransform( entity_b, xc, yc )
		EntityLoad( "mods/Apotheosis/files/entities/particles/flesh_wizard_swapper_swap_particles.xml", xc, yc )

		GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/swapper/swap", xb, yb );
		GamePlaySound( "data/audio/Desktop/projectiles.bank", "animals/wraith_glowing/shoot", xb, yb );

		local sprite_comps = EntityGetComponent(entity_id, "SpriteComponent") or {}
		for i, comp in ipairs(sprite_comps) do
			ComponentRemoveTag(comp, "character" )
			ComponentSetValue2(comp, "rect_animation", "swapped")
			ComponentSetValue2(comp, "next_rect_animation", "stand")
		end

		local c = EntityGetAllChildren( entity_id )
		for a,b in ipairs( c ) do
                	local eyename = EntityGetName( b )

	        	if ( eyename == "eye" ) then
				local pupil_comps = EntityGetComponent(b, "SpriteComponent") or {}
				for i, comp in ipairs(pupil_comps) do
					ComponentRemoveTag(comp, "character" )
					ComponentSetValue2(comp, "rect_animation", "swapped")
					ComponentSetValue2(comp, "next_rect_animation", "stand")
				end
	        	end
       		end

		--Blehhh animationnnnsssszzzz...
		EntityAddComponent(entity_id, "LuaComponent", {
			script_source_file="mods/Apotheosis/files/scripts/animals/flesh_wizard_swapper_swap_end.lua",
			execute_every_n_frame=15,
			execute_on_added=0,
			remove_after_executed=1
		}) 
	end
end
