dofile_once("data/scripts/lib/utilities.lua")

function drop()
	local entity_id    = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
	
	local comp = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "kick_count" )
	
	SetRandomSeed( GameGetFrameNum(), x + y + entity_id )
	
	if ( comp ~= nil ) then
		local count = ComponentGetValue2( comp, "value_int" )
		count = count + 1
		ComponentSetValue2( comp, "value_int", count )
		
		if ( count > 9 ) then
			EntityLoad( "data/entities/projectiles/deck/explosion.xml", x, y )
			EntityKill( entity_id )
        else
            --visual effects
            local how_many = 12
            local angle_inc = ( 2 * 3.14159 ) / how_many
            local theta = 0
            local length = 400
            local r = 40
            GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/all_seeing_eye/create", x, y );

            for i=1,how_many do
                local vel_x = math.cos( theta ) * length
                local vel_y = math.sin( theta ) * length
                theta = theta + angle_inc

                shoot_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/mass_status_infusion_freeze_effect.xml", x, y, vel_x, vel_y )
            end

            --apply matter eater effect
            local targets = EntityGetInRadiusWithTag( x, y, r, "mortal" )

            for i,v in ipairs( targets ) do
                if ( v ~= entity_id ) then
                    local c = EntityGetAllChildren( v )
                    
                    if EntityHasTag(v, "hittable") then
                        local eid = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_infusion_freeze.xml", x, y )
                        EntityAddChild( v, eid )
                    end
                end
            end
		end
	end
end

function kick()
	drop()
end