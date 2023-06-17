#version 460 core

#include <flutter/runtime_effect.glsl>

// uniform float uTime;
uniform vec2 uOrigin;
uniform vec2 uSize;
uniform vec4 uColor;
uniform float uSpread;

out vec4 FragColor;

mat3 m = mat3(
  vec3(0.167444, 0.329213, -0.496657),
  vec3(-0.327948, 0.035669, 0.292279),
  vec3(1.250268, -1.047561, -0.202707)
);

vec3 v = vec3(0.299, 0.587, 0.114);

vec3 shiftHue(vec3 color, float deltaHue) {
  float s = sin(deltaHue);
  float c = cos(deltaHue);
  
  return (color * c) + (color * s) * m + dot(v, color) * (1.0 - c);
}

void main() {
  vec2 pixel = (uOrigin + FlutterFragCoord()) / uSize;

  vec4 from = vec4(shiftHue(uColor.rgb, -radians(uSpread / 2)), uColor.a); // vec4(shiftHue(uColor.rgb, sin(uTime)), uColor.a);
  vec4 to = vec4(shiftHue(uColor.rgb, radians(uSpread / 2)), uColor.a);

  FragColor = mix(from, to, ((1 - pixel.x) + pixel.y) / 2);
}
