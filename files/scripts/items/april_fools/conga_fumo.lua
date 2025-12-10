
local entity_id = GetUpdatedEntityID()
local item_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"ItemComponent")
local ui_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"UIInfoComponent")
local ability_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"AbilityComponent")
local parent_id = EntityGetRootEntity(entity_id)

local characters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#%^&*()_+-=?!"
local string_length = 9
local item_name = ""

math.randomseed(GameGetFrameNum()+999)
for k=1,string_length do
    local pos = math.random(1,#characters)
    item_name = item_name .. characters:sub(pos,pos)
end

ComponentSetValue2(item_comp,"item_name",item_name)
ComponentSetValue2(ui_comp,"name",item_name)
ComponentSetValue2(ability_comp,"ui_name",item_name)

if parent_id ~= entity_id then
    local p_x, p_y, p_r, p_sx = EntityGetTransform(parent_id)
    local sprite_comp = EntityGetComponentIncludingDisabled(entity_id,"SpriteComponent")[1]
    if p_sx < 0 then
        ComponentSetValue2(sprite_comp,"special_scale_y",-0.12)
    else
        ComponentSetValue2(sprite_comp,"special_scale_y",0.12)
    end
end
