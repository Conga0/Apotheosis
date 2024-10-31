dofile_once("data/scripts/lib/utilities.lua")

-- why did I put this much effort into a water immunity you may ask? ..uhhh....

local entity_id = GetUpdatedEntityID()
local target = EntityGetRootEntity(entity_id)
if target == 0 then return end

local c_check = false

local children = EntityGetAllChildren(target)
if children then
    for k=1,#children
    do v = children[k]
        if EntityGetName(v) == "apotheosis_protection_water" then
            c_check = true
        end
    end
end

if c_check ~= true then
    if target ~= nil then
	local dmgcomp = EntityGetFirstComponentIncludingDisabled(target,"DamageModelComponent")
	if dmgcomp ~= nil then
	local new_wet_damage = ComponentGetValue2(dmgcomp,"wet_status_effect_damage")

	if ( new_wet_damage == 0) then -- incase they for whatever reason gain wet damage again
    		local wetvarcomp = EntityGetComponentIncludingDisabled( target, "VariableStorageComponent" )
    		for k=1,#wetvarcomp
    		do local v = wetvarcomp[k]
			if ComponentGetValue2(v,"name") == "apotheosis_wet_immune" then
			    wetvarcomp = v
			    break
			end
 		end

		local old_wet_damage = ComponentGetValue2(wetvarcomp,"value_int")

 		ComponentSetValue2(dmgcomp,"wet_status_effect_damage",old_wet_damage)

  		EntityRemoveComponent(target, wetvarcomp)
	end

	local materials = {
            "water",
            "mud",
            "water_swamp",
            "water_salt",
            "swamp",
            "snow",
            "water_ice",
            "water_fading",
            "apotheosis_water_fading_fast",
	}

	for k=1,#materials do
            EntitySetDamageFromMaterial( target, materials[k], 0)
	end
	end
    end
end

EntityKill(entity_id)