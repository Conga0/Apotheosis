

	// Wavy distortion effect
	if(conga_mind_warp_effect_amount.x > 0.0) {
		vec2 aspectRatio = vec2( window_size.x / window_size.y, 1.0 );

		// Distance from center of screen
		float distortion_amount =  length(tex_coord_ - vec2(0.5)) * conga_mind_warp_effect_amount.x;

		// Effect can be changed by messing with the uv offset
		float timeFactor = (time + tex_coord_.x + tex_coord_.y) * 2.0;
		vec2 uv_offset = distortion_amount * vec2(sin(timeFactor), cos(timeFactor)) / aspectRatio * 0.03;

		// Apply offset
		tex_coord += uv_offset;
		tex_coord_glow += uv_offset * vec2(1.0,-1.0);

		// Zoom in a bit
		float scaleAmount = 1.0 - 0.05 * conga_mind_warp_effect_amount.x;
		tex_coord = ((tex_coord - vec2(0.5)) * scaleAmount) + vec2(0.5);
		tex_coord_glow = ((tex_coord_glow - vec2(0.5)) * scaleAmount) + vec2(0.5);
	}
