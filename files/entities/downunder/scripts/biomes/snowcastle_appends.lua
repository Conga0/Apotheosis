
function safe( x, y )
	if ( x >= 0 ) and ( x <= 380 ) and ( y >= 8000 ) and ( y <= 8200 ) then
		return false -- close to entrance
	end

	if y < 7250 then return false end -- close to portal
	
	return true
end