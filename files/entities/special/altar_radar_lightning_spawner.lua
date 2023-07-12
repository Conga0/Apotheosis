dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

--Particle gfx
EntitySetComponentsWithTagEnabled( entity_id, "enabled_in_world", true )
component_write( EntityGetFirstComponent( entity_id, "ParticleEmitterComponent"), { count_min=200, count_max=200, cosmetic_force_create=true } ) 
EntityLoad( "data/entities/particles/particle_explosion/main_blue.xml", pos_x, pos_y )

--Lightning audio
GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/bullet_lightning/create", pos_x, pos_y )

--Screenshake
GameScreenshake( 40 )

local heretic_stones = EntityGetInRadiusWithTag(pos_x,pos_y,48,"poopstone")
for k=1,#heretic_stones
do local v = heretic_stones[k]
	local comp = EntityGetFirstComponentIncludingDisabled(v,"PhysicsImageShapeComponent")
	if ComponentGetValue2(comp,"image_file") == "mods/apotheosis/files/items_gfx/goldnugget_01_alt_heretic.png" and EntityGetParent(v) == 0 then
        local x,y = EntityGetTransform(v)
        EntityKill(v)
		EntityLoad("mods/apotheosis/files/entities/items/pickups/stone_radar.xml",x,y)
        GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
        GameTriggerMusicEvent( "music/oneshot/heaven_03", true, pos_x, pos_y )
	end
end
