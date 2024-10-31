
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 105
local converted = false

--I feel this frozen check could be optimised somehow.. but I am unsure how

local frozenTest = GameGetGameEffectCount( entity_id, "FROZEN" )
if frozenTest <= 0 then
	local targets = EntityGetInRadiusWithTag( x, y, r, "player_unit" )

	for k=1, #targets
	do local v = targets[k];
		if ( v ~= entity_id ) then
			local eid = EntityLoad( "mods/Apotheosis/files/entities/misc/effect_mana_degradation.xml", x, y )
			EntityAddChild( v, eid )
		end
	end

	--Planes one shouldn't convert
	--[[
	--Would perform better if put on the wandstone itself
	--11/01/2023 Conga: too troubled to optimise right now.. ugh..
	local stones = EntityGetInRadiusWithTag(x,y,20,"poopstone")
	for k=1,#stones
	do local v = stones[k]
		local comp = EntityGetFirstComponentIncludingDisabled(v,"PhysicsImageShapeComponent")
		if EntityGetParent(v) == 0 then
			if ComponentGetValue2(comp,"image_file") == "data/items_gfx/goldnugget_01.png" and converted == false then
				converted = true
					EntityLoad("data/entities/animals/planes/devourer_magic.xml",x,y)
					EntityKill(entity_id)
				break
			end
		end
	end
	]]--
end
