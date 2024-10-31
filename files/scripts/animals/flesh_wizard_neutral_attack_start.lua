local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 300

local targets = EntityGetInRadiusWithTag( x, y, r, "mortal" ) or {}

local animalai = EntityGetFirstComponentIncludingDisabled(entity_id, "AnimalAIComponent")
local aggression = ComponentGetValue2(animalai, "mAggression") or 40

for k=1, #targets
do local v = targets[k]
	local genome = EntityGetFirstComponentIncludingDisabled(v, "GenomeDataComponent")
	if v ~= entity_id and genome ~= nil and (EntityGetHerdRelation(entity_id, v) < aggression) then
	local t_x, t_y = EntityGetTransform(v)
	local did_hit = RaytraceSurfaces(x, y, t_x, t_y)
	if not did_hit then
		local attacking = false
    		local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
    		for i = 1, #luacomps do
			if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/Apotheosis/files/scripts/animals/flesh_wizard_neutral_attack_end.lua" then
			attacking = true
			end
		end

		if attacking == false then
			EntitySetComponentsWithTagEnabled(entity_id,"invincible",true)
			local warning_id = EntityLoad("mods/Apotheosis/files/entities/projectiles/laserbeam_flesh_neutral_warning.xml", x, y)
			EntityAddChild( entity_id, warning_id )
			GamePlaySound( "data/audio/Desktop/animals.bank", "animals/drone_lasership/open", x, y )
			GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/magic/neutral_laser_buildup", x, y )

			EntityAddComponent(entity_id, "LuaComponent", {
				script_source_file="mods/Apotheosis/files/scripts/animals/flesh_wizard_neutral_attack_end.lua",
				execute_every_n_frame=120,
				execute_on_added=0,
				remove_after_executed=1
			}) 
		end
		break
	end
	end
end
