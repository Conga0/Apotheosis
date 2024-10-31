dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 16

local targets = EntityGetInRadiusWithTag( x, y, r, "mortal" ) or {}
local gottem = false

local animalai = EntityGetFirstComponentIncludingDisabled(entity_id, "AnimalAIComponent")
local aggression = ComponentGetValue2(animalai, "mAggression") or 40

if #targets > 1 then
	for k=1, #targets
	do local v = targets[k]
		local genome = EntityGetFirstComponentIncludingDisabled(v, "GenomeDataComponent")
		if v ~= entity_id and genome ~= nil and (EntityGetHerdRelation(entity_id, v) < aggression) then
			local t_x, t_y = EntityGetTransform(v)

			EntityLoad("mods/Apotheosis/files/entities/projectiles/orb_wands_nodmg.xml",t_x,t_y)
			gottem = true
		end
	end
else
	shoot_projectile(entity_id,"mods/Apotheosis/files/entities/projectiles/orb_wands_dud.xml",x,y,0,0)
end

local limbbosscomp = EntityGetFirstComponentIncludingDisabled( entity_id, "LimbBossComponent" )
local limbstate = ComponentGetValue2(limbbosscomp, "state")
if (limbstate == 5) then
    local players = EntityGetInRadiusWithTag( x, y, 100, "player_unit" )
    if #players > 0 and gottem == true then
	ComponentSetValue2(limbbosscomp, "state", 1)
	local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
	for i = 1, #luacomps do
	    if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/Apotheosis/files/scripts/animals/flesh_wizard_wands_pursue.lua" then
		EntityRemoveComponent(entity_id, luacomps[i])
	    end
        end
    end
end

--[[
local pathfindcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PathFindingComponent" )
if (ComponentGetIsEnabled(pathfindcomp) == false) then
    local players = EntityGetInRadiusWithTag( x, y, 100, "player_unit" )
    if #players > 0 and gottem == true then
	EntitySetComponentIsEnabled( entity_id, pathfindcomp, true )
	local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
	for i = 1, #luacomps do
	    if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/Apotheosis/files/scripts/animals/flesh_wizard_wands_pursue.lua" then
		EntityRemoveComponent(entity_id, luacomps[i])
	    end
        end
    end
end
]]--