if tonumber(GlobalsGetValue( "BOSS_MEAT_DEAD", "0" )) == 1 then

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local vcomp = 0
local current = 1
local length = 50

local c = EntityGetComponent( entity_id, "VariableStorageComponent" )
if ( c ~= nil ) then
	for i,v in ipairs( c ) do
		local n = ComponentGetValue2( v, "name" )
		if ( n == "shooter_part" ) then
			vcomp = v
			current = ComponentGetValue2( v, "value_int" )
			break
		end
	end
end

if ( vcomp ~= 0 ) then
	if ( current <= 27 ) then
		local spritecomps = EntityGetComponent( entity_id, "SpriteComponent" ) or {}
		local ch = EntityGetAllChildren( entity_id )
		local i_ = 0 --Mmm conga you coulda come up with a lightly better naming convention? :p
		
		if ( ch ~= nil ) then
			for i,v in ipairs( ch ) do
				local comp = EntityGetFirstComponent( v, "GenomeDataComponent" )
				if ( comp ~= nil ) then
					i_ = i_ + 1
					
					if ( i_ == current ) then
						local px,py = EntityGetTransform( v )
						GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/frozen/game_effect_end", px, py )
						EntityLoad("mods/Apotheosis/files/entities/particles/worm_maggot_big_background_segment_shatter.xml",px,py)
						break
					end
				end
			end
		end

		if current < 27 then
		ComponentSetValue2(spritecomps[current],"rect_animation","enabled")
		end
		if current >= 2 then
			ComponentSetValue2(spritecomps[current-1],"rect_animation","eat")
		end
		-- :(
		--ComponentSetValue2(spritecomps[current],"z_index",(-0.5)+(0.01*current))
		--EntityRefreshSprite(entity_id,spritecomps[current])
	end
	
	current = current + 1

	ComponentSetValue2( vcomp, "value_int", current )

	if ( current > 27 ) then
		local hitboxes = EntityGetComponent( entity_id, "HitboxComponent" ) or {}
		local wormcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "WormComponent")
		local wormaicomp = EntityGetFirstComponentIncludingDisabled(entity_id, "WormAIComponent")
		local audiocomps = EntityGetComponentIncludingDisabled(entity_id, "AudioComponent") or {}
		local musiccomp = EntityGetFirstComponentIncludingDisabled(entity_id, "MusicEnergyAffectorComponent")

		EntitySetComponentIsEnabled(entity_id, musiccomp, true)

		for k=1,#hitboxes do
			EntitySetComponentIsEnabled(entity_id,hitboxes[k],true)
		end

		local children = EntityGetAllChildren( entity_id ) or {}
		for a,b in ipairs( children ) do
			local genomecomp = EntityGetFirstComponentIncludingDisabled(b,"GenomeDataComponent")
			if ( genomecomp ~= nil ) then
				local c_hitboxes = EntityGetComponentIncludingDisabled( b, "HitboxComponent" ) or {}
				for k=1,#c_hitboxes do
					EntitySetComponentIsEnabled(b,c_hitboxes[k],true)
				end
			end
		end

		for i = 1, #audiocomps do
			if ComponentGetValue2(audiocomps[i], "event_root") == "animals/worm" then
				EntitySetComponentIsEnabled(entity_id, audiocomps[i], true)
				break
			end
		end

		ComponentSetValue2(wormcomp,"eat_anim_wait_mult",0.3)
		ComponentSetValue2(wormcomp,"bite_damage",1)
		ComponentSetValue2(wormcomp,"acceleration",0.75)
		ComponentSetValue2(wormcomp,"speed",1)
		ComponentSetValue2(wormcomp,"max_speed",25)
		ComponentSetValue2(wormaicomp,"speed",6)
		ComponentSetValue2(wormaicomp,"speed_hunt",8)


		EntitySetComponentsWithTagEnabled( entity_id, "enabled_by_liquid", true )
		ComponentSetValue2( vcomp, "value_int", 1 )
		EntityRemoveComponent( entity_id, GetUpdatedComponentID() )
	end
end
end