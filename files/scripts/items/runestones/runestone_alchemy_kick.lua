dofile_once("data/scripts/lib/utilities.lua")

local options = {
    "water",
    "water_ice",
    "water_salt",
    "swamp",
    "radioactive_liquid",
    "oil",
    "slime",
    "blood",
    "blood_fungi",
    "blood_worm",
    "alcohol",
    "blood_cold",
    "poison",
    "cement",
    "honey",
    "soil",
    "material_darkness",
    "material_rainbow",
    "rotten_meat",
    "wax",
    "glue",
    "coal",
    "copper",
    "silver",
    "gold",
    "diamond",
    "snow",
    "sand",
    "mud",
	"fungi",
	"rock_static",
    "magic_liquid_unstable_teleportation",
    "magic_liquid_polymorph",
    "magic_liquid_random_polymorph",
    "magic_liquid_berserk",
    "magic_liquid_charm",
    "magic_liquid_invisibility",
    "material_confusion",
    "magic_liquid_movement_faster",
    "magic_liquid_faster_levitation",
    "magic_liquid_worm_attractor",
    "magic_liquid_protection_all",
    "magic_liquid_mana_regeneration",
    "apotheosis_magic_liquid_velocium",
    "apotheosis_magic_liquid_suffocatium",
    "apotheosis_magic_liquid_pure_light",
    "apotheosis_magic_liquid_attunium",
    "apotheosis_magic_liquid_infinite_flight",
    "apotheosis_blood_worm_centipede",
    "apotheosis_insect_husk",
    "apotheosis_redstone",
}

function runestone_activate( entity_id, forcestatus )
	local status = forcestatus or 0
	local x,y = EntityGetTransform(entity_id)
	SetRandomSeed(x,y)
	local rng = Random(1,#options)
    local mat = options[rng]

    if Random(1,10000) == 1 then
        mat = "magic_liquid_hp_regeneration_unstable"
    end

	--local particlecomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ParticleEmitterComponent")
	--ComponentSetValue2(particlecomp,"emitted_material_name",options[rng])
	
	local variablestorages = EntityGetComponent( entity_id, "VariableStorageComponent" )
	if ( variablestorages ~= nil ) then
		for j,storage_id in ipairs(variablestorages) do
			local var_name = ComponentGetValue( storage_id, "name" )
			if ( var_name == "active" ) then
				if ( forcestatus == nil ) then
					status = ComponentGetValue2( storage_id, "value_int" )
					
					status = 1 - status
				end
				
				ComponentSetValue2( storage_id, "value_int", status )
				ComponentSetValue2( storage_id, "value_string", mat )
				
				if ( status == 1 ) then
					EntitySetComponentsWithTagEnabled( entity_id, "activate", true )
				else
					EntitySetComponentsWithTagEnabled( entity_id, "activate", false )
				end
			end
		end
	end
end

function kick()
	local entity_id    = GetUpdatedEntityID()
	
	runestone_activate( entity_id )
end

function throw_item()
	local entity_id    = GetUpdatedEntityID()
	
	runestone_activate( entity_id, 1 )
end

function item_pickup( entity_id )
	runestone_activate( entity_id, 0 )
end