
local entity = GetUpdatedEntityID() 

local root = EntityGetRootEntity( entity ) 

local x, y = EntityGetTransform(root) 
local max_hp = 0
local hp = 0
local damagemodel = EntityGetFirstComponentIncludingDisabled( root, "DamageModelComponent" ) 


hp = ComponentGetValue2( damagemodel, "hp" ) 
max_hp = ComponentGetValue2( damagemodel, "max_hp" ) 

if max_hp ~= 0 and hp ~= 0 and (max_hp == hp) then
    local effectcomp = EntityGetComponentIncludingDisabled( entity, "GameEffectComponent" )
    for k=1,#effectcomp
    do local v = effectcomp[k]
	if ComponentGetValue2(v,"effect") == "REGENERATION" then
	    EntityRemoveComponent(entity,v)
	    local comp_id = GetUpdatedComponentID() 
	    EntityRemoveComponent(entity,comp_id)
	    break
	end
    end
end