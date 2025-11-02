local entity_id = GetUpdatedEntityID()
local pos_x,pos_y = EntityGetTransform( entity_id )
local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ProjectileComponent")
local shooter_id = ComponentGetValue2(projcomp,"mWhoShot") or 0
local radius = 192
local targets = EntityGetInRadiusWithTag( pos_x, pos_y, radius, "mortal" )

function checkGenomeLikeness(entity_id,victim_id)
  if entity_id == victim_id then return true end
  if entity_id == 0 then return false end

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

    if not hit and checkGenomeLikeness(shooter_id,v) == false then
      local distance = math.abs(targ_y - pos_y) + math.abs(targ_x - pos_x)
      local damage_mult = (1 - math.max(0.0,distance - (radius / 4)) / radius)
      EntityInflictDamage( v, 15 * damage_mult, "DAMAGE_ELECTRICITY", "$enemy_apotheosis_enchanted_book_lightning", "NONE", 0, 0, shooter_id, pos_x, pos_y, 100 )
      EntityInflictDamage( v, 15 * damage_mult, "DAMAGE_EXPLOSION", "$enemy_apotheosis_enchanted_book_lightning", "NONE", 0, 0, shooter_id, pos_x, pos_y, 100 )

      local cdcomp = EntityGetFirstComponentIncludingDisabled(v,"CharacterDataComponent") or 0
      if cdcomp ~= 0 then
        local vel_x = targ_x - pos_x
        local vel_y = targ_y - pos_y
        ComponentSetValue2(cdcomp,"mVelocity",vel_x * 50 * damage_mult,vel_y * 50 * damage_mult)
      end

			local pd_laser = EntityLoad("data/entities/animals/enchanted_books/projectiles/point_defense_shot.xml",pos_x,pos_y)
			local comp = EntityGetFirstComponentIncludingDisabled(pd_laser,"LightningComponent")
			ComponentSetValue2(comp,"mExPosition",targ_x,targ_y)
    end
end