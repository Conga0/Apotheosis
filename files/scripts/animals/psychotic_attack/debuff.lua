dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

local projectile_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(projectile_id)
local radius = 96
local proj_comp = EntityGetFirstComponentIncludingDisabled(projectile_id,"ProjectileComponent")
local shooter_id = ComponentGetValue2(proj_comp,"mWhoShot")
local victim_id = EntityGetParent(projectile_id) or 0
local vsc_comp = EntityGetFirstComponentIncludingDisabled(projectile_id,"VariableStorageComponent")

local init_frame = ComponentGetValue2(vsc_comp,"value_int")

if victim_id == 0 then
	local player = EntityGetInRadiusWithTag(pos_x, pos_y, radius, "player_unit") or {}
	if #player > 0 then
		EntityAddChild(player[1],projectile_id)
		EntitySetComponentsWithTagEnabled(projectile_id,"enabled_by_script",true)
		EntitySetComponentsWithTagEnabled(projectile_id,"disabled_by_script",false)
		ComponentSetValue2(vsc_comp,"value_int",GameGetFrameNum())
	else
		EntityKill(projectile_id)
	end
elseif EntityGetIsAlive(shooter_id) == false or getDistanceFromTarget(shooter_id,victim_id) > 120 then
	EntityKill(projectile_id)
elseif GameGetFrameNum() > init_frame + 70 then
	EntityLoad( "mods/Apotheosis/files/entities/projectiles/orb_psychotic_nodmg.xml", pos_x, pos_y )
    GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/megalaser/launch", pos_x, pos_y )
	EntityKill(projectile_id)
end
