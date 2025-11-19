#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>

uniform sampler2D Sampler0;

uniform float GameTime;

in float sphericalVertexDistance;
in float cylindricalVertexDistance;
in vec4 vertexColor;
in vec4 lightColor;
in vec4 faceLightColor;
in vec2 texCoord0;
in vec2 texCoord1;
in vec4 filterColor;
in vec4 lightFace;

out vec4 fragColor;

void main() {
    vec4 rawColor = texture(Sampler0, texCoord0);
    vec4 color = rawColor * vertexColor * ColorModulator;
    //vec4 rgba = vec4(floor(rawColor.r * 255), floor(rawColor.g * 255), floor(rawColor.b * 255), floor(rawColor.a * 255));
    //if (rgba.a == 252.0) { color = rawColor * filterColor; }
    //if (rgba.a == 251.0) { color = rawColor * lightFace; }
    //if (rgba.r == 255 && rgba.g == 254 && rgba.b == 253) color = rawColor * filterColor;
    //rgba = vec4(floor(filterColor * 255.0));
    //if (rgba.r == 252 && rgba.g == 1 && rgba.b == 1) color = rawColor;
    if(color.a < 0.1) discard;
    fragColor = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
}