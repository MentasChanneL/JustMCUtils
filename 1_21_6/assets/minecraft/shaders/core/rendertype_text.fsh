#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:globals.glsl>

uniform sampler2D Sampler0;

in float sphericalVertexDistance;
in float cylindricalVertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec2 texCoord1;
in float isAnimated;
in vec4 filterColor;
in vec4 gl_FragCoord;

out vec4 fragColor;

int colorRang(vec3 rgb, vec3 check, float d) {
    return rgb.r >= (check.r - d) && rgb.r <= (check.r + d) &&
           rgb.g >= (check.g - d) && rgb.g <= (check.g + d) &&
           rgb.b >= (check.b - d) && rgb.b <= (check.b + d) ? 1 : 0;
}

void main() {
    vec4 raw = texture(Sampler0, isAnimated > 0.5 ? texCoord1 : texCoord0);
    vec4 color = raw * vertexColor * ColorModulator;
    vec3 rgb = vec3(round(raw * 255.0));
    if (colorRang(rgb, vec3(254, 0, 254), 2.0) == 1) color = vec4(0);

    vec3 check = vec3( round( texture(Sampler0, texCoord0 - vec2(0.0012)) * 255.0 ) );
    float filterLen = (filterColor.r + filterColor.g + filterColor.b) / 3.0;
    if (
        (colorRang(check, vec3(255, 254, 253), 0.0) == 1 || colorRang(check, vec3(208, 207, 206), 0.0) == 1)
        && raw.a == 0.0 && filterLen > 0.3
    ) {
        color = vec4(filterColor / 1.7);
        color.a = 1;
    }
    if (
        (colorRang(rgb, vec3(255, 254, 253), 0.0) == 1 || colorRang(rgb, vec3(208, 207, 206), 2.0) == 1)
        && filterLen < 0.3
    ) discard;
    check = vec3( round( texture(Sampler0, texCoord0 - vec2(0, 0.0005)) * 255.0 ) );
    if (colorRang(check, vec3(255, 254, 253), 0.0) == 1 && colorRang(rgb, vec3(208, 207, 206), 0.0) == 1) {
        color = filterColor * 0.65;
        color.a = 1;
    }

    if (colorRang(rgb, vec3(255, 254, 253), 0.0) == 1) {
        float time = GameTime * 20000;
	float fully = mod(time, 100.0) / 100.0;
	float linePos = ScreenSize.x * fully * 4 - ScreenSize.x * 2;
	float distance = linePos - gl_FragCoord.x + (gl_FragCoord.y - gl_FragCoord.x) * 3;
	if (distance < 0) distance *= -1.0;
	fully = 1.0 - distance / (ScreenSize.x * 0.4);
	if (fully > 1.0) fully = 1.0;
	if (fully < 0.0) fully = 0.0;
	fully = floor(fully * 4.0) / 4.0;
	distance = linePos - (ScreenSize.x / 2.0 - ScreenSize.x * 0.4);
	if (distance < 0) distance *= -1.0;
	distance = 1.0 - distance / (ScreenSize.x - 0.3);
	if (distance < 0) distance = 0.0;
	fully *= 0.25 * distance;
	color = vec4(color.r + fully, color.g + fully, color.b + fully, color.a);
    }

    rgb = vec3(round(color * 255.0));
    if (colorRang(rgb, vec3(25, 24, 0), 1.0) == 1 || colorRang(rgb, vec3(62, 58, 0), 1.0) == 1) color = vec4(0);
    if (colorRang(rgb, vec3(43, 35, 0), 1.0) == 1 || colorRang(rgb, vec3(25, 21, 0), 1.0) == 1 || colorRang(rgb, vec3(62, 50, 0), 1.0) == 1) color = vec4(0);
    if (color.a < 0.1) {
        discard;
    }

    fragColor = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
}