shader_type canvas_item;

uniform vec2 real_center; // A posição do centro deve ser passada pelo script
uniform float force = 0.2;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;
uniform float size = 0.3;
uniform float thickness = 0.1;
uniform float small_smooth_val = 0.1;

void fragment() {
    vec2 center = real_center; // Usando a posição passada
    float ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
    vec2 scaledUV = (SCREEN_UV - vec2(0.5, 0.0)) / vec2(ratio, 1.0) + vec2(0.5, 0.0);
    
    float mask = (1.0 - smoothstep(size - thickness, size, length(scaledUV - center)));
    mask *= smoothstep(size - thickness - small_smooth_val, size - thickness, length(scaledUV - center));
    
    vec2 disp = normalize(scaledUV - center) * force * mask;
    COLOR = texture(SCREEN_TEXTURE, UV - disp);
}
