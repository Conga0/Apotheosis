local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local vsc_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local master_id = ComponentGetValue2(vsc_comp,"value_int")

local dud1, dud2, rot, scale_x, scale_y = EntityGetTransform(master_id)

EntitySetTransform(master_id, pos_x, pos_y, rot, scale_x, scale_y)
GamePlaySound( "data/audio/Desktop/misc.bank", "misc/teleport_use", pos_x, pos_y )
EntityKill(entity_id)