--Is this the correct incarnation of Here- Portal?

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local cowardness = tonumber(GlobalsGetValue("HERETIC_COWARDLY"))
if cowardness == nil then
	cowardness = 0
end

local incarncomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )[2] or nil
local varcomps = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" ) or {}
for i = 1, #varcomps do
    if ComponentGetValue2(varcomps[i], "name") == "incarnation_value" then
	incarncomp = varcomps[i]
	break
    end
end
local incarnation = ComponentGetValue2( incarncomp, "value_int" )

if (incarnation < cowardness) and (incarnation+1 < cowardness) then
	--You are not the real Heretic...
	print("You are not the real Heretic...")
    	local spritecomps = EntityGetComponentIncludingDisabled(entity_id, "SpriteComponent") or {}
	if #spritecomps > 0 then --So it doesn't do the particles when it's just a portal disappearing
    	    for i = 1, #spritecomps do
		if ComponentGetValue2(spritecomps[i], "image_file") == "mods/apotheosis/files/enemies_gfx/sacriligious_monster/flesh.png" then
		    EntityLoad("data/entities/animals/boss_flesh_monster/phase3/transport_emitter_flesh.xml", pos_x, pos_y)
		else
		    EntityLoad("data/entities/animals/boss_flesh_monster/transport_emitter.xml", pos_x, pos_y)
		end
	    end
	end
	EntityLoad("data/entities/animals/boss_flesh_monster/boss_flesh_monster_portal_brief.xml", pos_x, pos_y)
	EntityKill(entity_id)
end
