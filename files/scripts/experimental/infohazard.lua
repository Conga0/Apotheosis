-- a*b	 = |a|*|b|*cos(theta)
-- theta = arccos((a*b)/(|a|*|b|))

-- 
-- 
-- math.acos((ex*cy+ey*cy)/((ex*ex+ey*ey)^0.5)*((cx*cx+cy*cy)^0.5))
local entity_id = GetUpdatedEntityID()
local ex, ey, er = EntityGetTransform(entity_id)
local cx, cy = DEBUG_GetMouseWorld()
local angle = math.atan2( cy-ey, cx-ex )

local function draw_angle(x, y, a, mat)
	local vel_x_new = math.cos( a )
	local vel_y_new = math.sin( a )
	local dist = 42
	for i=0, dist do
		GameCreateCosmeticParticle(mat, x+vel_x_new*i, y+vel_y_new*i, 1, 0, 0, 0, 0.05, 0.05, true, true, false, false, 0, 0)
	end
end

draw_angle(ex, ey, er, "spark_red")
draw_angle(ex, ey, angle, "spark_blue")
GamePrint(tostring(math.acos((ex*cy+ey*cy)/((ex*ex+ey*ey)^0.5)*((cx*cx+cy*cy)^0.5))))

--math.acos(a)

--[[
local e = EntityCreateNew("TEST")
EntityAddComponent2(e, "LuaComponent", {
	script_source_file="mods/apotheosis/files/scripts/experimental/infohazard.lua"
})
EntitySetTransform(e, DEBUG_GetMouseWorld())
]]
