
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local target = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent"),"value_int")
local targ_x, targ_y = 764,-814

local passengers = EntityGetInRadiusWithTag(pos_x, pos_y, 32, "small_friend")
for k=1,#passengers
do local v = passengers[k]
    EntitySetTransform(v,targ_x,targ_y)
    GamePlaySound( "data/audio/Desktop/misc.bank", "misc/teleport_use_end", targ_x, targ_y )
end


local passengers2 = EntityGetInRadiusWithTag(pos_x, pos_y, 32, "big_friend")
for k=1,#passengers2
do local v = passengers2[k]
    EntitySetTransform(v,targ_x,targ_y)
    GamePlaySound( "data/audio/Desktop/misc.bank", "misc/teleport_use_end", targ_x, targ_y )
end
