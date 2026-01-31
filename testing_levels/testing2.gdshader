shader_type canvas_item;
render_mode blend_mul;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform vec3 color: source_color = vec3(1.0);

varying vec2 world_position;

void vertex() {
    world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
    // Read the color from the viewport texture using UV coordinates
    // COLOR = vec4(SCREEN_UV, 0.0, 1.0);
	vec4 screen_tex = textureLod(screen_texture, SCREEN_UV, 0.0);
	if (COLOR.a > 0.0) {
	} else {
		COLOR = vec4(color, 1.0);
	}
}