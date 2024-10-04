shader_type canvas_item;

uniform float stars_density : hint_range(1, 1.0) = 0.5;
uniform float star_size : hint_range(0.1, 1.0) = 0.5;
uniform float twinkle_speed : hint_range(0.1, 1.0) = 1.0;
uniform vec4 star_color : source_color = vec4(1.0, 1.0, 0.8, 1.0);
uniform float shooting_star_speed : hint_range(0.1, 2.0) = 0.1;
uniform float shooting_star_frequency : hint_range(0.0, 1.0) = 0.1;

float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

float star(vec2 uv, float flare) {
    float d = length(uv);
    float m = star_size * 0.05 / d;

    float rays = max(0.0, 1.0 - abs(uv.x * uv.y * 1000.0));
    m += rays * flare;

    return smoothstep(0.8, 0.2, d) * m;
}

float shooting_star(vec2 uv, float seed, float time) {
    float speed = (seed + 1.0) * shooting_star_speed;
    float t = fract(time * speed + seed);
    vec2 pos = vec2(t * 2.0 - 1.0, seed * 2.0 - 1.0);
    float d = length(uv - pos);
    float trail = smoothstep(0.1, 0.0, d) * smoothstep(0.0, 0.5, t);
    return trail * smoothstep(1.0, 0.95, t);
}

void fragment() {
    vec2 uv = (UV - 0.5) * 2.0;
    vec3 color = vec3(0.0);

    for (int i = 0; i < 3; i++) {
        vec2 grid = fract(uv * (float(i + 1) * 5.0)) - 0.5;
        vec2 id = floor(uv * (float(i + 1) * 5.0));
        float n = random(id);

        if (n < stars_density) {
            float size = n * 0.2;
            float twinkle = sin(TIME * twinkle_speed + n * 6.2831) * 0.5 + 0.5;
            color += star(grid, size) * star_color.rgb * twinkle;
        }
    }

    // Shooting stars
    for (int i = 0; i < 5; i++) {
        float seed = random(vec2(float(i), 1.0));
        if (seed < shooting_star_frequency) {
            color += shooting_star(uv, seed, TIME) * star_color.rgb;
        }
    }

    COLOR = vec4(color, length(color));
}