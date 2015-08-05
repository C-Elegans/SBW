attribute vec4 position;
attribute vec2 inTexCoords;

uniform vec2 transformationOffset;
varying vec2 outTexCoords;
void main(void){
    vec4 tempPosition;
    tempPosition.x = cos(position.x);
    tempPosition.y = sin(position.y);
    tempPosition.zw = position.zw;
    outTexCoords = inTexCoords;
    gl_Position = position+vec4(transformationOffset,0,0);
}