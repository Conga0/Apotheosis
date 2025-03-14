local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local r = 650
local player_id = EntityGetWithTag("player_unit")[1] or 0

if player_id ~= 0 then
	local cursecomp = EntityGetFirstComponentIncludingDisabled(entity_id,"AreaDamageComponent")
	local player_hp = EntityGetFirstComponentIncludingDisabled(player_id,"DamageModelComponent")

	local bite_dmg = math.max(0.24,0.24*(ComponentGetValue2(player_hp,"max_hp")/8)) --Bite damage increases by 0.24 (+100%) for every 200 health the player has, minimum of 0.24
	ComponentSetValue2(cursecomp,"damage_per_frame",bite_dmg)
end