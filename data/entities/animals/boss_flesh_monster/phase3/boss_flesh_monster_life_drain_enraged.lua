local entity_id = GetUpdatedEntityID()
local pos_x,pos_y = EntityGetTransform( entity_id )
local r = 75

local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "mortal" ) or {}
local currently_sapping_2 = false

for k=1, #targets
do local v = targets[k]
	local genome = EntityGetFirstComponentIncludingDisabled(v, "GenomeDataComponent")
	local hatred_found = false
	local list = {"$enemy_apotheosis_poring_holy","$enemy_apotheosis_poring_holy_arch","$enemy_apotheosis_poring_devil","$enemy_apotheosis_angel"}
	for s=1, #list 
	do local hated = list[s]
		if ( EntityGetName(v) == hated ) then
			hatred_found = true
			break
		end
	end
	if v ~= entity_id and genome ~= nil and HerdIdToString(ComponentGetValue2( genome, "herd_id" )) ~= "mage_corrupted" and (EntityGetHerdRelation(entity_id, v) < 40 or hatred_found == true) then
		local t_x, t_y = EntityGetTransform(v)

		local currently_sapping = false
		local c = EntityGetAllChildren( v )
		if c ~= nil then
		for a,b in ipairs( c ) do
                	local effectname = EntityGetName( b )

	        	if ( effectname == "life_drain_heretic" ) then
                    		currently_sapping = true
				currently_sapping_2 = true
				break
	        	end
            	end
		end

		if currently_sapping == false then
			--Life sap effect
			local effect_id = EntityLoad("mods/Apotheosis/files/entities/misc/effect_life_drain_heretic_enraged.xml", pos_x, pos_y)
			EntityAddChild( v, effect_id)

			--Aesthetic life sap particles that go to Heretic
			local particle_id = EntityLoad("data/entities/animals/boss_flesh_monster/particles/life_drain_particles.xml", pos_x, pos_y)
			local varcomp = EntityGetFirstComponentIncludingDisabled(particle_id, "VariableStorageComponent") or {}
			ComponentSetValue2(varcomp, "value_int", v)
			EntityAddChild( entity_id, particle_id)

			--Cool pupil animation that was totally worth it
			local eye = EntityGetAllChildren(entity_id)[1]
			local pupil = EntityGetFirstComponentIncludingDisabled(eye, "SpriteComponent")
			if pupil ~= nil then
				ComponentSetValue2(pupil, "rect_animation", "sapping")
			end
			currently_sapping_2 = true
		end
	end
end

--Ignore this
--[[
local currently_sapping_2 = false
local childs = EntityGetAllChildren( entity_id )
if childs ~= nil then
	for a,b in ipairs( childs ) do
		local particlename = EntityGetName( b )
		if ( particlename == "life_drain_particles" ) then
			currently_sapping_2 = true
		end
	end
end
]]--

--Totally worth it...
if (currently_sapping_2 == false) then
	local eye = EntityGetAllChildren(entity_id)[1]
	local pupil = EntityGetFirstComponentIncludingDisabled(eye, "SpriteComponent")
	if pupil ~= nil then
		ComponentSetValue2(pupil, "rect_animation", "stand")
	end
end