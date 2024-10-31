dofile_once("data/scripts/lib/utilities.lua")


local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local vcomp = 0
local current = 1
local length = 50

local c = EntityGetComponent( entity_id, "VariableStorageComponent" )
if ( c ~= nil ) then
	for i,v in ipairs( c ) do
		local n = ComponentGetValue2( v, "name" )
		if ( n == "shooter_part" ) then
			vcomp = v
			current = ComponentGetValue2( v, "value_int" )
			break
		end
	end
end

if ( current > 0 ) and ( vcomp ~= 0 ) then
	if ( current <= 11 ) and #(EntityGetInRadiusWithTag(x,y,300,"player_unit") or {}) > 0 then
		local ch = EntityGetAllChildren( entity_id )
		local i_ = 0
		
		if ( ch ~= nil ) then
			for i,v in ipairs( ch ) do
				local comp = EntityGetFirstComponent( v, "GenomeDataComponent" )
				if ( comp ~= nil ) then
					i_ = i_ + 1
					
					if ( i_ == current ) then
						for k=1, 2 do
							SetRandomSeed( GameGetFrameNum() + k, x + y + entity_id )
							local px,py = EntityGetTransform( v )
							local angle = math.rad(Random(0,359))

							local vel_x = math.cos( angle ) * length
							local vel_y = 0 - math.sin( angle ) * length

							local pid = shoot_projectile( entity_id, "mods/Apotheosis/files/entities/projectiles/blob_poison.xml", px, py, vel_x, vel_y )
							local pcomp = EntityGetFirstComponentIncludingDisabled(pid,"ProjectileComponent")
							ComponentSetValue2(pcomp,"mWhoShot",entity_id) 
							ComponentSetValue2(pcomp,"mShooterHerdId",StringToHerdId("boss_dragon"))
						end
						break
					end
				end
			end
		end
	end
	
	current = current + 1
	if ( current > 45 ) then
		current = 1
	end
	
	ComponentSetValue2( vcomp, "value_int", current )
end