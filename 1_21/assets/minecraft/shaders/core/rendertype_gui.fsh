#version 150

in vec4 vertexColor;

uniform vec4 ColorModulator;

out vec4 fragColor;

void main() {
    vec4 color = vertexColor;
    if (color.a == 0.0) {
        discard;
    }
    vec4 rgb = vec4(round(color * 255.0));
    if (rgb.g == 0 && rgb.b > 0 && rgb.r < 81) {
        color.r = color.b;
        color.g = color.b * 0.75;
        color.b = 0.0;
        color.a = 0.87;
    }
    if (rgb.r == 0 && rgb.g == 0 && rgb.b == 0 && (rgb.a == 102 || rgb.a == 76)) discard;
    if (rgb.r == 51 && rgb.g == 51 && rgb.b == 170) color = vec4(230.0, 197.0, 15.0, 50.0) / 255.0;
    fragColor = color * ColorModulator;
}
