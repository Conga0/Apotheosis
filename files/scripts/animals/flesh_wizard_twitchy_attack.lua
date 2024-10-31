dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local r = 400

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
	SetRandomSeed( GameGetFrameNum(), x + y + entity_id )
	local amount = Random(5,7)
	local theta = math.pi * 2 / amount
	local vx = 250
	local vy = 250

	for i=1, amount do
		local pid = shoot_projectile( entity_id, "mods/apotheosis/files/entities/projectiles/orb_flesh_twitchy.xml", x, y, vx, vy )
		local projcomp = EntityGetFirstComponentIncludingDisabled( pid, "ProjectileComponent" )
		ComponentSetValue2(projcomp, "mShooterHerdId", StringToHerdId("mage_corrupted"))
		vx,vy = vec_rotate(vx, vy, theta)
	end
end