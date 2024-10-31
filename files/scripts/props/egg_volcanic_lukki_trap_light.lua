local entity_id    = GetUpdatedEntityID()
local spritecomp = EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent")

function get_sine_anim( framecount, max_size, min_size )
    local delta, i = max_size - min_size, 2*( entity_id+GameGetFrameNum() )%( 2*framecount )
    return math.max( max_size - delta*math.abs( math.sin( i*math.pi/( 2*framecount ))), 1e-9 )/max_size
end

ComponentSetValue2(spritecomp,"special_scale_x",get_sine_anim( 120, 0.005, 0.001 ))
ComponentSetValue2(spritecomp,"special_scale_y",get_sine_anim( 120, 0.005, 0.001 ))