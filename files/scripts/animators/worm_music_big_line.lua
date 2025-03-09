dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()

local vsccomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local parent = ComponentGetValue2(vsccomp,"value_int")
local x,y = EntityGetTransform(parent)

local particlecomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ParticleEmitterComponent")
ComponentSetValue2(particlecomp, "mExPosition", x, y)

