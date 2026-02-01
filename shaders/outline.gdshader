shader_type canvas_item;

uniform float outline_thickness: hint_range(1, 100, .1) = 8.0;
uniform float anti_alias_amount = 1.0;
uniform vec4 outline_color : source_color = vec4(1);

void fragment() {

    float max_distance = outline_thickness + anti_alias_amount;
    int max_offset = int(ceil(max_distance));
    float closest_outline_distance = max_distance;

    bool is_edge = false;
    for (int x = -max_offset; x <= max_offset; x++) {
        for (int y = -max_offset; y <= max_offset; y++) {

            vec2 offset = vec2(float(x), float(y));
            float dist = length(offset);

            if (dist > max_distance || COLOR.a == 0.0) continue;

            if (texture(TEXTURE, UV + offset * TEXTURE_PIXEL_SIZE).a > 0.0) {
                closest_outline_distance = min(closest_outline_distance, dist);
            }
            else {
                is_edge = true;
            }
        }
    }

    if (is_edge) {
        float alpha = 1.0 - smoothstep(outline_thickness - anti_alias_amount, outline_thickness + anti_alias_amount, closest_outline_distance);
        COLOR = vec4(outline_color.rgb, alpha);
    } else if (UV.x < max_distance * TEXTURE_PIXEL_SIZE.x || UV.y < max_distance * TEXTURE_PIXEL_SIZE.y || UV.x > 1.0 - max_distance * TEXTURE_PIXEL_SIZE.x || UV.y > 1.0 - max_distance * TEXTURE_PIXEL_SIZE.y) {
        if (COLOR.a > 0.0) {
            COLOR = vec4(outline_color.rgb, 1.0);
        }
    } else {
        COLOR = vec4(COLOR.rgb, 0.0);
    }
}