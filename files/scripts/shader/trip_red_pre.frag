

    float conga_effect_global_scale = conga_red_sand_effect_amount.x;
    conga_effect_global_scale = max(0.0,conga_effect_global_scale - 0.01);
    float conga_noise_perlin = texture2D(tex_perlin_noise, world_pos * 0.0006 + vec2(0.4, noise_time * 0.005 + 0.12)).x;
    vec2 conga_centred = tex_coord - vec2(0.5);	
    float conga_effect_local_scale_2 = length(conga_centred);
    vec2 conga_pointing = normalize(conga_centred);
    float conga_basic_size = length(conga_centred);
    conga_basic_size *= (1.0 + (conga_noise_perlin - 0.1) * 0.2 * conga_effect_global_scale); 
    float conga_old_basic_size = conga_basic_size;
    conga_basic_size = 1.0 - 1.0 / (1.0 + conga_basic_size);
    conga_basic_size = (conga_effect_global_scale * conga_basic_size + conga_old_basic_size) / (1.0 + conga_effect_global_scale);
    vec2 conga_old_pointing = conga_pointing;
    conga_pointing += vec2(sin(noise_perlin2.x), cos(noise_perlin2.x)) * 1.2;
    conga_pointing = normalize(conga_pointing);
    conga_pointing = (conga_effect_local_scale_2 * conga_effect_global_scale * conga_pointing + conga_old_pointing) / (1.0 + conga_effect_local_scale_2 * conga_effect_global_scale);
if (conga_red_sand_effect_amount.x > 0.02) {
    tex_coord = conga_basic_size * conga_pointing + vec2(0.5);
}
