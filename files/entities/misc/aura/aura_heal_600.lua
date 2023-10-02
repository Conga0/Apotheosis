
local entity_id = GetUpdatedEntityID()
local parent_id = EntityGetParent(entity_id)
local x, y = EntityGetTransform( entity_id )

EntityLoad("mods/apotheosis/files/entities/particles/spell_fades/heal_600_fade.xml", x, y - 55 )
EntityInflictDamage( parent_id, -24, "DAMAGE_HEALING", "How did you see this", "NONE", 0, 0, parent_id )
GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/regeneration/tick", x, y )
EntityKill( entity_id )
