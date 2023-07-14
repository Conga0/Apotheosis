dofile_once("data/scripts/perks/perk.lua")
dofile_once( "data/scripts/perks/perk_pickup.lua" )

function GivePerkToEnemy( perk_id, enemy_id )
    for i = 1, #perk_list do
        if perk_list[i].id == perk_id then
            give_perk_to_enemy(perk_list[i], enemy_id)
            break
        end
    end
end



local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local targets = EntityGetInRadiusWithTag(pos_x, pos_y, 512, "enemy")

for k=1,#targets
do local v = targets[k] --Cast share is used as a tag here to optimise tag usage, too many unique modded tags and the game gets angry
    if v ~= entity_id and EntityHasTag(v,"cast_share") == false then
        GivePerkToEnemy("GLASS_CANNON", v)

        EntityAddTag(v,"cast_share")
    end
end
