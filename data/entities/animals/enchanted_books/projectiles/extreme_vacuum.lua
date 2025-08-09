
local entity_id = GetUpdatedEntityID()
local children = EntityGetAllChildren(entity_id) or {}
EntitySetComponentsWithTagEnabled( entity_id, "invincible", true )

for k=1,#children do
    local comps = EntityGetComponentIncludingDisabled( children[k], "ParticleEmitterComponent" ) or {}
    for z=1,#comps do
        EntitySetComponentIsEnabled( children[k], comps[z], true )
    end
end