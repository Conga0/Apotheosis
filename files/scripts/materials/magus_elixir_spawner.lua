
local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local filepath = "data/entities/items/wand_level_03.xml"
local eid = EntityLoad( filepath, x, y )

local comp = EntityGetFirstComponentIncludingDisabled(eid,"SpriteParticleEmitterComponent")
ComponentSetValue2(comp,"emission_interval_min_frames",30)
ComponentSetValue2(comp,"emission_interval_max_frames",60)

EntityKill( entity_id )