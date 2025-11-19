#version 150

#moj_import <light.glsl>
#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in vec2 UV1;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;
uniform mat3 IViewRotMat;

uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;
uniform sampler2D Sampler0;

out float vertexDistance;
out vec4 vertexColor;
out vec4 lightColor;
out vec4 faceLightColor;
out vec2 texCoord0;
out vec2 texCoord1;
out vec2 texCoord2;
out vec4 filterColor;
out vec4 lightFace;

void main() {
    
    float alpha = round(texture(Sampler0, UV0).a * 255);

    vec3 check = vec3(floor(Color.r * 255.0), floor(Color.g * 255.0), floor(Color.b * 255.0));

    vertexDistance = fog_distance(Position, FogShape);
    lightFace = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, Color);
    vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, Color) * texelFetch(Sampler2, UV2 / 16, 0);

    if (check.r == 254.0 && check.g == 1.0 && check.b == 1.0) {
        vertexColor = vec4(1.0);
    }

    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
    filterColor = Color;

    texCoord0 = UV0;
    texCoord1 = UV1;
    texCoord2 = UV2;
}
