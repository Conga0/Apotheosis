--Very complex system
--Ok well the joke doesn't hit as well now since I've added more systems to it so it seems more complex...
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local acknowledge = true
local fully_acknowledge = true

local luacomps = EntityGetComponentIncludingDisabled(entity_id, "LuaComponent") or {}
for i = 1, #luacomps do
	if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/apotheosis/files/scripts/items/heretical_eye_destroyed.lua" then
		EntityRemoveComponent(entity_id, luacomps[i])
	end
end

local varcomps = EntityGetComponentIncludingDisabled(entity_id, "VariableStorageComponent") or {}
if varcomps ~= nil then
for i = 1, #varcomps do
	if ComponentGetValue2(varcomps[i], "name") == "offscreen" then
		if ComponentGetValue2( varcomps[i], "value_bool") == true then
			acknowledge = false
		end
	end
end
end

EntityKill(entity_id)

if tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 0 then
	GameAddFlagRun("apotheosis_heretalk_cynical")
end

local regrowthness = tonumber(GlobalsGetValue("HERETIC_REGROWTH"))
if regrowthness == nil then
	regrowthness = 0
end
if regrowthness > 7 and not GameHasFlagRun("apotheosis_heretalk_cynical") then
	local home_x = 24247
	local home_y = 6795
	if GameHasFlagRun("apotheosis_downunder") or GameHasFlagRun("apotheosis_everything") then
		prison_x = 24247
		prison_y = 9335
	end
	local eid = EntityLoad( "mods/Apotheosis/files/entities/items/pickups/heretical_eye.xml", home_x, home_y )
	--The reason behind all this is because otherwise the eye might end up in an unloaded chunk
	--which they would then funnily enough fall straight into the infinite Sacrilegious hole and fall forever :)
	local bodycomp = EntityGetFirstComponentIncludingDisabled(eid, "PhysicsBodyComponent")
	local shapecomp = EntityGetFirstComponentIncludingDisabled(eid, "PhysicsImageShapeComponent")
	local projectilecomp = EntityGetFirstComponentIncludingDisabled(eid, "ProjectileComponent")
	EntitySetComponentIsEnabled(eid,bodycomp,false)
	EntitySetComponentIsEnabled(eid,shapecomp,false)
	EntitySetComponentIsEnabled(eid,projectilecomp,false)
	local spritecomp = EntityGetFirstComponentIncludingDisabled(eid, "SpriteComponent")
	EntitySetComponentIsEnabled(eid,spritecomp,true)
	local incarncomp = EntityGetComponentIncludingDisabled( eid, "VariableStorageComponent" )[3]
	ComponentSetValue2( incarncomp, "value_string", "homesick")
	EntityLoad("mods/apotheosis/files/entities/buildings/ending/constellations/eye_vanish_emitter.xml", home_x, home_y)
else
	EntityLoad( "mods/Apotheosis/files/entities/items/pickups/heretical_eye.xml", pos_x, pos_y )
end
EntityLoad("mods/apotheosis/files/entities/buildings/ending/constellations/eye_vanish_emitter.xml", pos_x, pos_y)

if regrowthness > 0 then
	if GameHasFlagRun("apotheosis_heretalk_id_" .. tostring(133 + regrowthness)) == false then
		fully_acknowledge = false
	end
end

if acknowledge then
	GamePlaySound( "data/audio/Desktop/misc.bank", "misc/teleport_use", pos_x, pos_y )
	if fully_acknowledge then
		GlobalsSetValue("HERETIC_REGROWTH", tostring(regrowthness + 1))
	end
end

local regrowthness_real = tonumber(GlobalsGetValue("HERETIC_REGROWTH"))
if regrowthness_real == nil then
	regrowthness_real = 0
end
GlobalsSetValue("HERETIC_REGROWTH_REAL", tostring(regrowthness_real + 1))
