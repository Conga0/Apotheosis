uniform vec4 conga_red_sand_effect_amount;

vec3 conga_get_colour(vec3 coord) {
    vec3 base = vec3(0.6, 0.3, 0.3);
    vec3 amplitude = vec3(1.2, 0.3, 0.2);
    vec3 variance = vec3(1.5, 1.3, 1.0);
    vec3 offset = vec3(0.0, 0.0, 1.0);
    return base + amplitude * cos(6.5 * (variance * coord + offset));
}

// https://gist.github.com/983/e170a24ae8eba2cd174f

vec3 conga_rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 conga_hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}
