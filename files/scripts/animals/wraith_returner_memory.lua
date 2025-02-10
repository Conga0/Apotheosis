dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local projectiles = EntityGetInRadiusWithTag( x, y, 36, "projectile" )

SetRandomSeed( x, y )
local rnd = Random( 1, #projectiles )

local projectile_id = projectiles[rnd]
local projectile_data = ""
local dmg_projectile = "0.5"

local storages = EntityGetComponent( projectile_id, "VariableStorageComponent" )

--Gets projectile filepath to return it
if ( storages ~= nil ) then
	for k=1,#storages
	do comp = storages[k]
		local name = ComponentGetValue2( comp, "name" )
		if ( name == "projectile_file" ) then
			projectile_data = ComponentGetValue2( comp, "value_string" )
			break
		end
	end
end

--Gets projectile damage, if you dmg boost it, you'll feel that same damage returned to you
local proj_comp = EntityGetFirstComponentIncludingDisabled( projectile_id, "ProjectileComponent" )

if ( proj_comp ~= nil ) then
	dmg_projectile = tonumber(ComponentGetValue2( proj_comp, "damage" ))
end

if ( string.len( projectile_data ) > 0 ) then
	storages = EntityGetComponent( entity_id, "VariableStorageComponent" )

	local damage_table = {projectile_data,dmg_projectile}

	local damagetypes = {
		"melee",
		"explosion",
		"electricity",
		"slice",
		"ice",
		"curse",
		"drill",
		"fire",
		"radioactive",
		"healing",
		"holy",
	}
	
	for k=1,#damagetypes
	do  local v = damagetypes[k]
		dmg = (ComponentObjectGetValue2( proj_comp, "damage_by_type", v ) or 0)
	
		table.insert(damage_table,dmg)
	end

	projectile_data = TableToCharSeparatedString(damage_table,",")
	
	if ( storages ~= nil ) then
		for k=1,#storages
		do comp = storages[k]
			ComponentSetValue2( comp, "value_string", projectile_data )
		end
	end
end


