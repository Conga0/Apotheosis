dofile_once("data/scripts/perks/perk.lua")
dofile_once( "data/scripts/perks/perk_pickup.lua" )

local perk_options = {}

for z=1,#perk_list
do local c = perk_list[z]
    if c.usable_by_enemies == true then
        table.insert(perk_options,c)
    end
end

function givePerk(id)
    give_perk_to_enemy(perk_options[math.random(1,#perk_options)], id)
end