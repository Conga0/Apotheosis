local entity_id = GetUpdatedEntityID()
local pos_x,pos_y = EntityGetTransform( entity_id )
local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ProjectileComponent")
local shooter_id = ComponentGetValue2(projcomp,"mWhoShot") or 0
local radius = 128
local targets = EntityGetInRadiusWithTag( x, y, radius, "mortal" )

function checkGenomeLikeness(entity_id,victim_id)
  if entity_id == victim_id then return true end

  local entity_animal_id = EntityGetFirstComponentIncludingDisabled(entity_id, "AnimalAIComponent") or 0
  local aggression = ComponentGetValue2(entity_animal_id, "mAggression") or 40

  if EntityGetHerdRelation(entity_id, victim_id) < aggression then
    return false
  else
    return true
  end
end

for k=1, #targets
do local v = targets[k]
    local targ_x, targ_y = EntityGetTransform(v)
    local hit = RaytraceSurfaces(pos_x, pos_y, targ_x, targ_y)

    if not hit and checkGenomeLikeness(entity_id,v) then
        local distance = math.abs(targ_y - pos_y) + math.abs(targ_x - pos_x)
		local damage_mult = (1 - math.max(0.0,distance - (radius * 0.5)) / radius)
        EntityInflictDamage( v, 10 * damage_mult, "DAMAGE_ELECTRICITY", "$enemy_apotheosis_enchanted_book_lightning", "NONE", 0, 0, shooter_id )
        EntityInflictDamage( v, 10 * damage_mult, "DAMAGE_EXPLOSION", "$enemy_apotheosis_enchanted_book_lightning", "NONE", 0, 0, shooter_id )
    end
end