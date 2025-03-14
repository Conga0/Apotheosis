dofile_once("data/scripts/lib/utilities.lua")

--Worm Firing Data
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local vcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local current = ComponentGetValue2( vcomp, "value_int" ) or 1
local current_max = 22 --Wyrm's actual length is 11, but we use 22 to stall as a cooldown
local enemy_count = #(EntityGetInRadiusWithTag(x,y,150,"enemy") or {})
local player_count = #(EntityGetInRadiusWithTag(x,y,200,"player_unit") or {})
local homingcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"HomingComponent")
local projectile_damage_mult = 0.5

if player_count == 0 then
    ComponentSetValue2(homingcomp,"target_who_shot",true)
else
    ComponentSetValue2(homingcomp,"target_who_shot",false)
end

function SplitStringOnCharIntoTable(string, char)
    local list = {}
    for w in (string .. char):gmatch("([^" .. char .. "]*)" .. char) do
        table.insert(list, w)
    end
    return list
end

--Gun Info
local extract = dofile_once("mods/Apotheosis/files/scripts/misc/proj_data.lua")
local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ProjectileComponent")
local gun_data = extract(projcomp, {2})
local gun_info = SplitStringOnCharIntoTable(gun_data,string.char(255))

--Handles if now is a good time to shoot
if ( current > 0 ) and ( vcomp ~= 0 ) then
	if ( current <= 11 ) and enemy_count > 0 then
		local ch = EntityGetAllChildren( entity_id )
		local i_ = 0
		
		if ( ch ~= nil ) then
			for i,v in ipairs( ch ) do
                i_ = i_ + 1
                
                if ( i_ == current ) then
                    --Handles actually shooting the projectiles we want
                    do
                        local target = EntityGetClosestWithTag(  x, y, "enemy" )
                        SetRandomSeed( GameGetFrameNum() + current, x + y + entity_id )
                        local r_x,r_y = EntityGetTransform(v)
                        local t_x,t_y = EntityGetTransform(target)

                        local pid = EntityLoad("mods/Apotheosis/files/entities/projectiles/deck/spell_worm_attack.xml",r_x,r_y)
                        GameShootProjectile( entity_id, r_x, r_y, t_x, t_y, pid)
                        local pvcomp = EntityGetFirstComponentIncludingDisabled(pid,"VelocityComponent")
                        local vel_x, vel_y = ComponentGetValue2(pvcomp,"mVelocity", vel_x, vel_y)
                        local speed_mult = gun_info[23] -- Projectile speed
                        ComponentSetValue2(pvcomp,"mVelocity", vel_x * speed_mult, vel_y * speed_mult)
                        local pcomp = EntityGetFirstComponentIncludingDisabled(pid,"ProjectileComponent")
                        ComponentSetValue2(pcomp,"mWhoShot",entity_id) 
                        ComponentSetValue2(pcomp,"mShooterHerdId",StringToHerdId("player"))

                        ---Gun data time
                        --Damage
                            ComponentSetValue2(pcomp,"damage",ComponentGetValue2(pcomp,"damage") + (gun_info[32] * projectile_damage_mult)) --50% damage reduction on all attacks, to be balanced
                            local damagetypes = {
                                "melee",
                                "projectile",
                                "electricity",
                                "fire",
                                "explosion",
                                "ice",
                                "slice",
                                "healing",
                                "curse",
                                "drill",
                            }
                            for u=1,#damagetypes do
                                if u ~= 2 or u~= 5 then --2 is projectile, 5 is explosive, both are handled differently
                                    ComponentObjectSetValue2( pcomp, "damage_by_type", damagetypes[u], ComponentObjectGetValue2( pcomp, "damage_by_type", damagetypes[u]) + (gun_info[30+u] * projectile_damage_mult)) --50% damage reduction on all attacks, to be balanced
                                end
                            end
                        --Extra Entities
                            local extra_children = SplitStringOnCharIntoTable(gun_info[62], ",")
                            for u=1,#extra_children do
                                if #extra_children[u] > 1 then
                                    EntityLoadToEntity(extra_children[u],pid)
                                end
                            end
                        --Critical Damage
                            ComponentObjectSetValue2( pcomp, "damage_critical", "chance", ComponentObjectGetValue2( pcomp, "damage_critical", "chance") + gun_info[42])
                            ComponentObjectSetValue2( pcomp, "damage_critical", "damage_multiplier", ComponentObjectGetValue2( pcomp, "damage_critical", "damage_multiplier") + gun_info[43])
                        --Explosions
                            ComponentObjectSetValue2( pcomp, "config_explosion", "damage", ComponentObjectGetValue2( pcomp, "config_explosion", "damage") + (gun_info[35] * projectile_damage_mult)) --50% damage reduction on all attacks, to be balanced
                            ComponentObjectSetValue2( pcomp, "config_explosion", "explosion_radius", ComponentObjectGetValue2( pcomp, "config_explosion", "explosion_radius") + gun_info[26])
                        --Bounces
                            ComponentSetValue2(pcomp,"bounces_left",tonumber(gun_info[52]))
                            if tonumber(gun_info[52]) > 0 then
                                ComponentSetValue2(pcomp,"bounce_always",true)
                                ComponentSetValue2(pcomp,"bounce_energy",0.9)
                            end
                        --Friendly Fire
                            if gun_info[58] == true then
                                ComponentSetValue2(pcomp,"friendly_fire",true)
                            end
                        ---Misc Data (Specify)
                        --Lifetime
                        ComponentSetValue2(pcomp,"lifetime",ComponentGetValue2(pcomp,"lifetime") + gun_info[60])

                        --Accelerative Shooting
                        local luacomp = EntityGetFirstComponentIncludingDisabled(entity_id,"LuaComponent")
                        ComponentSetValue2(luacomp,"execute_every_n_frame",math.max(1,ComponentGetValue2(luacomp,"execute_every_n_frame") - 5))
                    end
                    break
                end
			end
		end
	end
	
	current = current + 1
	if ( current > current_max ) then
		current = 1
	end
	
	ComponentSetValue2( vcomp, "value_int", current )
end