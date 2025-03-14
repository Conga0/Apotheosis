
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)
local staincomp = EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteStainsComponent")
local stain_drop_chance = 0
local vcomps = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent") or {}
for k=1,#vcomps do
    if ComponentGetValue2(vcomps[k],"name") == "perk_absorbent_cape" then
        stain_drop_chance = ComponentGetValue2(vcomps[k],"value_float")
        break
    end
end
SetRandomSeed(x+y+GameGetFrameNum(),x-y)
local rng = Randomf(0,1)
if rng > stain_drop_chance then
    ComponentSetValue2(staincomp,"stain_shaken_drop_chance_multiplier",0)
else
    ComponentSetValue2(staincomp,"stain_shaken_drop_chance_multiplier",1)
end
