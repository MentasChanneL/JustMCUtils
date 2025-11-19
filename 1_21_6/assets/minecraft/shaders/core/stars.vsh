#version 150

#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>

in vec3 Position;
out vec4 vertexColor;
out float starType;

const vec3[] COLORS = vec3[](
    vec3(0.022087, 0.098399, 0.110818),
    vec3(0.011892, 0.095924, 0.089485),
    vec3(0.027636, 0.101689, 0.100326),
    vec3(0.046564, 0.109883, 0.114838),
    vec3(0.064901, 0.117696, 0.097189),
    vec3(0.063761, 0.086895, 0.123646),
    vec3(0.084817, 0.111994, 0.166380),
    vec3(0.097489, 0.154120, 0.091064),
    vec3(0.106152, 0.131144, 0.195191),
    vec3(0.097721, 0.110188, 0.187229),
    vec3(0.133516, 0.138278, 0.148582),
    vec3(0.070006, 0.243332, 0.235792),
    vec3(0.196766, 0.142899, 0.214696),
    vec3(0.047281, 0.315338, 0.321970),
    vec3(0.204675, 0.390010, 0.302066),
    vec3(0.2, 0.231144, 0.195191)
);

void main() {
    starType = 0.0;
    vertexColor = vec4(COLORS[(gl_VertexID / 4) % 16], 1);
    if (gl_VertexID / 4 == 50) starType = 1;
    if (gl_VertexID / 4 == 140) vertexColor = vec4(1, 0.09, 0.09, 0.7);
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
}
