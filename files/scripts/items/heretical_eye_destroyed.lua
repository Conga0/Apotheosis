local entity_id = GetUpdatedEntityID()
local parent_id = EntityGetParent(entity_id)
local player_id = EntityGetParent(parent_id)
if (player_id ~= 0 and EntityHasTag( player_id, "player_unit" )) or (player_id == 0 and parent_id ~= 0 and EntityGetName(parent_id) == "inventory_quick") then return end
--Still a very complex system
--Again.. the joke doesn't hold as well now :(
local pos_x, pos_y = EntityGetTransform(entity_id)
local good = true

if ModIsEnabled("anvil_of_destiny") then
	for i, entity in ipairs(EntityGetInRadius(pos_x, pos_y, 30)) do
		if EntityGetName(entity) == "anvil_of_destiny" then
			good = false
			dofile_once("mods/anvil_of_destiny/files/scripts/utils.lua")
			local state = get_anvil_state(entity)
			local a_x, a_y = EntityGetTransform(entity)
			if state.potions > 0 and state.potion_material == "apotheosis_meat_heretic_eye" then
				EntityLoad( "mods/Apotheosis/files/entities/items/pickups/heretical_eye_unforged.xml", a_x, a_y )
			end
		end
	end
end

--Checks the NG+ number with this variablestoragecomp to see if Heretic is in the right reality
--Without this Heretic when placed down would manifest himself in the next NG+ upon being deleted while loading the next world
--May not be needed, since as it turns out it might not really be considered deletion when transitioning while held...???
--But I'll keep it just in case... this stuff is finnicky

local ngplus = tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) + tonumber(GlobalsGetValue( "apotheosis_artifical_ngplus", "0" ))
local incarncomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[3]
local incarnation = ComponentGetValue2( incarncomp, "value_int" )
if incarnation < ngplus then
	good = false
end

if good and not GameHasFlagRun("heretic_dead_dead") then
	local rid = EntityLoad( "mods/Apotheosis/files/entities/items/pickups/heretical_eye_revive.xml", pos_x, pos_y )
	local cam_x, cam_y, cam_w, cam_h = GameGetCameraBounds()
	local radius = math.floor((cam_w / 4) * 5)
	if #EntityGetInRadiusWithTag(pos_x,pos_y,radius,"player_unit") < 1 then
		local varcomp = EntityGetFirstComponentIncludingDisabled(rid, "VariableStorageComponent")
		ComponentSetValue2( varcomp, "value_bool", true)
	end
end