local haxx = function (entity_id, orbcount, radius)
	radius=math.max(radius, 6)
	local evil = GameHasFlagRun("apotheosis_evil_knowledge")

	--[[
	================================================================================= VISUAL: RINGS
	]]

	local function color(i)
		if not evil then
			return table.concat{math.random(1,9),"_",i%14+1}
		else
			return table.concat{"c_",math.random(1,9),"_",math.random(1,4)}
		end
	end

	if orbcount>0 and not EntityHasTag(entity_id, "projectile_cloned")then
		-- Add visual rings. +1 ring per 7.5 orbs.
		for j=1, math.min(math.floor(orbcount/7.5)+1, 5) do
			local ring = EntityCreateNew(tostring(radius))
			EntityAddChild(entity_id, ring)
			for i=1, math.floor((math.pi*radius)/6) do
				EntityAddComponent2(ring, "SpriteComponent", {
					image_file=table.concat{"mods/Apotheosis/files/particles/knowledge/", color(i), ".png"},--image_file="data/debug/circle_16.png",
					has_special_scale=true,
					emissive=true,
					additive=not evil,
					special_scale_x=1,
					special_scale_y=1,
					offset_x=5,
					offset_y=5,
					alpha=0.3+math.random()*0.1,
				})
			end
			EntityAddComponent2(ring, "LuaComponent", {script_source_file=table.concat{"mods/Apotheosis/files/scripts/projectiles/orb_knowledge_ring", j==1 and "_1" or "", ".lua"}})
			EntityAddComponent2(ring, "InheritTransformComponent", {only_position=true})
		end
	end

	--[[
	================================================================================= MECHANICAL: HIT RADIUS
	]]

	-- Modify hit radius, apply self damage if cursed orb
	local gaec = EntityGetFirstComponent(entity_id, "GameAreaEffectComponent") --[[@cast gaec number]]
	ComponentSetValue2(gaec, "radius", radius)

	--[[
	================================================================================= MECHANICAL: DAMAGE & PROPORTIONS
	]]

	-- Modify damage
	local types = {"melee", "projectile", "explosion", "electricity", "fire", "drill", "slice", "ice", "healing", "physics_hit", "radioactive", "poison", "overeating", "curse", "holy"}
	local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent") --[[@cast projcomp number]]

	if evil then
		ComponentSetValue2(projcomp, "friendly_fire", true)
	end
	ComponentSetValue2(projcomp, "lifetime", ComponentGetValue2(projcomp, "lifetime")+math.max(10*orbcount, 120))
	-- Add radius scaled don't hit shooter frames?

	-- R, G, B
	local color_weight = {0, 0, 0}
	local type_weights = {
		{ 2.00, 0.50, 0.50 },
		{ 1.00, 1.00, 1.00 },
		{ 2.00, 1.00, 0.00 },
		{ 0.00, 1.50, 1.50 },
		{ 2.00, 1.00, 0.00 },
		{ 0.00, 2.00, 1.00 },
		{ 2.00, 0.50, 0.50 },
		{ 0.50, 0.50, 2.00 },
		{ 0.50, 1.00, 0.50 },
		{ 1.00, 1.00, 1.00 },
		{ 0.25, 2.50, 0.25 },
		{ 1.00, 0.00, 2.00 },
		{ 2.00, 0.50, 0.50 },
		{ 2.00, 0.50, 0.50 },
		{ 1.25, 1.25, 0.50 },
	}

	-- Remember highest damage type, defaulting to projectile
	local dmg = ComponentGetValue2(projcomp, "damage")
	local highest = {0,dmg}

	-- Add 10% damage per orb to all types, and add typed damage to weighting
	-- Div by 60 for per-frame dmg
	-- 60 is too low, seemingly
	ComponentSetValue2(projcomp, "damage", (dmg*(1 + (0.1 * orbcount)))/15)
	if not evil then
		color_weight[1] = color_weight[1] + dmg
		color_weight[2] = color_weight[2] + dmg
		color_weight[3] = color_weight[3] + dmg
	end
	for i=1, #types do
		dmg = ComponentObjectGetValue2(projcomp, "damage_by_type", types[i])
		if dmg > highest[1] then highest={i, dmg} end
		ComponentObjectSetValue2(projcomp, "damage_by_type", types[i], (dmg*(1 + (0.1 * orbcount)))/15)
		if not evil then 
			color_weight[1] = color_weight[1] + type_weights[i][1] * dmg
			color_weight[2] = color_weight[2] + type_weights[i][2] * dmg
			color_weight[3] = color_weight[3] + type_weights[i][3] * dmg
		end
	end

	-- Add final 5 damage per second per orb to highest type, and to color weighting
	local final_dmg = (0.2*orbcount)/15
	if highest[1]==0 then
		ComponentSetValue2(projcomp, "damage", ComponentGetValue2(projcomp, "damage")+final_dmg)
		if not evil then
			color_weight[1] = color_weight[1] + final_dmg
			color_weight[2] = color_weight[2] + final_dmg
			color_weight[3] = color_weight[3] + final_dmg			
		end
	else
		ComponentObjectSetValue2(projcomp, "damage_by_type", types[highest[1]], ComponentObjectGetValue2(projcomp, "damage_by_type", types[highest[1]])+final_dmg)
		if not evil then
			color_weight[1] = color_weight[1] + type_weights[highest[1]][1] * final_dmg
			color_weight[2] = color_weight[2] + type_weights[highest[1]][2] * final_dmg
			color_weight[3] = color_weight[3] + type_weights[highest[1]][3] * final_dmg			
		end
	end
	if evil then
		color_weight = {1, 0.0, 0.0}
	end

	--[[
	================================================================================= VISUAL: INNER GLOW
	]]

	-- Create inner glow
	local sum_color = color_weight[1]+color_weight[2]+color_weight[3]
	local inner_glow = EntityCreateNew("inner_glow")
	EntityAddChild(entity_id, inner_glow)
	EntityAddComponent2(inner_glow, "InheritTransformComponent")
	if evil then
		local pec = EntityAddComponent2(inner_glow, "ParticleEmitterComponent", {
			emitted_material_name="spark_red",
			lifetime_min=0.05*radius^0.25,
			lifetime_max=0.25*radius^0.25,
			count_min=math.floor((math.pi*radius)/3),
			count_max=math.floor((math.pi*radius)/6),
			render_on_grid=true,
			fade_based_on_lifetime=true,
			cosmetic_force_create=false,
			airflow_force=0.5,
			airflow_time=0.1,
			airflow_scale=0.5,
			emission_interval_min_frames=1,
			emission_interval_max_frames=1,
			emit_cosmetic_particles=true,
			is_emitting=true,
			attractor_force=24,
		})
		ComponentSetValue2(pec, "gravity", 0, 0)
		ComponentSetValue2(pec, "area_circle_radius", radius-3, radius)
	end
	for i=1, 3 do
		EntityAddComponent2(inner_glow, "SpriteComponent", {
			image_file=table.concat{"mods/Apotheosis/files/particles/knowledge/glow_", i,".png"},
			next_rect_animation="",
			rect_animation="smoke",
			update_transform_rotation=false,
			has_special_scale=true,
			emissive=true,
			additive=true,
			special_scale_x=radius/128,
			special_scale_y=radius/128,
			offset_x=128,
			offset_y=128,
			alpha=(color_weight[i]/sum_color)*0.2+0.1
		})
	end

end

return haxx