--dofile_once("data/scripts/lib/utilities.lua")
--This script handles Heretic stopping his pathfinding to then go straight for the stone and grab it

function get_magnitude( x, y )
	local result = math.sqrt( x ^ 2 + y ^ 2 )
	return result
end

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local stone_id = nil
local purified = false
local heretic_stones = EntityGetInRadiusWithTag(pos_x,pos_y,145000,"poopstone") or {}
for k=1,#heretic_stones
do local v = heretic_stones[k]
	local comp = EntityGetFirstComponentIncludingDisabled(v,"PhysicsImageShapeComponent")
	if ComponentGetValue2(comp,"image_file") == "mods/Apotheosis/files/items_gfx/goldnugget_01_alt_heretic.png" and EntityGetParent(v) == 0 then
		stone_id = v
		break
	elseif ComponentGetValue2(comp,"image_file") == "mods/Apotheosis/files/items_gfx/goldnugget_01_alt_radar.png" and EntityGetParent(v) == 0 then
		stone_id = v
		purified = true
		break
	end
end

local stone_bad = false

if stone_id ~= nil then
local parent = EntityGetParent(stone_id)
if parent <= 0 then

    local stone_x, stone_y = EntityGetTransform(stone_id)

    --Doesn't work because the entity requires a clear path to actually attempt moving towards it
    --[[
    local limbbosscomp = EntityGetFirstComponentIncludingDisabled( entity_id, "LimbBossComponent" )
    ComponentSetValue2(limbbosscomp, "state", 4)
    ComponentSetValue2(limbbosscomp, "mMoveToPositionX", stone_x)
    ComponentSetValue2(limbbosscomp, "mMoveToPositionY", stone_y)
    ]]--

    local pathfindcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PathFindingComponent" )
    EntitySetComponentIsEnabled( entity_id, pathfindcomp, false )

    local physaicomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsAIComponent" )
    ComponentSetValue2(physaicomp, "mLastPositionWhenHadPath", stone_x, stone_y)

    local varcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[1]
    ComponentSetValue2( varcomp, "value_bool", true)

    local dis_x = stone_x - pos_x
    local dis_y = stone_y - pos_y

    local distance = get_magnitude(dis_x, dis_y)

    --No longer needed thanks to now being handled by material tags
    --[[
    if distance <= 100 then
	--change Heretic's celleater so it doesn't chew up the corrupt stone
	local cellcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "CellEaterComponent" )
	if purified == true then
	    ComponentSetValue2(cellcomp, "ignored_material", CellFactory_GetType("apotheosis_gem_box2d_green_hard"))
	else
	    ComponentSetValue2(cellcomp, "ignored_material", CellFactory_GetType("apotheosis_gem_box2d_red_hard"))
	end
    end
    ]]--

    if distance <= 40 then
	--Heretic has successfully eaten the corrupt stone, now Heretic will hoodini away shortly after
	GameAddFlagRun( "apotheosis_miniboss_boss_flesh_monster_stone" )
	local luacomps = EntityGetComponentIncludingDisabled(stone_id, "LuaComponent") or {}
	for i = 1, #luacomps do
            if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/Apotheosis/files/scripts/items/stone_heretic_destroyed.lua" or ComponentGetValue2(luacomps[i], "script_source_file") == "mods/Apotheosis/files/scripts/items/radar_stone_destroyed.lua" then
                    EntityRemoveComponent( stone_id, luacomps[i] )
            end
	end
	EntityKill(stone_id)
	EntitySetComponentsWithTagEnabled(entity_id,"angry_ghost_cooldown",true)
	EntitySetComponentIsEnabled( entity_id, pathfindcomp, true )
	local cellcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "CellEaterComponent" )
	ComponentSetValue2(cellcomp, "ignored_material", CellFactory_GetType("rock_box2d_nohit_hard"))
	GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/pick_item_generic/create", stone_x, stone_y )
	--Add a cooler effect here later
	--And so I did :)
	EntityLoad("data/entities/animals/boss_flesh_monster/particles/stone_steal.xml", stone_x, stone_y )
	GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/stone_heretic/taken", stone_x, stone_y )
    end

else
    stone_bad = true
end
else
    stone_bad = true
end

if stone_bad == true then
    --[[
    local limbbosscomp = EntityGetFirstComponentIncludingDisabled( entity_id, "LimbBossComponent" )
    local limbstate = ComponentGetValue2(limbbosscomp, "state")
    if (limbstate == 4) then
	ComponentSetValue2(limbbosscomp, "state", 1)
	local cellcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "CellEaterComponent" )
	ComponentSetValue2(cellcomp, "ignored_material", CellFactory_GetType("rock_box2d_nohit_hard"))
    end
    ]]--
    local varcomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[1]
    if (ComponentGetValue2( varcomp, "value_bool" ) == true) then
	ComponentSetValue2( varcomp, "value_bool", false)
	local pathfindcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PathFindingComponent" )
	EntitySetComponentIsEnabled( entity_id, pathfindcomp, true )
	local cellcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "CellEaterComponent" )
	ComponentSetValue2(cellcomp, "ignored_material", CellFactory_GetType("rock_box2d_nohit_hard"))
    end
end

if GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster_stone") then
	--We already got the stone, time to turn on hoodini mode
	EntitySetComponentsWithTagEnabled(entity_id,"angry_ghost_cooldown",true)
	--[[
	local limbbosscomp = EntityGetFirstComponentIncludingDisabled( entity_id, "LimbBossComponent" )
	local limbstate = ComponentGetValue2(limbbosscomp, "state")
	if (limbstate == 4) then
		ComponentSetValue2(limbbosscomp, "state", 1)
		local cellcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "CellEaterComponent" )
		ComponentSetValue2(cellcomp, "ignored_material", CellFactory_GetType("rock_box2d_nohit_hard"))
	end
	]]--
	local pathfindcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PathFindingComponent" )
	if (ComponentGetIsEnabled(pathfindcomp) == false) then
		EntitySetComponentIsEnabled( entity_id, pathfindcomp, true )
		local cellcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "CellEaterComponent" )
		ComponentSetValue2(cellcomp, "ignored_material", CellFactory_GetType("rock_box2d_nohit_hard"))
	end
	local comp_id = GetUpdatedComponentID()
	EntityRemoveComponent(entity_id,comp_id)
end