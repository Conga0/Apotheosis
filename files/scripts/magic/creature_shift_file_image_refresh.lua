
function update_ui_graphic( ui_name, offset_y )
	--Quick test to see if the requested entity has been prepared by the virtual file system.
	if ModImageDoesExist(table.concat({"data/ui_gfx/animal_icons/creature_shift/",ui_name,".png"})) == false then return false end

	--print("ui name is " .. ui_name)
	local csi_id = ModImageIdFromFilename( "data/ui_gfx/animal_icons/creature_shift/creature_shift_ui.png")
	local csi_from_id = ModImageIdFromFilename( table.concat({"data/ui_gfx/animal_icons/",ui_name,".png"}))
	local csi_from_id_output = ModImageIdFromFilename( table.concat({"data/ui_gfx/animal_icons/creature_shift/",ui_name,".png"}))
	--print("csi_from_id path is " .. table.concat({"data/ui_gfx/animal_icons/",ui_name,".png"}))
	--print("csi_from_id_output path is " .. table.concat({"data/ui_gfx/animal_icons/creature_shift/",ui_name,".png"}))
	if csi_from_id == 0 then print("Invalid image ID") return false end
	local bg_color = ModImageGetPixel( csi_id, 5, 4 )
	for x=1,16 do
		for y=1,16 do
			--Paint the base layer for the ui portrait
			ModImageSetPixel( csi_from_id_output, x, y, ModImageGetPixel( csi_id, x, y ) )
			--Paint the ui icon over the base layer
			if (x > 3 and y > 2) and (x < 13 and y < 12) then
				local colour = ModImageGetPixel( csi_from_id, x, y )
				local a = bit.band(bit.rshift(colour, 24), 0xFF)/255
				if a<1 and a>0 then
					local from = {
						R=bit.band(bit.rshift(colour, 0), 0xFF),
						G=bit.band(bit.rshift(colour, 8), 0xFF),
						B=bit.band(bit.rshift(colour, 16), 0xFF),
					}
					local base = {
						R=bit.band(bit.rshift(bg_color, 0), 0xFF),
						G=bit.band(bit.rshift(bg_color, 8), 0xFF),
						B=bit.band(bit.rshift(bg_color, 16), 0xFF),
					}
					local result = {
						R=math.ceil(base.R*(1-a)+from.R*(a)),
						G=math.ceil(base.G*(1-a)+from.G*(a)),
						B=math.ceil(base.B*(1-a)+from.B*(a)),
					}
					--print(result.R, result.G, result.B)
					ModImageSetPixel( csi_from_id_output, x, y + offset_y, bit.bor(bit.lshift(result.R, 0), bit.lshift(result.G, 8), bit.lshift(result.B, 16), bit.lshift(0xFF, 24)) )
				elseif colour ~= 0 then
					ModImageSetPixel( csi_from_id_output, x, y + offset_y, colour )
				end
			end
		end
	end

	--[[
	print(bit.band(bit.rshift(dec, 0), 0xFF))	R
	print(bit.band(bit.rshift(dec, 8), 0xFF))	G
	print(bit.band(bit.rshift(dec, 16), 0xFF))	B
	print(bit.band(bit.rshift(dec, 24), 0xFF))	A
]]

	--Clean up the border to look pretty
	local border_colour = ModImageGetPixel(csi_id, 5,2)
	ModImageSetPixel( csi_from_id_output, 4, 3, border_colour )
	ModImageSetPixel( csi_from_id_output, 12, 3, border_colour )
	ModImageSetPixel( csi_from_id_output, 4, 11, border_colour )
	ModImageSetPixel( csi_from_id_output, 12, 11, border_colour )
	return true
end

--Regenerates creature shift icons for use in saved games
local iter_count = tonumber( GlobalsGetValue( "apotheosis_creature_shift_iteration", "0" ) )

for k=1,iter_count do
	local target = GlobalsGetValue(table.concat({"apotheosis_global_Cshift_",k,"_targ2"}), "failed")
	if target ~= "failed" then
		local offset = 0
		if target == "miniblob" then offset = -4 end
		update_ui_graphic( target, offset )
	end
end
