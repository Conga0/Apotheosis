--I may or may not have just stolen from boss_centipede_before_fight.lua and changed some stuff... -S

local entity_id =  GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )
local destroy = false

local limb_positions = {}

local limbanimcomp = EntityGetFirstComponent( entity_id, "IKLimbsAnimatorComponent" )
EntitySetComponentIsEnabled( entity_id, limbanimcomp, false)

local children = EntityGetAllChildren( entity_id )

if children ~= nil then
	for i,it in ipairs(children) do
		if (limb_positions[i] == nil) then
			limb_positions[i] = {x, y}
		end

			local ox,oy = 0,0

			local limbcomp = EntityGetFirstComponent( it, "IKLimbComponent" )
		if (limbcomp ~= nil) then
			ox,oy = ComponentGetValue2( limbcomp, "end_position")
			
			ox = ox - x
			oy = oy - y
				
				ox = math.cos(i * 30) * 128
				oy = 0 - math.sin(i * 30) * 128

			local nx = x + ox
			local ny = y + oy
				
			limb_positions[i][3] = nx
			limb_positions[i][4] = ny

		local x_source = limb_positions[i][1]
		local y_source = limb_positions[i][2]
			
		local x_target = x_source
		local y_target = y_source

		if( limb_positions[i][3] ~= nil ) then x_target = limb_positions[i][3] end
		if( limb_positions[i][4] ~= nil ) then y_target = limb_positions[i][4] end

		local x_interpolation = (x_target - x_source) * 0.2
		local y_interpolation = (y_target - y_source) * 0.2
			
		limb_positions[i][1] = x_source + x_interpolation
		limb_positions[i][2] = y_source + y_interpolation

		ComponentSetValue2( limbcomp, "end_position", x_source + x_interpolation, y_source + y_interpolation)
		destroy = true
		end
	end
end

if destroy == true then
	local comp_id = GetUpdatedComponentID()
	EntityRemoveComponent(entity_id, comp_id)
end