
local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local pos_x, pos_y = EntityGetTransform( root_id )

--Checks to see if Heretic is meant to be always loaded
local allseeing = EntityGetFirstComponentIncludingDisabled( root_id, "StreamingKeepAliveComponent" )

-- kill self
-- We use an EntityKill here to avoid adding a kill count to the progress log
EntityKill(root_id)

EntityLoad( "data/entities/animals/boss_flesh_monster/boss_flesh_monster_explosion.xml", pos_x, pos_y )
local eid = EntityLoad( "data/entities/animals/boss_flesh_monster/phase3/boss_flesh_monster.xml", pos_x, pos_y )
GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/uncaged/create", pos_x, pos_y )

if not GameHasFlagRun("apotheosis_flesh_boss_armor") then
    GameAddFlagRun("apotheosis_flesh_boss_armor")
    GlobalsSetValue("HERETIC_HEALTH", tostring(468))
end

--Spawns flesh phase with the loader comp so he doesn't stop existing if you leave him after he dies
if allseeing ~= nil then
    EntityAddComponent(eid, "StreamingKeepAliveComponent" ) 
end

local incarncomp = EntityGetComponentIncludingDisabled( eid, "VariableStorageComponent" )[2]
local cowardness = tonumber(GlobalsGetValue("HERETIC_COWARDLY"))
if cowardness ~= nil then
ComponentSetValue2( incarncomp, "value_int", cowardness)
end

local old_armorcomp = EntityGetFirstComponent( entity_id, "VariableStorageComponent", "boss_reworks_armor" )
local recent_relative_damage = ComponentGetValue2( old_armorcomp, "value_float")

local armorcomp = EntityGetFirstComponent( eid, "VariableStorageComponent", "boss_reworks_armor" )
ComponentSetValue2( armorcomp, "value_float", recent_relative_damage)


LoadPixelScene( "mods/Apotheosis/files/enemies_gfx/sacriligious_monster/armor_piece_mat_5.png", "mods/Apotheosis/files/enemies_gfx/sacriligious_monster/armor_piece_5.png", pos_x-56, pos_y-56, "", true )