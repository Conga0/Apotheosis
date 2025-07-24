-- a*b	 = |a|*|b|*cos(theta)
-- theta = arccos((a*b)/(|a|*|b|))

-- 
-- 
-- 
local entity_id = GetUpdatedEntityID()
local ix, iy, r = EntityGetTransform(entity_id)
local cx, cy = DEBUG_GetMouseWorld()
local angle = math.atan2( iy-cx, ix-cx )

local function draw_angle(x, y, a, mat)
	local vel_x_new = math.cos( a )
	local vel_y_new = math.sin( a )
	local dist = 42
	for i=0, dist do
		GameCreateCosmeticParticle(mat, x+vel_x_new*i, y+vel_y_new*i, 1, 0, 0, 0, 0.05, 0.05, true, true, false, false, 0, 0)
	end
end
draw_angle(ix, iy, r, "spark_red")
draw_angle(ix, iy, angle, "spark_blue")
--[[
local function mag(x, y)
	return (x*x+y*y)^2
end

--print(math.deg(math.acos((cx*ex+cx*cy)/(mag(cx, cy)*mag(ex, ey)))))

GamePrint(tostring(math.acos((cx*ex+cx*cy)/(mag(cx, cy)*mag(ex, ey)))))
]]
--math.acos(a)


local ex, ey = math.sin(r), math.cos(r)
local tx, ty = cx-ix, cy-iy
local ansAgain = math.acos((tx*ex+ty*ey)/((tx*tx+ty*ty)*(ex*ex+ey*ey)))
GamePrint(tostring(math.deg(ansAgain)))

--[[
local e = EntityCreateNew("TEST")
EntityAddComponent2(e, "LuaComponent", {
	script_source_file="mods/Apotheosis/files/scripts/experimental/infohazard.lua"
})
EntitySetTransform(e, DEBUG_GetMouseWorld())
]]
