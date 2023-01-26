dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

local reforge_entity_id = GetUpdatedEntityID()
local entity_id = EntityGetRootEntity(reforge_entity_id)
local pos_x, pos_y = EntityGetTransform( entity_id )

local comp = EntityGetComponentIncludingDisabled(entity_id,"PhysicsImageShapeComponent")[1]
local image = ComponentGetValue2(comp,"image_file")

local inputlist = {
    "data/items_gfx/brimstone.png",
    "data/items_gfx/stonestone.png",
    "data/items_gfx/smallgem_03.png",
    "data/items_gfx/waterstone.png",
    "data/items_gfx/kakke.png",
    "mods/Apotheosis/files/items_gfx/stone_fungus.png",
    "data/items_gfx/goldnugget_01.png",
}

local outputlist = {
    "PROTECTION_FIRE",
    "TELEKINESIS",
    "PROTECTION_ELECTRICITY",
    "BREATH_UNDERWATER",
    "APOTHEOSIS_ALCOHOL_IMMUNITY",
    "APOTHEOSIS_TRIP_IMMUNITY",
    "EDIT_WANDS_EVERYWHERE",
}

local count = 1

for k=1, #inputlist
do local v = inputlist[k];

    if image == v then
		EntityLoad("data/entities/projectiles/explosion.xml", pos_x, pos_y - 10)
		perk_spawn( pos_x, pos_y, outputlist[count] )
		EntityKill(entity_id)
        if not GameHasFlagRun("apotheosis_perk_creation_angered") then
            GameAddFlagRun("apotheosis_perk_creation_angered")

            --You Have Angered the Gods
            GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/angered_the_gods/create", pos_x, pos_y )
            GameScreenshake( 50 )
        end
        return
    end
    count = count + 1
end

if count == 7 then Print("Error: Found no valid output targets for Perk Creation Altar") end

EntityKill(reforge_entity_id)