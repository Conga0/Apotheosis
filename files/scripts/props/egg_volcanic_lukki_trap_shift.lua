local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed(math.random() * 10000, math.random() * 10000)

EntityLoad( "mods/Apotheosis/files/entities/projectiles/egg_shifter.xml", pos_x + Random(-5, 5), pos_y + Random(-4, 5) )

GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/egg_volcanic_lukki/crack", pos_x, pos_y );
EntityLoad( "mods/Apotheosis/files/entities/particles/egg_volcanic_lukki_crack_effect.xml", pos_x, pos_y )

local varcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent")
local caution = ComponentGetValue2(varcomp, "value_float")
ComponentSetValue2( varcomp, "value_float", caution + 1 )