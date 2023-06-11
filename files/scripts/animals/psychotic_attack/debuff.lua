
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local r = 110
local p = EntityGetInRadiusWithTag( x, y, r, "cube_fx" )

if #p >= 1 then

    EntityLoad( "mods/Apotheosis/files/entities/projectiles/orb_psychotic_nodmg.xml", x, y )
    GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/megalaser/launch", x, y )

end

EntityKill( entity_id )