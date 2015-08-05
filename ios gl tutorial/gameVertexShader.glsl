attribute vec4 position;
attribute vec2 inTexCoords;

uniform vec2 transformationOffset;
varying vec2 outTexCoords;

void main(void){
    mediump vec4 newPosition = position + vec4(transformationOffset,0,0);
    mediump float x = cos(newPosition.y) * newPosition.x;
    mediump float y = sin(newPosition.y) *newPosition.x;
    outTexCoords = inTexCoords;
    
    gl_Position = vec4(x,y,newPosition.z,1);

}

