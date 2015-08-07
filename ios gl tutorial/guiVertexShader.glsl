attribute vec4 position;
attribute vec2 inTexCoords;
uniform vec2 positionOffset;
uniform float screenCorrection;
varying vec2 outTexCoords;

void main(void){
    outTexCoords = inTexCoords;
    gl_Position = position = vec4(positionOffset,0,0);
}
