local entity_id = GetUpdatedEntityID()
local spec = EntityGetFirstComponent(entity_id, "SpriteParticleEmitterComponent")	--[[@cast spec number]]
local now = GameGetFrameNum() + ((entity_id * 24.84 % 91.2)^1.23)	-- arcane bullshit spells
local offset_y = -25 + math.sin(now/21.21)/2	-- strange mysic numbers
local offset_x = math.sin(now/50.93)			-- strange mysic numbers
local angle = math.rad(math.sin(now/32.23)*3)	-- strange mysic numbers
local sprite = math.floor(now/12)%8+1			-- strange mysic numbers
ComponentSetValue2(spec, "randomize_position", offset_x, offset_y, offset_x , offset_y)
ComponentSetValue2(spec, "rotation", angle)
-- Due to SPEC Haxx I need a different sprite for each frame I manually animate
ComponentSetValue2(spec, "sprite_file", table.concat{"mods/apotheosis/files/ui_gfx/gun_actions/knowledge_extras/knowledge_of_kings_crown_", sprite, ".xml"})