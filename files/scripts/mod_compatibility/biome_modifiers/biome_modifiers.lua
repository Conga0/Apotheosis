local apotheosis_biomes = {
	--Mid-Game Biomes
	{ "sandcave" },
	{ "pyramid", "pyramid_hallway" },
	{ "meat" },

	--Endgame Biomes
	{ "custom/slime_hell" },
}

local biomes_count = #biomes
for i = 1, #apotheosis_biomes do
	biomes[biomes_count + i] = apotheosis_biomes[i]
end

local modify_modifiers = {
	["SPOOKY"] = {
		inject_spawns_action = function()
			inject_spawn(g_props, 1.0, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/buildings/biome_modifiers/tiny_ghost_spawner.xml",
			})
			inject_spawn(g_props2, 1.0, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/buildings/biome_modifiers/tiny_ghost_spawner.xml",
			})
			inject_spawn(g_lamp, 0.2, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/buildings/biome_modifiers/tiny_ghost_spawner.xml",
			})
			inject_spawn(g_props, 1.0, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/props/furniture_tombstone_01.xml",
			})
			inject_spawn(g_props, 1.0, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/props/furniture_tombstone_02.xml",
			})
			inject_spawn(g_props, 1.0, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/props/furniture_tombstone_03.xml",
			})
			inject_spawn(g_small_enemies, 0.2, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/animals/confusespirit.xml",
			})
			inject_spawn(g_small_enemies, 0.1, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/animals/berserkspirit.xml",
			})
			inject_spawn(g_small_enemies, 0.05, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/animals/weakspirit.xml",
				ngpluslevel = 1,
			})
			inject_spawn(g_small_enemies, 0.2, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/animals/slimespirit.xml",
			})
			inject_spawn(g_small_enemies, 0.02, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/animals/spirit_healing.xml",
			})
		end,
	},
}

for _, biome_modifier in ipairs(biome_modifiers) do
	if modify_modifiers[biome_modifier.id] then
		for k, v in pairs(modify_modifiers[biome_modifier.id]) do
			biome_modifier[k] = v
		end
	end
end

local new_modifiers = {
	{
		id = "SMOKE_DENSE",
		ui_description = "$biomemod_apotheosis_smoke_dense",
		ui_decoration_file = "data/ui_gfx/decorations_biome_modifier/fog_of_war.png",
		probability = 1.0,
		does_not_apply_to_biome = { "mountain_hall", "rainforest", "rainforest_open", "snowcastle", "snowcave" },
		action = function(biome_name, biome_filename) end,
		inject_spawns_action = function()
			inject_spawn(g_small_enemies, 0.2, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/buildings/smoke_dense_creator_apotheosis.xml",
			})
			inject_spawn(g_props, 0.5, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/buildings/smoke_dense_creator_apotheosis.xml",
			})
			inject_spawn(g_props2, 0.5, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/buildings/smoke_dense_creator_apotheosis.xml",
			})
		end,
	},
	{
		id = "ESOTERIC_PRESENCE",
		ui_description = "$biomemod_esoteric_presence",
		ui_decoration_file = "mods/Apotheosis/files/ui_gfx/decorations/esoteric_presence.png",
		probability = 0.3,
		does_not_apply_to_biome = { "mountain_hall", "coalmine", "coalmine_alt" },
		action = function(biome_name, biome_filename) end,
		inject_spawns_action = function()
			inject_spawn(g_small_enemies, 0.5, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/buildings/esoteric_being_asleep.xml",
			})
		end,
	},
	{
		id = "NECROMANCY",
		ui_description = "$biomemod_necromancy",
		ui_decoration_file = "mods/Apotheosis/files/ui_gfx/decorations/necromancy.png",
		probability = 0.3,
		does_not_apply_to_biome = { "mountain_hall", "coalmine", "coalmine_alt" },
		action = function(biome_name, biome_filename) end,
		inject_spawns_action = function()
			inject_spawn(g_small_enemies, 1.25, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "mods/Apotheosis/files/entities/buildings/biomemod_necromancy.xml",
			})
		end,
	},
	{
		id = "ALCHEMIC",
		ui_description = "$biomemod_alchemic",
		ui_decoration_file = "mods/Apotheosis/files/ui_gfx/decorations/alchemic.png",
		probability = 0.5,
		does_not_apply_to_biome = { "mountain_hall", "coalmine", "snowcastle" },
		action = function(biome_name, biome_filename) end,
		inject_spawns_action = function()
			inject_spawn(g_small_enemies, 0.5, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "mods/Apotheosis/files/entities/buildings/pylon_escium_lowhp.xml",
			})
			inject_spawn(g_small_enemies, 0.10, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "mods/Apotheosis/files/entities/buildings/mist_trap_large_attunium.xml",
			})
			inject_spawn(g_small_enemies, 0.10, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "mods/Apotheosis/files/entities/buildings/mist_trap_large_pure_light.xml",
			})
			inject_spawn(g_small_enemies, 0.10, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "mods/Apotheosis/files/entities/buildings/mist_trap_large_berserkium.xml",
			})
			inject_spawn(g_small_enemies, 0.10, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "mods/Apotheosis/files/entities/buildings/mist_trap_large_pheromone.xml",
			})
			inject_spawn(g_small_enemies, 0.10, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/animals/bubbles/slime/bubble_liquid.xml",
			})
			inject_spawn(g_small_enemies, 0.10, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/animals/bubbles/soarium/bubble_liquid.xml",
			})
			inject_spawn(g_small_enemies, 0.01, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/animals/bubbles/ambrosia/bubble_liquid.xml",
			})
		end,
	},
	{
		id = "SPIDERS",
		ui_description = "$biomemod_spiders",
		ui_decoration_file = "mods/Apotheosis/files/ui_gfx/decorations/spiders.png",
		probability = 0.5,
		does_not_apply_to_biome = { "mountain_hall", "snowcave", "snowcastle" },
		action = function(biome_name, biome_filename) end,
		inject_spawns_action = function()
			inject_spawn(g_small_enemies, 1.00, {
				prob = 0,
				min_count = 6,
				max_count = 8,
				offset_y = 0,
				entity = "data/entities/animals/longleg.xml",
			})
			inject_spawn(g_small_enemies, 0.50, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/buildings/hamis_nest.xml",
			})
			inject_spawn(g_small_enemies, 0.05, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/animals/lukki/lukki.xml",
			})
			inject_spawn(g_small_enemies, 0.05, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "data/entities/animals/lukki/lukki_longleg.xml",
			})
			inject_spawn(g_props, 0.8, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "mods/Apotheosis/files/entities/particle_generators/cobweb_01.xml",
			})
			inject_spawn(g_props, 0.8, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "mods/Apotheosis/files/entities/particle_generators/cobweb_02.xml",
			})
			inject_spawn(g_props, 0.8, {
				prob = 0,
				min_count = 1,
				max_count = 1,
				offset_y = 0,
				entity = "mods/Apotheosis/files/entities/particle_generators/cobweb_03.xml",
			})
		end,
	},
	--[[
	--Requires ending 3
	--Replace all biome liquid with blood, add way to be afflicted by Lively Hex?
	--Behave similarly to the unused corruption modifier, but with flesh?
	{
		id = "HERETICAL",
		ui_description="$biomemod_heretical",
		ui_decoration_file="mods/Apotheosis/files/ui_gfx/decorations/3piece_heretical.png",
		probability=0.2,
		requires_flag = "apotheosis_card_unlocked_ending_apotheosis_03",
		does_not_apply_to_biome={"mountain_hall","coalmine","excavationsite"},
		action = function( biome_name, biome_filename )	end,
		inject_spawns_action = function()
			inject_spawn( g_small_enemies, 0.05, {
				prob   		= 0,
				min_count	= 1,
				max_count	= 1,
				offset_y 	= 0,    
				entity 	=  "mods/Apotheosis/files/entities/animals/planes/devourer_magic.xml",
			})
		end,
	},
	]]
	--
	--[[-- dry - fire spreads faster than usually, fire demons spawn
	-- bouncy - projectiles and physics bodies bounce from surfaces
	-- corrupted - corruption grows everywhere. corruption = some sort of easily destructible static material
	-- toxic - pools of toxic sludge, toxic rock everywhere
	-- vulcanous - lava, lava rock everywhere
	-- haunted - ghost crystals spawn
	-- rat infested - rats spawn everywhere
	-- worm infested - more worm spawn than usually
	-- alchemic - humanoid enemies drop random potions on death
	-- peaceful - enemies don't attack unless projectile spells are used
	-- portal upwards - a box can be found that spawns a portal when kicked
	-- portal downwards - a box can be found that spawns a portal when kicked
	-- more based on various perks?
	]]
	--
}

local modifiers_count = #biome_modifiers
for i = 1, #new_modifiers do
	biome_modifiers[modifiers_count + i] = new_modifiers[i]
end

-- magmatic - frozen materials melt

biome_modifier_magmatic = {
	id = "MAGMATIC",
	ui_description = "$biomemod_magmatic",
	ui_decoration_file = "mods/Apotheosis/files/ui_gfx/decorations/magmatic.png",
	probability = 0.0,
	does_not_apply_to_biome = { "mountain_hall" }, --does_not_apply_to_biome={"snowcave","snowcastle",},
	action = function(biome_name, biome_filename)
		BiomeObjectSetValue(biome_filename, "modifiers", "reaction_unfreeze_chance", 40)
		BiomeVegetationSetValue(biome_filename, "grass", "tree_material", "grass_dry")
		BiomeVegetationSetValue(biome_filename, "fungus_loose", "tree_probability", 0.0) -- no mushrooms in dry biome
		BiomeSetValue(biome_filename, "color_grading_r", 1.00)
		BiomeSetValue(biome_filename, "color_grading_g", 0.90)
		BiomeSetValue(biome_filename, "color_grading_b", 0.8)
		BiomeSetValue(biome_filename, "color_grading_grayscale", 0.075)
		BiomeObjectSetValue(biome_filename, "modifiers", "dust_amount", 0.75)
	end,
}

biome_modifier_esoteric_den = {
	id = "ESOTERIC_DEN",
	ui_description = "$biomemod_esoteric_den",
	ui_decoration_file = "mods/Apotheosis/files/ui_gfx/decorations/esoteric_presence.png",
	probability = 0.0,
	does_not_apply_to_biome = { "mountain_hall" }, --does_not_apply_to_biome={"snowcave","snowcastle",},
	action = function(biome_name, biome_filename)
		BiomeObjectSetValue(biome_filename, "modifiers", "reaction_unfreeze_chance", 40)
		BiomeVegetationSetValue(biome_filename, "grass", "tree_material", "grass_dry")
		BiomeVegetationSetValue(biome_filename, "fungus_loose", "tree_probability", 0.0) -- no mushrooms in dry biome
		BiomeSetValue(biome_filename, "color_grading_r", 0.10)
		BiomeSetValue(biome_filename, "color_grading_g", 0.10)
		BiomeSetValue(biome_filename, "color_grading_b", 0.10)
		BiomeSetValue(biome_filename, "color_grading_grayscale", 0.150)
		BiomeObjectSetValue(biome_filename, "modifiers", "dust_amount", 0.85)
	end,
}

biome_modifier_plane_yggdrasil = {
	id = "PLANE_YGGDRASIL",
	ui_description = "$biomemod_plane_yggdrasil",
	ui_decoration_file = "mods/Apotheosis/files/ui_gfx/decorations/plane_yggdrasil.png",
	probability = 0.0,
	does_not_apply_to_biome = { "mountain_hall" }, --does_not_apply_to_biome={"snowcave","snowcastle",},
	action = function(biome_name, biome_filename)
		BiomeSetValue(biome_filename, "color_grading_r", 0.70)
		BiomeSetValue(biome_filename, "color_grading_g", 1.00)
		BiomeSetValue(biome_filename, "color_grading_b", 0.90)
		BiomeSetValue(biome_filename, "color_grading_grayscale", 0.050)
		BiomeObjectSetValue(biome_filename, "modifiers", "dust_amount", 0.60)
	end,
}

biome_modifier_plane_magic = {
	id = "PLANE_MAGIC",
	ui_description = "$biomemod_plane_magic",
	ui_decoration_file = "mods/Apotheosis/files/ui_gfx/decorations/plane_magic.png",
	probability = 0.0,
	does_not_apply_to_biome = { "mountain_hall" }, --does_not_apply_to_biome={"snowcave","snowcastle",},
	action = function(biome_name, biome_filename)
		BiomeSetValue(biome_filename, "color_grading_r", 1.00)
		BiomeSetValue(biome_filename, "color_grading_g", 0.60)
		BiomeSetValue(biome_filename, "color_grading_b", 1.00)
		BiomeSetValue(biome_filename, "color_grading_grayscale", 0.050)
		BiomeObjectSetValue(biome_filename, "modifiers", "dust_amount", 0.60)
	end,
}

biome_modifier_plane_technology = {
	id = "PLANE_MECHANICAL",
	ui_description = "$biomemod_plane_mechanical",
	ui_decoration_file = "mods/Apotheosis/files/ui_gfx/decorations/plane_mechanical.png",
	probability = 0.0,
	does_not_apply_to_biome = { "mountain_hall" }, --does_not_apply_to_biome={"snowcave","snowcastle",},
	action = function(biome_name, biome_filename)
		BiomeSetValue(biome_filename, "color_grading_r", 1.00)
		BiomeSetValue(biome_filename, "color_grading_g", 0.80)
		BiomeSetValue(biome_filename, "color_grading_b", 0.80)
		BiomeSetValue(biome_filename, "color_grading_grayscale", 0.050)
		BiomeObjectSetValue(biome_filename, "modifiers", "dust_amount", 0.60)
	end,
}

biome_modifier_devtest = {
	id = "DEVTEST",
	ui_description = "$biomemod_necromancy",
	ui_decoration_file = "mods/Apotheosis/files/ui_gfx/decorations/necromancy.png",
	probability = 0.2,
	does_not_apply_to_biome = { "mountain_hall", "coalmine", "coalmine_alt" },
	action = function(biome_name, biome_filename) end,
	inject_spawns_action = function()
		inject_spawn(g_small_enemies, 0.25, {
			prob = 0,
			min_count = 1,
			max_count = 1,
			offset_y = 0,
			entity = "mods/Apotheosis/files/entities/buildings/biomemod_necromancy.xml",
		})
	end,
}

local bmr_force_apply_modifiers_old = bmr_force_apply_modifiers
function bmr_force_apply_modifiers(result)
	-- force custom fog of war in these biomes
	result["custom/evil_temple"] = biome_modifier_fog_of_war_clear_at_player
	result["custom/lava_excavation"] = biome_modifier_magmatic
	result["custom/esoteric_den"] = biome_modifier_esoteric_den
	result["custom/plane_yggdrasil"] = biome_modifier_plane_yggdrasil
	result["custom/plane_portal_enter_nature"] = biome_modifier_plane_yggdrasil
	result["custom/plane_magic"] = biome_modifier_plane_magic
	result["custom/plane_portal_enter_magic"] = biome_modifier_plane_magic
	result["custom/plane_mechanical"] = biome_modifier_plane_technology
	result["custom/plane_portal_enter_technology"] = biome_modifier_plane_technology
	bmr_force_apply_modifiers_old(result)
end
