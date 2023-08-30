
local entity_id = GetUpdatedEntityID()
local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent")
local alpha = ComponentGetValue2(comp,"alpha")

--Increment Opacity by 0.5% every 2 frames, up to a maximum of 20%
ComponentSetValue2(comp,"alpha",math.min(alpha + 0.005,0.2))

--optimise this tomorrow