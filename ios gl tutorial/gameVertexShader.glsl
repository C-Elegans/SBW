attribute vec4 position;
attribute vec2 inTexCoords;

uniform vec2 transformationOffset;
uniform float heightOffset;
uniform float screenCorrection;
uniform mediump float textureDivisor;
uniform float rotation;
uniform vec2 textureOffset;
<<<<<<< HEAD
uniform mat4 objectRotation;
varying vec3 outTexCoords;
=======
varying vec2 outTexCoords;
>>>>>>> parent of b324108... added perspective correction, not sure if necessary

void main(void){
	mediump vec4 newPosition = position * objectRotation;
	newPosition = vec4(newPosition.x,newPosition.y * (1.0/transformationOffset.x),newPosition.zw) + vec4(transformationOffset,0,0);
    mediump float x = cos(newPosition.y) * newPosition.x;
    mediump float y = sin(newPosition.y) * newPosition.x;
	if(rotation <0.0){
		outTexCoords = ((vec2(1.0-inTexCoords.x,inTexCoords.y)/textureDivisor)+textureOffset);
	}else{
    	outTexCoords = ((inTexCoords/textureDivisor)+textureOffset);
	}
    gl_Position = vec4(x*screenCorrection,y-heightOffset,newPosition.z,1);

}

