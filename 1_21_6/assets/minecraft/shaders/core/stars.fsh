#version 150

#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:globals.glsl>

in vec4 vertexColor;
in float starType;

out vec4 fragColor;

const vec4[] SIRIUS_GRADIENT = vec4[](
    vec4(1, 1, 0.5, 1),
    vec4(0.8, 0.8, 1, 0.7),
    vec4(0.5, 0.6, 1, 0.9),
    vec4(1, 1, 0.8, 0.4),
    vec4(0.8, 0.8, 1, 0.7),
    vec4(1, 1, 0.5, 1)
);

void main() {
    fragColor = vertexColor * 2.0;
    if (starType == 1.0) {
        float cycleTime = mod(GameTime * 20000, 5.0) / 5.0;
        
        float segment = cycleTime * 5.0;
        int index = int(floor(segment));
        float t = fract(segment);
    
        vec4 color1 = SIRIUS_GRADIENT[index];
        vec4 color2 = SIRIUS_GRADIENT[(index + 1) % 4];
    
        fragColor = mix(color1, color2, t);
         
    }
}
