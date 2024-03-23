
local entity_id = GetUpdatedEntityID()
local target = EntityGetRootEntity(entity_id)
if target == 0 then return end

local c_check = false

local children = EntityGetAllChildren(target)
if children then
    for k=1,#children
    do v = children[k]
        if EntityGetName(v) == "apotheosis_wounded" then
            c_check = true
        end
    end
end

if c_check ~= true then
    if target ~= nil then
		local comp = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "effect_curse_wither_type" )
	
		if ( comp ~= nil ) then
			local name = ComponentGetValue2( comp, "value_string" )
			
			comp = EntityGetFirstComponent( target, "DamageModelComponent" )
			
			if ( comp ~= nil ) then
				--local mult = ComponentObjectGetValue2( comp, "damage_multipliers", name )
				local refdmg = ComponentObjectGetValue2( comp, "damage_multipliers", "overeating" ) --Surely nobody will mess with this value.. right?
				--mult = mult + 1.00
				ComponentObjectSetValue2( comp, "damage_multipliers", name, math.max(1,refdmg) )
			end
		end
    end
end

EntityKill(entity_id)
