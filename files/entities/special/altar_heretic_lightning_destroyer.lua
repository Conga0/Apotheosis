dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

--Particle gfx
EntitySetComponentsWithTagEnabled( entity_id, "enabled_in_world", true )
component_write( EntityGetFirstComponent( entity_id, "ParticleEmitterComponent"), { count_min=200, count_max=200, cosmetic_force_create=true } ) 

--Lightning audio
GamePlaySound( "data/audio/Desktop/explosion.bank", "explosions/magic_rocket_big", pos_x, pos_y )

--Screenshake
GameScreenshake( 80 )

-- this does cause the issue of heretic still talking fast if someone deloads the beam before it ends
-- ... but I'm sure no one would do that... right?
local heretic_eyes = EntityGetWithTag("apotheosis_heretic") or {}
for k=1,#heretic_eyes
do local v = heretic_eyes[k]
	local comp = EntityGetFirstComponentIncludingDisabled(v,"PhysicsImageShapeComponent")
	if ComponentGetValue2(comp,"image_file") == "mods/apotheosis/files/items_gfx/heretical_eye.png" and EntityGetParent(v) == 0 then
	local luacomps = EntityGetComponent(v, "LuaComponent") or {}
	for i = 1, #luacomps do
    	    if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/apotheosis/files/scripts/items/heretical_eye_dialogue.lua" then
    		ComponentSetValue2( luacomps[i], "execute_every_n_frame", 300 )
    	    end
    	    if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/apotheosis/files/scripts/items/heretical_eye_dialogue_quiet.lua" then
    		EntityRemoveComponent( v, luacomps[i] )
    	    end
	end
	EntityAddComponent2(v, "LuaComponent", {
	    _tags= "enabled_in_world, enabled_in_hand, enabled_in_inventory, graham_speech_quiet",
	    script_source_file="mods/apotheosis/files/scripts/items/heretical_eye_dialogue_quiet.lua",
	    execute_every_n_frame=10,
	}) 
	end
end

local heretic_eyes = EntityGetInRadiusWithTag(pos_x,pos_y,48,"apotheosis_heretic")
for k=1,#heretic_eyes
do local v = heretic_eyes[k]
	local comp = EntityGetFirstComponentIncludingDisabled(v,"PhysicsImageShapeComponent")
	if ComponentGetValue2(comp,"image_file") == "mods/apotheosis/files/items_gfx/heretical_eye.png" and EntityGetParent(v) == 0 then
        local pos_x,pos_y = EntityGetTransform(v)
        EntityLoad( "data/entities/particles/particle_explosion/main_swirly_red_giga.xml", pos_x, pos_y )
	local c = EntityGetAllChildren( v )
        if ( c ~= nil ) then
            for a,b in ipairs( c ) do
                EntityConvertToMaterial(b, "templebrick_golden_static")
            end
        end
        EntityConvertToMaterial(v, "templebrick_golden_static")
        EntityKill(v)
        GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
        GameTriggerMusicEvent( "music/oneshot/04", true, pos_x, pos_y )
        GameAddFlagRun("heretic_dead_dead")
	end
end

if heretic_eyes == nil then
EntityLoad( "data/entities/particles/particle_explosion/main_swirly_red_giga.xml", pos_x, pos_y )
end