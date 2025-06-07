// Replace with uniform
    float lumi = dot(gl_FragColor.rgb, vec3(0.299, 0.587, 0.114));
    float overexpose = lumi * conga_constellation_transition_amount.x * 30.0; // Multiply by some large constant
    vec3 effectColor = gl_FragColor.rgb + overexpose;
    effectColor = mix(effectColor, vec3(1.0), conga_constellation_transition_amount.x * conga_constellation_transition_amount.x); // Mix into white to ensure full white screen at effect = 1.0
    gl_FragColor.rgb = min(vec3(1.0), effectColor);