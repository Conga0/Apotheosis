dofile_once("data/scripts/lib/utilities.lua")

function spawn_ghost()
	local entity_id = GetUpdatedEntityID()
	local x,y = EntityGetTransform( entity_id )
	
	SetRandomSeed( GameGetFrameNum(), x + entity_id )
	
	local raycasts = 4
	local dir = ( math.pi * 2.0 ) / raycasts
	local length = 8

	local opt = "mods/Apotheosis/files/entities/projectiles/robot_stand_portal_prefx.xml"
	
	local max_radius = 512
	local p = EntityGetInRadiusWithTag( x, y, max_radius, "player_unit" )
    local times = Random(3,5)
	
	if ( #p > 0 ) then
        repeat
            SetRandomSeed( GameGetFrameNum() + times, entity_id + times )
            local t = p[1]
            local px, py = EntityGetTransform( t )
            
            local dx = px + Random( -50, 50 )
            local dy = py + Random( -50, 50 )
            
            local dist = math.abs( py - dy ) + math.abs( px - dx )
            local limit = 0
            local wall = true
            
            while ( ( dist < 100 ) or wall ) and ( limit < 20 ) do
                dx = px + Random( -50, 50 )
                dy = py + Random( -50, 50 )
                dist = math.abs( py - dy ) + math.abs( px - dx )
                limit = limit + 1
                
                for j=0,raycasts-1 do
                    local ex = dx + math.cos( j * dir ) * length
                    local ey = dy - math.sin( j * dir ) * length
                    
                    wall = RaytraceSurfaces( dx, dy, ex, ey )
                    
                    if wall then
                        break
                    end
                end
            end

            times = times - 1

            EntityLoad( opt, dx, dy )
        until (times <= 0)
	end
end

spawn_ghost()
