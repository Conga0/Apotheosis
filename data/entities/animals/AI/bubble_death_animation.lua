dofile( "data/scripts/lib/utilities.lua" )

function check_death()
	local comp = EntityGetFirstComponent( GetUpdatedEntityID(), "DamageModelComponent" )
	if( comp ~= nil ) then
		--ComponentSetValue( comp, "hp", "-0.1" ) -- DEBUG: kill immediately
		local hp = ComponentGetValueFloat( comp, "hp" )
		if ( hp <= 0.0 ) then

			-- run death sequence
			set_main_animation( "death" )
			
			wait( 5 )
			end

			-- kill
			comp = EntityGetFirstComponent( GetUpdatedEntityID(), "DamageModelComponent" )
			if( comp ~= nil ) then
				ComponentSetValue( comp, "kill_now", "1" )
			end
			
			StatsLogPlayerKill( GetUpdatedEntityID() )
			is_dead = true
			AddFlagPersistent( "bubble_liquid_acid" )

			return
		end
	end
end