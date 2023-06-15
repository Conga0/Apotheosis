
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local target = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent"),"value_int")
local targ_x, targ_y = EntityGetTransform(target)

local passengers = EntityGetInRadiusWithTag(pos_x, pos_y, 32, "enemy")
for k=1,#passengers
do local v = passengers[k]
    EntitySetTransform(v,targ_x,targ_y)
    GamePlaySound( "data/audio/Desktop/misc.bank", "misc/teleport_use_end", targ_x, targ_y )
end

if #passengers > 0 then
    local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"ParticleEmitterComponent")
    ComponentSetValue2(comp, "mExPosition", targ_x, targ_y)
end