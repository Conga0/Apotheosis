dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

local reforge_entity_id = GetUpdatedEntityID()
local entity_id = EntityGetRootEntity(reforge_entity_id)
local pos_x, pos_y = EntityGetTransform( entity_id )

local comp = EntityGetComponentIncludingDisabled(entity_id,"PhysicsImageShapeComponent")[1]
local image = ComponentGetValue2(comp,"image_file")

local inputlist = {
    "data/items_gfx/brimstone.png", --Fire Stone
    "data/items_gfx/stonestone.png",    --Earth Stone
    "data/items_gfx/smallgem_03.png",   --Lightning Stone
    "data/items_gfx/waterstone.png",    --Water Stone
    "data/items_gfx/kakke.png", --Spirit Stone
    "mods/Apotheosis/files/items_gfx/stone_fungus.png", --Fungus Stone
    "data/items_gfx/goldnugget_01.png", --Wand Stone
    "data/items_gfx/beamstone.png", --Beam Stone
    "data/items_gfx/goldnugget_9px.png",    --Sun Stone
    "mods/Apotheosis/files/items_gfx/goldnugget_01_alt.png", --Sun Seed
    "mods/Apotheosis/files/items_gfx/goldnugget_01_alt_heretic.png", --Heretic Stone
    "mods/Apotheosis/files/items_gfx/goldnugget_01_alt_radar.png", --Guiding Stone
}

local outputlist = {
    "PROTECTION_FIRE",
    "TELEKINESIS",
    "PROTECTION_ELECTRICITY",
    "BREATH_UNDERWATER",
    "APOTHEOSIS_ALCOHOL_IMMUNITY",
    "APOTHEOSIS_TRIP_IMMUNITY",
    "EDIT_WANDS_EVERYWHERE",
    "MEGA_BEAM_STONE",
    "REMOVE_FOG_OF_WAR",
    "REMOVE_FOG_OF_WAR",
    "GLOBAL_GORE",
    "APOTHEOSIS_PLANE_RADAR",
}

function radarStoneCheck(eid,img)
    if img == "mods/Apotheosis/files/items_gfx/goldnugget_01_alt_radar.png" then
        local lcomps = EntityGetComponentIncludingDisabled(eid,"LuaComponent")
        for j=1,#lcomps do
            if ComponentGetValue2(lcomps[j],"script_source_file") == "mods/Apotheosis/files/scripts/items/radar_stone_destroyed.lua" then
                EntitySetComponentIsEnabled( eid, lcomps[j], false )
                break
            end
        end
        GameAddFlagRun("apotheosis_stone_obsolete")
    end
end

for k=1, #inputlist
do local v = inputlist[k];

    if (image == "mods/Apotheosis/files/items_gfx/goldnugget_01_alt_radar.png" or image == "mods/Apotheosis/files/items_gfx/goldnugget_01_alt_heretic.png" ) and not GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") then
        local heretic_found = false
        local boss = EntityGetInRadiusWithTag(pos_x,pos_y,1536,"miniboss") or {}
        for bp=1,#boss do
            if EntityGetName(boss[bp]) == "$enemy_apotheosis_boss_flesh_monster" then
                heretic_found = true
            	break
            end
        end
        if heretic_found == false then
	    if tonumber(SessionNumbersGetValue("NEW_GAME_PLUS_COUNT")) > 0 or GameHasFlagRun("apotheosis_flesh_boss_stone_converted") then
	        EntityLoad("mods/Apotheosis/files/entities/misc/spawn_boss_flesh_monster_newgame_plus_short.xml",pos_x,pos_y-150)
	    else
	        EntityLoad("mods/Apotheosis/files/entities/misc/spawn_boss_flesh_monster.xml",pos_x,pos_y-150)
	    end
            GameScreenshake( 150 )
        end
    elseif image == v then
		EntityLoad("data/entities/projectiles/explosion.xml", pos_x, pos_y - 10)
		local perk_id = perk_spawn( pos_x, pos_y, outputlist[k] )
        --Perk tag is removed so other perks aren't deleted upon picking this one up
        --EntityRemoveTag(perk_id, "perk")
        --Decided to swap this out for this way instead seeing as Leggy Mimic's perk uses it so it must be the official way! -S
	if( perk_id ~= nil ) then
		EntityAddComponent( perk_id, "VariableStorageComponent", 
		{ 
			name = "perk_dont_remove_others",
			value_bool = "1",
		} )
	end
        AddFlagPersistent(table.concat({"apotheosis_card_unlocked_perkforged_",string.lower(outputlist[k])}))
        radarStoneCheck(entity_id,image)
		EntityKill(entity_id)
        if not GameHasFlagRun("apotheosis_perk_creation_angered") then
            GameAddFlagRun("apotheosis_perk_creation_angered")
            AddFlagPersistent("apotheosis_card_unlocked_perk_creation")

            --You Have Angered the Gods
            GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/angered_the_gods/create", pos_x, pos_y )
            GameScreenshake( 50 )
        end
        return
    end
end

EntityKill(reforge_entity_id)
