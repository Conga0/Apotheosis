
local entity_id = EntityGetRootEntity( GetUpdatedEntityID() )
local pos_x, pos_y = EntityGetTransform( entity_id )
local hitboxes = EntityGetComponent( entity_id, "HitboxComponent" ) or {}
local spritecomps = EntityGetComponent( entity_id, "SpriteComponent" ) or {}
local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
local wormcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "WormComponent")
local wormaicomp = EntityGetFirstComponentIncludingDisabled(entity_id, "WormAIComponent")
local audiocomps = EntityGetComponentIncludingDisabled(entity_id, "AudioComponent") or {}
local musiccomp = EntityGetFirstComponentIncludingDisabled(entity_id, "MusicEnergyAffectorComponent")

EntitySetComponentIsEnabled(entity_id, musiccomp, false)

for k=1,#hitboxes do
	EntitySetComponentIsEnabled(entity_id,hitboxes[k],false)
end

for k=1,#spritecomps do
	ComponentSetValue2(spritecomps[k],"rect_animation","dormant")
	-- :(
	--ComponentSetValue2(spritecomps[k],"z_index",45)
	--EntityRefreshSprite(entity_id,spritecomps[k])
end

local children = EntityGetAllChildren( entity_id ) or {}
for a,b in ipairs( children ) do
	local genomecomp = EntityGetFirstComponentIncludingDisabled(b,"GenomeDataComponent")
	if ( genomecomp ~= nil ) then
		local c_hitboxes = EntityGetComponent( b, "HitboxComponent" ) or {}
		for k=1,#c_hitboxes do
			EntitySetComponentIsEnabled(b,c_hitboxes[k],false)
		end
	end
end

for i = 1, #audiocomps do
	if ComponentGetValue2(audiocomps[i], "event_root") == "animals/worm" then
		EntitySetComponentIsEnabled(entity_id, audiocomps[i], false)
		break
	end
end

ComponentSetValue2(wormcomp,"eat_anim_wait_mult",0)
ComponentSetValue2(wormcomp,"bite_damage",0)
ComponentSetValue2(wormcomp,"acceleration",1)
ComponentSetValue2(wormcomp,"speed",0)
ComponentSetValue2(wormcomp,"max_speed",0)
ComponentSetValue2(wormaicomp,"speed",0)
ComponentSetValue2(wormaicomp,"speed_hunt",0)

EntitySetComponentsWithTagEnabled( entity_id, "enabled_by_liquid", false )

GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/frozen/create", pos_x, pos_y );

for i = 1, #luacomps do
	if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/Apotheosis/files/scripts/animals/worm_maggot_big_enable.lua" then
		EntitySetComponentIsEnabled(entity_id, luacomps[i], true)
		break
	end
end