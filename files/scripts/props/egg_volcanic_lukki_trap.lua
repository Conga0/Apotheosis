local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 60

SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )
	
local targets = EntityGetInRadiusWithTag( pos_x, pos_y, r, "player_unit" )
local target = targets[1]

if target ~= nil then
    if not IsInvisible(target) then
	EntityLoad( "data/entities/animals/lukki_fire_tiny.xml", pos_x, pos_y )
	if ( Random( 1, 8 ) == 8 ) then
		EntityLoad( "data/entities/animals/lukki_fire_tiny.xml", pos_x, pos_y )
	end
	EntityLoad( "mods/Apotheosis/files/entities/projectiles/fireball_explosion.xml", pos_x, pos_y )
	EntityKill( entity_id )
    end
end