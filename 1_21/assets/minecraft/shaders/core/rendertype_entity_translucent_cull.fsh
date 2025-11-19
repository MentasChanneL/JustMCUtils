#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform mat4 ModelViewMat;
uniform float GameTime;

in float vertexDistance;
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
    vec4 rgba = vec4(floor(rawColor.r * 255), floor(rawColor.g * 255), floor(rawColor.b * 255), floor(rawColor.a * 255));
    if (rgba.a == 252.0) { color = rawColor * filterColor; }
    if (rgba.a == 251.0) { color = rawColor * lightFace; }
    if(color.a < 0.1) discard;
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}