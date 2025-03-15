
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)
local eggs = EntityGetInRadiusWithTag(x,y,32,"hittable")
for k=1,#eggs do
    if EntityGetName(eggs[k]) == "Ant Egg" then
         local comp = EntityGetFirstComponentIncludingDisabled(eggs[k],"DamageModelComponent")
         ComponentSetValue2(comp,"hp",0.0)
         EntityInflictDamage( eggs[k], 0.04, "DAMAGE_PHYSICS_BODY_DAMAGED", "$status_apotheosis_anthatching_name", "NONE", 0, 0, EntityGetParent(entity_id) )
    end
end