
function check_newgame_plus_level( level, x )
	local newgame_n = tonumber( SessionNumbersGetValue("NEW_GAME_PLUS_COUNT") ) or 0
	
	return ( (newgame_n + math.abs(GetParallelWorldPosition( x, 0 ))) >= level )
end

function init_total_prob( value, x )
	value.total_prob = 0
	for i,v in ipairs(value) do
		if ( v.prob ~= nil and ( v.spawn_check == nil or v.spawn_check() ) and ( v.ngpluslevel == nil or check_newgame_plus_level( v.ngpluslevel, x ) ) and ( v.parallel == nil or check_parallel( v.parallel, x ) ) ) then
			value.total_prob = value.total_prob + v.prob
		end
	end
end

function random_from_table( what, x, y )
	if ( what.total_prob == 0 ) then
		init_total_prob( what, x )
	end

	local r = ProceduralRandom(x,y) * what.total_prob
	for i,v in ipairs(what) do
		if( v.prob ~= nil and ( v.spawn_check == nil or v.spawn_check() ) and ( v.ngpluslevel == nil or check_newgame_plus_level( v.ngpluslevel, x ) ) and ( v.parallel == nil or check_parallel( v.parallel, x ) ) ) then
			if( r <= v.prob ) then
				return v
			end
			r = r - v.prob
		end
	end

	return nil
end