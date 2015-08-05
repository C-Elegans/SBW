attribute vec4 position;
attribute vec2 inTexCoords;

uniform vec2 transformationOffset;
varying vec2 outTexCoords;
void main(void){
    vec4 tempPosition;
    vec4 position2 = position + vec4(transformationOffset,0,0);
    tempPosition.x = position2.x* cos(position2.y);
    tempPosition.y = position2.x* sin(position2.y);
    tempPosition.zw = position2.zw;
    outTexCoords = inTexCoords;
    tempPosition = tempPosition - vec4(0,0,0,0);
    gl_Position = tempPosition;
}