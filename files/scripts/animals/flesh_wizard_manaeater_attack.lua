dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 500

local targets = EntityGetInRadiusWithTag( x, y, r, "mortal" )

local foe = false

local animalai = EntityGetFirstComponentIncludingDisabled(entity_id, "AnimalAIComponent")
local aggression = ComponentGetValue2(animalai, "mAggression") or 40

for k=1, #targets
do local v = targets[k]
	local genome = EntityGetFirstComponentIncludingDisabled(v, "GenomeDataComponent")
	if v ~= entity_id and genome ~= nil and (EntityGetHerdRelation(entity_id, v) < aggression) then
		foe = true
		break
	end
end

if foe == true then
	local time  = GameGetFrameNum() / 30.0
	local angle = time * 2
	local vel_x = math.cos(angle) * 90
	local vel_y = -math.sin(angle) * 90

	local pid = shoot_projectile( entity_id, "mods/apotheosis/files/entities/projectiles/orb_corrupt_manadrain_weakhome.xml", x, y, vel_x, vel_y )
	local projcomp = EntityGetFirstComponentIncludingDisabled( pid, "ProjectileComponent" )
	ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("mage_corrupted"))
end