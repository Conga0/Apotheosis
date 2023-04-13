local entity_id = GetUpdatedEntityID()
local hitboxes = EntityGetComponent( EntityGetRootEntity( entity_id ), "HitboxComponent" )

if( hitboxes ~= nil ) then
    for k=1,#hitboxes
    do v = hitboxes[k]
	    if (k ~= #hitboxes) then
			ComponentSetValue2( v, "damage_multiplier", 0 )
            --EntitySetComponentIsEnabled(entity_id,v,false) --This breaks how worms work?
		else
			ComponentSetValue2( v, "damage_multiplier", 2 )
		end
	end
end
