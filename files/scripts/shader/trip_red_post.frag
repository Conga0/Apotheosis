if (conga_red_sand_effect_amount.x > 0.02) {
	vec2 conga_uv = tex_coord - vec2(0.5); // center at center
	conga_uv /= 2.0; // make effect less chaos
	vec2 conga_uvo = conga_uv;
	vec3 conga_add = vec3(0.0);
	float conga_global_noise = texture2D( tex_perlin_noise, vec2(noise_time * 0.0041246, noise_time * 0.00523541)).x;
	float conga_z = conga_global_noise * 0.5 + 0.25;
	for (int i = 0; i < 5; i++) // repeatedly mutate
	{
		conga_uv = fract(conga_uv * 1.5) - 0.5; // mutate uv
		conga_uv *= .550 + conga_z / 1.4;
		conga_uv += vec2(sin(conga_uvo.x * float(i)),cos(conga_uvo.y * float(i))) / 10.0;
		conga_uv += sin(conga_uvo * 20.0) / 15.0;
		
		float conga_d = length(conga_uv) * exp(-length(conga_uvo)); // get scale of colour
		vec3 conga_col = conga_get_colour(vec3(conga_uv, conga_z + float(i) * 0.1)); // get funny colours
		conga_col *= 1.0 - 0.3 * abs(conga_z);  

		conga_d = abs(sin(conga_d * 10.0 + time) / 12.0); // create bright spots
		conga_d = smoothstep(0.0, 0.2, conga_d);
		conga_d = pow(0.01 / conga_d, 1.2);
		
		conga_add += conga_col * conga_d * (0.5 + 0.5 * sin(time + float(i)));
	}

	conga_add *= vec3(1.0,0.7,0.7);
	conga_add = normalize(conga_add) * (1.0 - 1.0 / (length(conga_add) + 1.0));
	//conga_add = normalize(conga_add) * pow(length(conga_add) / length(vec3(1.0)), 5.0) * length(vec3(1.0));
	float conga_effect_local_scale = length(conga_uvo) * 1.0;
	vec3 conga_oc = color;
	color = color + conga_add * conga_effect_global_scale;
	color = (color * conga_effect_local_scale + conga_oc) / (conga_effect_local_scale + 1.0);
	vec3 conga_hsv = conga_rgb2hsv(color);
	conga_hsv.x = fract(conga_hsv.x + (conga_noise_perlin * 2.0 - 1.0 / 2.0) * conga_effect_global_scale);
	if (conga_hsv.x < 0.5) // modular average
	{
		conga_hsv.x = conga_hsv.x / (1.0 + conga_effect_global_scale);
	}
	else
	{
		conga_hsv.x = (conga_hsv.x + conga_effect_global_scale) / (1.0 + conga_effect_global_scale); 
	}

	color = conga_hsv2rgb(conga_hsv);
}
