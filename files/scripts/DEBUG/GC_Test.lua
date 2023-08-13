local entity_id = GetUpdatedEntityID()

--GamePrint("trying to add GC to bubble")

dofile_once("data/scripts/perks/perk.lua")
dofile( "data/scripts/perks/perk_pickup.lua" )


for i = 1, #perk_list do
    if perk_list[i].id == "GLASS_CANNON" then
        give_perk_to_enemy(perk_list[i], entity_id)
        break
    end
end