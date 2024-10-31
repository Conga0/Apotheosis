--Is this the correct incarnation of Heretic?

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

if (incarnation < cowardness) then
	--You are not the real Heretic...
	print("You are not the real Heretic...")
    	local spritecomps = EntityGetComponentIncludingDisabled(entity_id, "SpriteComponent") or {}
	if #spritecomps > 0 then --So it doesn't do the particles when it's just a portal disappearing
    	    for i = 1, #spritecomps do
		if ComponentGetValue2(spritecomps[i], "image_file") == "mods/Apotheosis/files/enemies_gfx/sacriligious_monster/flesh.png" then
		    EntityLoad("data/entities/animals/boss_flesh_monster/phase3/transport_emitter_flesh.xml", pos_x, pos_y)
		else
		    EntityLoad("data/entities/animals/boss_flesh_monster/transport_emitter.xml", pos_x, pos_y)
		end
	    end
	end
	EntityLoad("data/entities/animals/boss_flesh_monster/boss_flesh_monster_portal_brief.xml", pos_x, pos_y)
	EntityKill(entity_id)
end

if GameHasFlagRun("heretic_dead_dead") then
	local currently_dying = false
	local c = EntityGetAllChildren( entity_id )
	if c ~= nil then
	for a,b in ipairs( c ) do
               	local effectname = EntityGetName( b )

	       	if ( effectname == "flesh_curse" ) then
                    	currently_dying = true
                    	break
	        end
               	--Nevermind this indirectly causes HORRIBLE THINGS TO OCCUR! 
		--Contact "theonetheonlyspoopyboi" on discord if you want a gif of it : )
               	--[[
               	local particlecomp = EntityGetFirstComponentIncludingDisabled( b, "SpriteParticleEmitterComponent" )
		if ComponentGetValue2(particlecomp, "sprite_file") == "data/particles/protection_all_evil.xml" then
			EntityRemoveComponent(b, particlecomp)
		end
		local effectcomps = EntityGetComponentIncludingDisabled( b, "GameEffectComponent", "effect_protection_all" ) or {}
		for i = 1, #effectcomps do
			EntityRemoveComponent(b, effectcomps[i])
		end
		]]--
            end
	end

	local child_id = EntityLoad("mods/Apotheosis/files/entities/misc/effect_flesh_curse_super.xml",pos_x,pos_y)
	EntityAddChild(entity_id, child_id)
end