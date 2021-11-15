shader_type canvas_item;

uniform float fator : hint_range(0, 1) ;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	color.rgb = mix(color.rgb, vec3(1.0, 1.0, 1.0), fator);
	COLOR = color;
}