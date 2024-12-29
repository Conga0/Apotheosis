local entity_id = GetUpdatedEntityID()
local hitboxes = EntityGetComponent( EntityGetRootEntity( entity_id ), "HitboxComponent" )

if( hitboxes ~= nil ) then
    for k=1,#hitboxes
    do v = hitboxes[k]
	    if (k ~= #hitboxes) then
			ComponentSetValue2( v, "damage_multiplier", 0 )
            --EntitySetComponentIsEnabled(entity_id,v,false) --This breaks how worms work?

            --Decided to do my own research (as this comment was rather vague Conga :p)
            --What it seems to be is that the hitboxes climb up the worm's body as they
            --are removed, leading the last one to be in the head's position.
            --Luckily works out for what I'm doing! :) -S
		else
			ComponentSetValue2( v, "damage_multiplier", 2 )
		end
	end
end
