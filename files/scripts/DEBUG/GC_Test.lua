local entity_id = GetUpdatedEntityID()

GamePrint("trying to add GC to bubble")

dofile_once("data/scripts/perks/perk.lua")
dofile( "data/scripts/perks/perk_pickup.lua" )

function addPerk(perk_id,player_id)
    local x,y = EntityGetTransform(player_id)
    local perk_id = perk_spawn( x, y, perk_id )
    perk_pickup(perk_id, player_id)
end

--Always give this so we can showcase new spells that appear mid-run if the opportunity arises
addPerk("GLASS_CANNON",entity_id)