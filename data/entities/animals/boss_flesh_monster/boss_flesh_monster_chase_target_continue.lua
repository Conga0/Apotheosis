--dofile_once("data/scripts/lib/utilities.lua")
--Unused now due to newfound LimbBossComp sorcery

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local players = EntityGetWithTag( "player_unit" )
local player_id = players[1]

local portal_away = false

local currbiome = BiomeMapGetName( pos_x, pos_y )
currbiome = tostring(currbiome)
if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster_stone") and currbiome ~= "$biome_evil_temple" and currbiome ~= "???" and currbiome ~= "$biome_orbroom" then
	--We're outside of home and got the stone, so let's not give chase so we can teleport away easier
	portal_away = true
end

if player_id ~= nil and portal_away == false then

    local player_x, player_y = EntityGetTransform(player_id)

    local limbbosscomp = EntityGetFirstComponentIncludingDisabled( entity_id, "LimbBossComponent" )
    ComponentSetValue2(limbbosscomp, "mMoveToPositionX", player_x)
    ComponentSetValue2(limbbosscomp, "mMoveToPositionY", player_y)

    --[[
    local pathfindcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PathFindingComponent" )
    EntitySetComponentIsEnabled( entity_id, pathfindcomp, false )

    local physaicomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsAIComponent" )
    ComponentSetValue2(physaicomp, "mLastPositionWhenHadPath", player_x, player_y)
    ]]--

end