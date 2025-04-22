---@diagnostic disable: lowercase-global
local biome_modifiers_rewrite_version = 1
if BIOME_MODIFIERS_REWRITE_VERSION and BIOME_MODIFIERS_REWRITE_VERSION >= biome_modifiers_rewrite_version then return end
BIOME_MODIFIERS_REWRITE_VERSION = biome_modifiers_rewrite_version

CHANCES_OF_MODIFIERS_BIOME_SPECIFIC = {
	["coalmine"] = 0.2,
	["excavationsite"] = 0.2,
}

BIOME_MODIFIERS_STATIC_MAP = {
	fungicave = { modifier = "MOIST", probability = 0.5 },
	mountain_top = "FREEZING",
	mountain_floating_island = "FREEZING",
	winter = "FREEZING",
	lavalake = "HOT",
	desert = "HOT",
	pyramid_entrance = "HOT",
	pyramid_left = "HOT",
	pyramid_top = "HOT",
	pyramid_right = "HOT",
	watercave = "MOIST",
	lake_statue = { modifier = "MOIST", probability = 0.75 },
}

---@class biome_modifiers
---@field id string
---@field ui_description string
---@field ui_decoration_file string
---@field probability number
---@field action function
---@field inject_spawns_action function?
---@field does_not_apply_to_biome string[]?
---@field requires_flag string?
---@field apply_only_to_biome string[]?

local biome_modifiers_map = {}
for _, modifier in ipairs(biome_modifiers) do
	biome_modifiers_map[modifier.id] = modifier
end

---Applies modifier
---@param biome_name string
---@param modifier biome_modifiers
function bmr_apply_modifier_from_data(biome_name, modifier)
	local biome_filename = biome_name:find("%.xml$") and biome_name or string.format("data/biome/%s.xml", biome_name)

	rnd = rnd or random_create(347893, 90734)

	modifier.action(biome_name, biome_filename)
	BiomeSetValue(biome_filename, "mModifierUIDescription", modifier.ui_description)
	BiomeSetValue(biome_filename, "mModifierUIDecorationFile", modifier.ui_decoration_file or "")
	table.insert(biomes_with_modifier, biome_name)
end

---Sets modifier if not present
---@param result {[string]:biome_modifiers}
---@param biome_name string
---@param modifier_id string
function bmr_set_modifier_if_has_none(result, biome_name, modifier_id)
	if not result[biome_name] then result[biome_name] = biome_modifiers_map[modifier_id] end
end

---Checks if modifier can be applied to the biome
---@param modifier biome_modifiers
---@param biome_name string
---@return boolean
function bmr_biome_modifier_applies_to_biome(modifier, biome_name)
	if modifier.requires_flag and not HasFlagPersistent(modifier.requires_flag) then return false end

	if modifier.does_not_apply_to_biome then
		for _, skip_biome in ipairs(modifier.does_not_apply_to_biome) do
			if skip_biome == biome_name then return false end
		end
	end

	if modifier.apply_only_to_biome then
		for _, required_biome in ipairs(modifier.apply_only_to_biome) do
			if required_biome == biome_name then return true end
		end
		return false
	end

	return true
end

---Determines if biome should have a modifier
---@param biome_name string
---@param random {x:number, y:number}
---@return boolean
function bmr_has_modifiers(biome_name, random)
	local chance_of_modifier = CHANCES_OF_MODIFIERS_BIOME_SPECIFIC[biome_name] or CHANCE_OF_MODIFIER_PER_BIOME
	return random_next(random, 0.0, 1.0) <= chance_of_modifier
end

---Determines what modifiers apply to what biomes
---@param result {[string]:biome_modifiers}
---@param rng {x:number, y:number}
function bmr_insert_random_modifiers(result, rng)
	for _, biome_names in ipairs(biomes) do
		if bmr_has_modifiers(biome_names[1], rng) then
			local modifier = pick_random_from_table_weighted(rnd, biome_modifiers) ---@cast modifier biome_modifiers
			for _, biome_name in ipairs(biome_names) do
				if bmr_biome_modifier_applies_to_biome(modifier, biome_name) then result[biome_name] = modifier end
			end
		end
	end
end

---Sets weird modifiers forcefully
---@param result {[string]:biome_modifiers}
function bmr_force_apply_modifiers(result)
	-- force custom fog of war in these biomes
	result["wandcave"] = biome_modifier_fog_of_war_clear_at_player
	result["wizardcave"] = biome_modifier_fog_of_war_clear_at_player
	result["alchemist_secret"] = biome_modifier_fog_of_war_clear_at_player
	result["winter_caves"] = biome_modifier_cosmetic_freeze
end

---Applies modifiers to static biomes if not already
---@param result {[string]:biome_modifiers}
---@param rng {x:number, y:number}
function bmr_apply_static_modifiers(result, rng)
	for biome_name, modifier in pairs(BIOME_MODIFIERS_STATIC_MAP) do
		if type(modifier) == "table" then
			if random_next(rng, 0.0, 1.0) < modifier.probability then bmr_set_modifier_if_has_none(result, biome_name, modifier.modifier) end
		else
			bmr_set_modifier_if_has_none(result, biome_name, modifier)
		end
	end
end

---returns a table mapping biome_names to active_modifiers.
---this function should be deterministic, and have no side effects.
---@return {[string]:biome_modifiers}
function bmr_get_modifier_mappings()
	local result = {}

	rnd = random_create(347893, 90734) ---@type {x:number, y:number}

	-- removes a chance for modifier in coalmines
	local deaths = tonumber(StatsGlobalGetValue("death_count")) or 0
	if deaths < 8 and not GameIsModeFullyDeterministic() then CHANCES_OF_MODIFIERS_BIOME_SPECIFIC.coalmine = -1 end

	bmr_insert_random_modifiers(result, rnd)

	bmr_force_apply_modifiers(result)

	bmr_apply_static_modifiers(result, rnd)

	return result
end

---Do modifiers stuff
function init_biome_modifiers()
	local mappings = bmr_get_modifier_mappings()

	for biome_name, modifier in pairs(mappings) do
		bmr_apply_modifier_from_data(biome_name, modifier)
	end
end
