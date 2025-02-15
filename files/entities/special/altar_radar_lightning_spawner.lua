dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") or HasFlagPersistent("apotheosis_stone_heretic_purified") then

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
	if ComponentGetValue2(comp,"image_file") == "mods/Apotheosis/files/items_gfx/goldnugget_01_alt_heretic.png" and EntityGetParent(v) == 0 then
        local x,y = EntityGetTransform(v)
        EntityKill(v)
		EntityLoad("mods/Apotheosis/files/entities/items/pickups/stone_radar.xml",x,y)
        GameTriggerMusicFadeOutAndDequeueAll( 3.0 )
	if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") then
		GameTriggerMusicEvent( "music/oneshot/heaven_03", true, pos_x, pos_y )
	else
		local heretic_found = false
		local boss = EntityGetWithTag( "miniboss" ) or {}
		for bp=1,#boss do
			if EntityGetName(boss[bp]) == "$creep_apotheosis_boss_flesh_monster_name" then
				heretic_found = true
			end
		end
		if heretic_found == false then
			local cowardness = tonumber(GlobalsGetValue("HERETIC_COWARDLY"))
			if cowardness == nil then
				cowardness = 0
			end
			GlobalsSetValue("HERETIC_COWARDLY", tostring(cowardness + 1))
			EntityLoad("mods/Apotheosis/files/entities/misc/spawn_boss_flesh_monster_stone_convert.xml",pos_x,pos_y-100)
		end
		GameTriggerMusicEvent( "music/oneshot/tripping_balls_02", true, pos_x, pos_y )
		GameScreenshake( 150 )
	end
        GameAddFlagRun("apotheosis_heretalk_guiding_stone")
	end
end

else
--If heretic hasn't been killed before, then play that one gods upset sound and show a little particle effect to try and nudge people to kill him

EntityLoad("data/entities/animals/boss_flesh_monster/boss_flesh_monster_hint.xml",pos_x,pos_y-50)
GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/angered_the_gods/create", pos_x, pos_y )
GameScreenshake( 150 )
GamePrint("$log_apotheosis_stone_radar_denied")
GlobalsSetValue("HERETIC_HINT_DELAY", tostring(GameGetFrameNum()+600))
end
