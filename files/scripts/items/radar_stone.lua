dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local parent_id = EntityGetParent(parent_id)
local pos_x, pos_y = EntityGetTransform( entity_id )
pos_y = pos_y - 4 -- offset to middle of character

local vsccomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local enemy_cd = ComponentGetValue2(vsccomp,"value_int")
local curframe = GameGetFrameNum()


local indicator_distance = 20
local range = 600

local enemy_table = EntityGetInRadiusWithTag( pos_x, pos_y, range, "enemy")
local wand_table = EntityGetInRadiusWithTag( pos_x, pos_y, range, "wand")
local item_table = EntityGetInRadiusWithTag( pos_x, pos_y, range, "item_pickup")

if curframe > enemy_cd + 600 then
    for k=1,#enemy_table
    do local v = enemy_table[k]
        local e_x, e_y = EntityGetTransform(v)
        EntityAddChild(v,EntityLoad("mods/apotheosis/files/entities/misc/mindvision_short.xml", e_x, e_y))
    end
    ComponentSetValue2(vsccomp,"value_int",curframe)
end

for k=1,#wand_table
do local v = wand_table[k]
	local wand_x, wand_y = EntityGetTransform(v)
	local parent = EntityGetRootEntity( v );

	if( IsPlayer( parent ) == false ) then 

		local dir_x = wand_x - pos_x
		local dir_y = wand_y - pos_y
		local distance = get_magnitude(dir_x, dir_y)

		-- sprite positions around character
		dir_x,dir_y = vec_normalize(dir_x,dir_y)
		local indicator_x = pos_x + dir_x * indicator_distance
		local indicator_y = pos_y + dir_y * indicator_distance

		-- display sprite based on proximity
		if distance > range * 0.5 then
			GameCreateSpriteForXFrames( "data/particles/radar_wand_faint.png", indicator_x, indicator_y )
		elseif distance > range * 0.25 then
			GameCreateSpriteForXFrames( "data/particles/radar_wand_medium.png", indicator_x, indicator_y )
		elseif distance > 10 then
			GameCreateSpriteForXFrames( "data/particles/radar_wand_strong.png", indicator_x, indicator_y )
		end
	end
end

for k=1,#item_table
do local v = item_table[k]
	local wand_x, wand_y = EntityGetTransform(v)
	local parent = EntityGetRootEntity( v );

	if( IsPlayer( parent ) == false ) then 

		local dir_x = wand_x - pos_x
		local dir_y = wand_y - pos_y
		local distance = get_magnitude(dir_x, dir_y)

		-- sprite positions around character
		dir_x,dir_y = vec_normalize(dir_x,dir_y)
		local indicator_x = pos_x + dir_x * indicator_distance
		local indicator_y = pos_y + dir_y * indicator_distance

		-- display sprite based on proximity
		if distance > range * 0.5 then
			GameCreateSpriteForXFrames( "data/particles/radar_item_faint.png", indicator_x, indicator_y )
		elseif distance > range * 0.25 then
			GameCreateSpriteForXFrames( "data/particles/radar_item_medium.png", indicator_x, indicator_y )
		elseif distance > 10 then
			GameCreateSpriteForXFrames( "data/particles/radar_item_strong.png", indicator_x, indicator_y )
		end
    end
end
