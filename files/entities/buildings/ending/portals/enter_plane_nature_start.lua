function item_pickup( entity_item, entity_who_picked, name )
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local player_id = EntityGetWithTag("player_unit")
local p_x, p_y = EntityGetTransform(player_id)

local effect_id = EntityLoad("mods/Apotheosis/files/entities/misc/effect_trip_red_transcend.xml", p_x, p_y)
EntityAddChild( player_id, effect_id)

GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/magic/transcend", p_x, p_y );

EntityLoad("mods/Apotheosis/files/entities/buildings/gateway_base_decoy.xml", pos_x, pos_y)
EntityKill(GetUpdatedEntityID())
end
