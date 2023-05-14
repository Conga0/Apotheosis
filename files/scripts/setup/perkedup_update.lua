
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local targets = EntityGetInRadiusWithTag(pos_x, pos_y, 256, "enemy")

dofile_once("mods/apotheosis/files/scripts/setup/perkedup_list.lua")

for k=1,#targets
do local v = targets[k] --Cast share is used as a tag here to optimise tag usage, too many unique modded tags and the game gets angry
    if v ~= entity_id and EntityHasTag(v,"cast_share") == false then
        givePerk(v)

        EntityAddTag(v,"cast_share")
    end
end