dofile_once("data/scripts/lib/utilities.lua")

local effect_id = GetUpdatedEntityID()
local entity_id = EntityGetParent(effect_id)
local pos_x, pos_y = EntityGetTransform( entity_id )
	
local genomecomp = EntityGetFirstComponentIncludingDisabled( entity_id, "GenomeDataComponent" )
local corrupted = false

if ( genomecomp ~= nil ) then
	local faction = ComponentGetValue2( genomecomp, "herd_id" )

	-- am I a forbidden heretic to the Divine?
	if faction == StringToHerdId("mage_corrupted") then
		-- then PERISH!
		corrupted = true
	elseif faction == StringToHerdId("mage_swapper") then
		-- wait you're a swapper? ok one sec lemme just doublecheck...
		local aicomp = EntityGetFirstComponentIncludingDisabled(entity_id,"AnimalAIComponent")
		if ComponentGetValue2(aicomp,"attack_ranged_entity_file") == "mods/Apotheosis/files/entities/projectiles/orb_corrupt_swapper.xml" then
			--oh I see... then PERISH!
			corrupted = true
		end
	elseif faction == StringToHerdId("healer") then
		-- wait you're a healer? ok one sec lemme just doublecheck...
		local spritecomp = EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent")
		if ComponentGetValue2(spritecomp,"image_file") == "mods/Apotheosis/files/enemies_gfx/wizard_corrupt_ambrosia.xml" then
			--oh I see... then PERISH!
			corrupted = true
		end
	end
end

if corrupted == true then
	local child_id = EntityLoad("mods/Apotheosis/files/entities/misc/effect_flesh_curse_super.xml",pos_x,pos_y)
	EntityAddChild(entity_id,child_id)
	local effectcomps = EntityGetComponentIncludingDisabled(effect_id, "GameEffectComponent") or {}
	if effectcomps ~= nil then
    		for i = 1, #effectcomps do
	    		if ComponentGetValue2(effectcomps[i], "effect") == "REGENERATION" or ComponentGetValue2(effectcomps[i], "effect") == "PROTECTION_ALL" then
				EntityRemoveComponent(effect_id,effectcomps[i])
	    		end
    		end
	end
	local particlecomps = EntityGetComponentIncludingDisabled(effect_id, "SpriteParticleEmitterComponent") or {}
	if particlecomps ~= nil then
    		for i = 1, #particlecomps do
	    		if ComponentGetValue2(particlecomps[i], "sprite_file") == "data/particles/protection_all.xml" or ComponentGetValue2(particlecomps[i], "sprite_file") == "data/particles/heal.xml" then
				EntityRemoveComponent(effect_id,particlecomps[i])
	    		end
    		end
	end
end