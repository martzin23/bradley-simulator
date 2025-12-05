shader_type canvas_item;

uniform float noise_amount = 1.0; // Adjust grain intensity
uniform float fade_in_speed = 1.0; // Speed of fade-in effect
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

float hash(float n) {
	return fract(sin(n) * 43758.5453123);
}

void fragment() {
	vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 uv = FRAGCOORD.xy / resolution;
	
	// Base screen texture
	vec3 color = texture(SCREEN_TEXTURE, uv).rgb;
	color = pow(color * 5.0, vec3(2.0));

	// Add noise and vignette effects
	color += sin(hash(TIME)) * 0.01;
	color += hash((hash(uv.x) + uv.y) * TIME) * (0.5 * noise_amount);
	//color *= smoothstep(length(uv * uv * vec2(0.075, 0.4)), 1.0, 0.4);
	//color *= smoothstep(0.001, 3.5 * fade_in_speed, TIME) * 1.5;
	
	// Convert to green-tinted grayscale
	color = dot(color, vec3(0.2126, 0.7152, 0.0722)) * vec3(0.2, 1.5 - hash(TIME) * 0.1, 0.4);
	COLOR = vec4(color, 1.0);
}