dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local wormComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormComponent")
local wormAiComp = EntityGetFirstComponentIncludingDisabled(entity_id,"WormAIComponent")

SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

local varcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
for k=1,#varcomp
do local v = varcomp[k]
    if ComponentGetValue2(v,"name") == "target_id" then
        varcomp = v
        break
    end
end

local target_id = ComponentGetValue2(wormAiComp,"mTargetEntityId")

local old_target_id = ComponentGetValue2( varcomp, "value_int" )

if ( target_id ~= nil ) and ( old_target_id ~= target_id ) then
	ComponentSetValue2( varcomp, "value_int", target_id )

	local targ_x, targ_y = EntityGetTransform(target_id)

	if ( targ_x ~= nil and targ_y ~= nil ) then

	local range = 200
	local s_range = 20

	if EntityHasTag( target_id, "player_unit" ) or EntityHasTag( target_id, "polymorphed_player" ) then
		local player_id = EntityGetWithTag("player_unit")[1]
		targ_x, targ_y = EntityGetTransform(player_id)

		local cam_x, cam_y, cam_w, cam_h = GameGetCameraBounds()

		range = cam_w / 2
		--print("range: " .. tostring(range))

		local a_x = pos_x - targ_x
		local a_y = pos_y - targ_y

		local distance = get_magnitude(a_x, a_y)
		local dist_x, dist_y = vec_normalize(a_x,a_y)
		local sound_x = targ_x + dist_x * s_range
		local sound_y = targ_y + dist_y * s_range
	
		if ( distance > range ) or ( GameGetFogOfWar( pos_x, pos_y ) >= 240 ) then
			--print("out of range")
			GamePlaySound("mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/animals/giant_centipede/incoming_distant", sound_x, sound_y)
		else
			--print("in range")
			GamePlaySound("mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/animals/giant_centipede/incoming", pos_x, pos_y)
		end
	else
		GamePlaySound("mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/animals/giant_centipede/incoming", pos_x, pos_y)
	end
	end
end
