attribute vec4 position;
attribute vec2 inTexCoords;
uniform vec2 positionOffset;
uniform float screenCorrection;
uniform mat4 transformation;
varying vec2 outTexCoords;

void main(void){
    outTexCoords = inTexCoords;
    gl_Position = transformation * position;
}
