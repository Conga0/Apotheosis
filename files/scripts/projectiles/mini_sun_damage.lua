local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ProjectileComponent")
local shooter_id = ComponentGetValue2(projcomp,"mWhoShot") or 0
local targets = EntityGetInRadiusWithTag(pos_x,pos_y,120,"mortal") or {}

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

for k=1,#targets do
    local v = targets[k]
    local targ_x, targ_y = EntityGetTransform(v)
    local hit = RaytraceSurfaces(pos_x, pos_y, targ_x, targ_y)

    if not hit and checkGenomeLikeness(shooter_id,v) then
        EntityInflictDamage( v, 0.1, "DAMAGE_FIRE", "$damage_sun", "NONE", 0, 0, shooter_id )

        
        local comp = EntityGetFirstComponent(v,"DamageModelComponent") or false
        if comp ~= false then
            ComponentSetValue2(comp,"is_on_fire",true)
            ComponentSetValue2(comp,"mIsOnFire",true)
            ComponentSetValue2(comp,"mFireDurationFrames",90)
            ComponentSetValue2(comp,"mFireFramesLeft",90)
        end

        local distance = math.abs(targ_y - pos_y) + math.abs(targ_x - pos_x)
        
        if (distance < 20) then
            EntityInflictDamage( v, 0.5, "DAMAGE_CURSE", "$damage_sun", "NONE", 0, 0, shooter_id )
        end
    end
end