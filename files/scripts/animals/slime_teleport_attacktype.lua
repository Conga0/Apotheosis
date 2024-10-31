
local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local allyfound = false

local comp = EntityGetFirstComponentIncludingDisabled( entity_id, "AnimalAIComponent" )

if ( comp ~= nil ) then
    local targets = EntityGetInRadiusWithTag(pos_x, pos_y, 150, "enemy")
    for k=1,#targets do
		if EntityGetName(targets[k]) ~= "Säröilevä limanuljaska" then
			allyfound = true
			break
		end
    end
	
	if ( allyfound ) then
		ComponentSetValue2( comp, "attack_ranged_entity_file", "mods/Apotheosis/files/entities/projectiles/slime_teleporter_projectile.xml" )
		ComponentSetValue2( comp, "attack_ranged_frames_between", 330 )
	else
		ComponentSetValue2( comp, "attack_ranged_entity_file", "data/entities/projectiles/orb_tele.xml" )
		ComponentSetValue2( comp, "attack_ranged_frames_between", 120 )
	end
end