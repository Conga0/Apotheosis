local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 25

local targets = EntityGetInRadiusWithTag( x, y, r, "mortal" ) or {}

local animalai = EntityGetFirstComponentIncludingDisabled(entity_id, "AnimalAIComponent")
local aggression = ComponentGetValue2(animalai, "mAggression") or 40

for k=1, #targets
do local v = targets[k]
	local genome = EntityGetFirstComponentIncludingDisabled(v, "GenomeDataComponent")
	if v ~= entity_id and genome ~= nil and (EntityGetHerdRelation(entity_id, v) < aggression) then
		local t_x, t_y = EntityGetTransform(v)

		local attacking = false
    		local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
    		for i = 1, #luacomps do
			if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/Apotheosis/files/scripts/animals/flesh_wizard_wands_attack_end_end.lua" then
			attacking = true
			end
		end

		if attacking == false then
			local sprite_comps = EntityGetComponent(entity_id, "SpriteComponent") or {}
			for i, comp in ipairs(sprite_comps) do
				ComponentRemoveTag(comp, "character" )
				ComponentSetValue2(comp, "rect_animation", "attack_ranged")
			end

			local c = EntityGetAllChildren( entity_id )
			for a,b in ipairs( c ) do
                		local eyename = EntityGetName( b )

	        		if ( eyename == "eye" ) then
                    			local pupil_comp = EntityGetFirstComponentIncludingDisabled(b, "SpriteComponent")
					ComponentSetValue2(pupil_comp, "alpha", 0)
	        		end
            		end

			EntityAddComponent(entity_id, "LuaComponent", {
				script_source_file="mods/Apotheosis/files/scripts/animals/flesh_wizard_wands_attack_end.lua",
				execute_every_n_frame=36,
				execute_on_added=0,
				remove_after_executed=1
			}) 

			EntityAddComponent(entity_id, "LuaComponent", {
				script_source_file="mods/Apotheosis/files/scripts/animals/flesh_wizard_wands_attack_end_end.lua",
				execute_every_n_frame=54,
				execute_on_added=0,
				remove_after_executed=1
			}) 
		end
	end
end
