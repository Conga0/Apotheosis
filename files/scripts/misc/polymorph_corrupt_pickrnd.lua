
local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity(entity_id)
local pos_x, pos_y = EntityGetTransform(entity_id)

local child = EntityLoad("mods/apotheosis/files/entities/misc/effect_polymorph_corrupt.xml",pos_x,pos_y)
local comp = EntityGetFirstComponentIncludingDisabled(child,"GameEffectComponent")

local polytargets = {"miniboss_pit_02.xml","fairy_giant.xml","wraith_alchemy_apotheosis.xml"}
local polytarget = table.concat({"data/entities/animals/",polytargets[math.random(1,#polytargets)]})

ComponentSetValue2(comp,"polymorph_target",polytarget)
EntityAddChild(entity_id,child)
print("comp is " .. ComponentGetValue2(comp,"polymorph_target"))
print(polytarget)
