dofile_once("data/scripts/lib/utilities.lua")

local eid    = GetUpdatedEntityID()
local x, y = EntityGetTransform( eid )

--Make this a function so other mods could append I guess?
--I dunno, if you're a modder and want to them let me know I guess and I could do it.

local styles =
{
	{
		name = "darkness",
		setup =
		function( entity_id )
			local animalais = EntityGetComponent( entity_id, "AnimalAIComponent" )
			local damagemodels = EntityGetComponent( entity_id, "DamageModelComponent" )
			local sprites = EntityGetComponent( entity_id, "SpriteComponent" )
			
			if ( animalais ~= nil ) then
				for i,v in ipairs( animalais ) do
					ComponentSetValue2( v, "attack_ranged_entity_file", "data/entities/projectiles/enlightened_laser_dark_wand.xml" )
				end
			end
			
			if ( damagemodels ~= nil ) then
				for i,v in ipairs( damagemodels ) do
					ComponentObjectSetValue2( v, "damage_multipliers", "explosion", 0.5 )
				end
			end
			
			if ( sprites ~= nil ) and ( sprites[2] ~= nil ) then
				local v = sprites[2]
				
				ComponentSetValue2( v, "image_file", "data/particles/enlightened_alchemist_halo_dark.xml" )
			end
		end,
	},
	{
		name = "electricity",
		setup =
		function( entity_id )
			local animalais = EntityGetComponent( entity_id, "AnimalAIComponent" )
			local damagemodels = EntityGetComponent( entity_id, "DamageModelComponent" )
			local sprites = EntityGetComponent( entity_id, "SpriteComponent" )
			
			if ( animalais ~= nil ) then
				for i,v in ipairs( animalais ) do
					ComponentSetValue2( v, "attack_ranged_entity_file", "data/entities/projectiles/enlightened_laser_elec_wand.xml" )
				end
			end
			
			if ( damagemodels ~= nil ) then
				for i,v in ipairs( damagemodels ) do
					ComponentObjectSetValue2( v, "damage_multipliers", "electricity", 0.0 )
				end
			end
			
			if ( sprites ~= nil ) and ( sprites[2] ~= nil ) then
				local v = sprites[2]
				
				ComponentSetValue2( v, "image_file", "data/particles/enlightened_alchemist_halo_elec.xml" )
			end
		end,
	},
	{
		name = "light",
		setup =
		function( entity_id )
			local animalais = EntityGetComponent( entity_id, "AnimalAIComponent" )
			local damagemodels = EntityGetComponent( entity_id, "DamageModelComponent" )
			local sprites = EntityGetComponent( entity_id, "SpriteComponent" )
			
			if ( animalais ~= nil ) then
				for i,v in ipairs( animalais ) do
					ComponentSetValue2( v, "attack_ranged_entity_file", "data/entities/projectiles/enlightened_laser_light_wand.xml" )
				end
			end
			
			if ( damagemodels ~= nil ) then
				for i,v in ipairs( damagemodels ) do
					ComponentObjectSetValue2( v, "damage_multipliers", "ice", 0.2 )
				end
			end
			
			if ( sprites ~= nil ) and ( sprites[2] ~= nil ) then
				local v = sprites[2]
				
				ComponentSetValue2( v, "image_file", "data/particles/enlightened_alchemist_halo_light.xml" )
			end
		end,
	},
	{
		name = "fire",
		setup =
		function( entity_id )
			local animalais = EntityGetComponent( entity_id, "AnimalAIComponent" )
			local damagemodels = EntityGetComponent( entity_id, "DamageModelComponent" )
			local sprites = EntityGetComponent( entity_id, "SpriteComponent" )
			
			if ( animalais ~= nil ) then
				for i,v in ipairs( animalais ) do
					ComponentSetValue2( v, "attack_ranged_entity_file", "data/entities/projectiles/enlightened_laser_fire_wand.xml" )
				end
			end
			
			if ( damagemodels ~= nil ) then
				for i,v in ipairs( damagemodels ) do
					ComponentSetValue2( v, "fire_probability_of_ignition", 0 )
					ComponentObjectSetValue2( v, "damage_multipliers", "fire", 0.0 )
				end
			end
			
			if ( sprites ~= nil ) and ( sprites[2] ~= nil ) then
				local v = sprites[2]
				
				ComponentSetValue2( v, "image_file", "data/particles/enlightened_alchemist_halo_fire.xml" )
			end
		end,
	},
	{
		name = "apotheosis_healer",
		setup =
		function( entity_id )
			local animalais = EntityGetComponent( entity_id, "AnimalAIComponent" )
			local damagemodels = EntityGetComponent( entity_id, "DamageModelComponent" )
			local sprites = EntityGetComponent( entity_id, "SpriteComponent" )
			
			if ( animalais ~= nil ) then
				for i,v in ipairs( animalais ) do
					ComponentSetValue2( v, "attack_ranged_entity_file", "mods/Apotheosis/files/entities/projectiles/enlightened_heal_test_wand.xml" )
					ComponentSetValue2( v, "tries_to_ranged_attack_friends", true )
					ComponentSetValue2( v, "attack_if_damaged_probability", 0 )
					ComponentSetValue2( v, "escape_if_damaged_probability", 100 )
				end
			end
			
			if ( damagemodels ~= nil ) then
				for i,v in ipairs( damagemodels ) do
					ComponentObjectSetValue2( v, "damage_multipliers", "projectile", 0.5 )
				end
			end
			
			if ( sprites ~= nil ) and ( sprites[2] ~= nil ) then
				local v = sprites[2]
				
				ComponentSetValue2( v, "image_file", "mods/Apotheosis/files/particles/enlightened_alchemist_halo_heal.xml" )
			end
		end,
	},
	{
		name = "apotheosis_ice",
		setup =
		function( entity_id )
			local animalais = EntityGetComponent( entity_id, "AnimalAIComponent" )
			local damagemodels = EntityGetComponent( entity_id, "DamageModelComponent" )
			local sprites = EntityGetComponent( entity_id, "SpriteComponent" )
			
			if ( animalais ~= nil ) then
				for i,v in ipairs( animalais ) do
					ComponentSetValue2( v, "attack_ranged_entity_file", "mods/Apotheosis/files/entities/projectiles/enlightened_laser_ice_wand.xml" )
				end
			end
			
			if ( damagemodels ~= nil ) then
				for i,v in ipairs( damagemodels ) do
					ComponentObjectSetValue2( v, "damage_multipliers", "ice", 0.0 )
					ComponentSetValue2( v, "materials_damage", false )
				end
			end
			
			if ( sprites ~= nil ) and ( sprites[2] ~= nil ) then
				local v = sprites[2]
				
				ComponentSetValue2( v, "image_file", "mods/Apotheosis/files/particles/enlightened_alchemist_halo_ice.xml" )
			end
		end,
	},
}

SetRandomSeed( x * eid, y * eid )

local rnd = Random( 1, #styles )
local style = styles[rnd]

style.setup( eid )