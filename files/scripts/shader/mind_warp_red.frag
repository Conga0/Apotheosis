

	// Red effect around edges
	if(conga_mind_warp_effect_amount.x > 0.0){
		float luminance = dot(gl_FragColor.rgb, vec3(0.299, 0.587, 0.114));
		float distanceToCenter = length(tex_coord_ - vec2(0.5));

		// Adjust effect drop off to liking
		float effectDropOff = min(distanceToCenter * 3.0, 1.0) * conga_mind_warp_effect_amount.x;

		// Color to shift towards
		vec3 bloodColor = vec3(120.0/255.0, 6.0/255.0, 6.0/255.0) * 1.5;

		gl_FragColor.rgb = mix(gl_FragColor.rgb, bloodColor * luminance, effectDropOff);
	}
