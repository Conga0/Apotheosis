--dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

    local portal_found = false
    local portal_id = nil
    local p_x, p_y = nil
    local boss = EntityGetInRadiusWithTag( pos_x, pos_y, 60, "miniboss" ) or {}
    for bp=1,#boss do
	if EntityGetName(boss[bp]) == "heretic_portal" then
	    portal_found = true
	    portal_id = boss[bp]
	end
    end

    if portal_found == false then
	portal_id = EntityLoad("data/entities/animals/boss_flesh_monster/boss_flesh_monster_portal_ambush.xml", pos_x, pos_y)
	local incarncomp = EntityGetFirstComponentIncludingDisabled( portal_id, "VariableStorageComponent" ) or nil
	local varcomps = EntityGetComponentIncludingDisabled(portal_id, "VariableStorageComponent") or {}
	for i = 1, #varcomps do
	    if ComponentGetValue2(varcomps[i], "name") == "incarnation_value" then
		incarncomp = varcomps[i]
		break
	    end
	end
	if tonumber(GlobalsGetValue("HERETIC_COWARDLY")) ~= nil then
	ComponentSetValue2( incarncomp, "value_int", tonumber(GlobalsGetValue("HERETIC_COWARDLY")))
	end
    end

    p_x, p_y = EntityGetTransform(portal_id)

    local pathfindcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PathFindingComponent" )
    EntitySetComponentIsEnabled( entity_id, pathfindcomp, false )

    local physaicomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PhysicsAIComponent" )
    ComponentSetValue2(physaicomp, "mLastPositionWhenHadPath", p_x, p_y)