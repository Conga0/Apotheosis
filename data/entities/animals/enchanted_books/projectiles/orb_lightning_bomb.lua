local entity_id = GetUpdatedEntityID()
local pos_x,pos_y = EntityGetTransform( entity_id )
local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ProjectileComponent")
local shooter_id = ComponentGetValue2(projcomp,"mWhoShot") or 0
local radius = 128
local targets = EntityGetInRadiusWithTag( pos_x, pos_y, radius, "mortal" )

for k=1, #targets
do local v = targets[k]
    local targ_x, targ_y = EntityGetTransform(v)
    local hit = RaytraceSurfaces(pos_x, pos_y, targ_x, targ_y)

    local victim_genome_comp = EntityGetFirstComponentIncludingDisabled(v,"GenomeDataComponent") or 0
    local valid_target = true
    if victim_genome_comp ~= 0 and GetHerdRelation( ComponentGetValue2(projcomp, "mShooterHerdId"), ComponentGetValue2(victim_genome_comp,"herd_id") ) > 50 then
      valid_target = false
    end

    if not hit and valid_target then
      local distance = math.abs(targ_y - pos_y) + math.abs(targ_x - pos_x)
      local damage_mult = (1 - math.max(0.0,distance - (radius / 3)) / radius)
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