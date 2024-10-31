function vec_normalize(x, y)
	local m = math.sqrt( x ^ 2 + y ^ 2 )
	if m == 0 then return 0,0 end
	x = x / m
	y = y / m
	return x,y
end

local entity_id = GetUpdatedEntityID()
local pos_x,pos_y,rot = EntityGetTransform( entity_id )

local varcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local target_id = ComponentGetValue2(varcomp,"value_int") --Targetted sapper receiver
if target_id > 0 and EntityGetIsAlive(target_id) then
	local tar_x,tar_y = EntityGetTransform( target_id )

	--[[
	EntitySetTransform(entity_id, tar_x, tar_y)
	]]--

	local dist_x = tar_x - pos_x
	local dist_y = tar_y - pos_y

	local dist = math.sqrt( dist_x ^ 2 + dist_y ^ 2 )

	local dir_x,dir_y = vec_normalize(dist_x,dist_y)

	--v closest one to the target it's ever been while rotating but still is wonky :(
	local offset_x = dir_x * dist
	local offset_y = dir_y * dist

	--[[
	local angle = math.atan2(dist_y, dist_x)

	local offset_x = -math.cos( angle + rot ) * dist
	local offset_y = math.sin( angle + rot ) * dist
	]]--

	local spritepart_comps = EntityGetComponent(entity_id, "SpriteParticleEmitterComponent") or {}
	for i, comp in ipairs(spritepart_comps) do
		ComponentSetValue2(comp, "randomize_position", offset_x-1, offset_y-1, offset_x+1, offset_y+1 )
	end

	local particle_comps = EntityGetComponent(entity_id, "ParticleEmitterComponent") or {}
	for i, comp in ipairs(particle_comps) do
		ComponentSetValue2(comp, "x_pos_offset_min", offset_x-1)
		ComponentSetValue2(comp, "y_pos_offset_min", offset_y-1)
		ComponentSetValue2(comp, "x_pos_offset_max", offset_x+1)
		ComponentSetValue2(comp, "y_pos_offset_max", offset_y+1)
	end
end