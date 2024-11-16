
local entity_id = GetUpdatedEntityID()
local player_id = EntityGetParent(entity_id)

local x,y = EntityGetTransform(player_id)

EntityLoad("data/entities/particles/blood_explosion.xml",x,y)
LoadGameEffectEntityTo( player_id, "mods/Apotheosis/files/entities/misc/effect_polymorph_worm_end_big_apotheosis.xml" )