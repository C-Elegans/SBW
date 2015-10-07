attribute vec4 position;
attribute vec3 inTexCoords;

uniform vec2 transformationOffset;
uniform float heightOffset;
uniform float screenCorrection;
uniform mediump float textureDivisor;
uniform float rotation;
uniform vec2 textureOffset;
varying vec3 outTexCoords;

void main(void){
    mediump vec4 newPosition = vec4(position.x,position.y * (1.0/transformationOffset.x),position.zw) + vec4(transformationOffset,0,0);
    mediump float x = cos(newPosition.y) * newPosition.x;
    mediump float y = sin(newPosition.y) * newPosition.x;
	if(rotation <0.0){
		outTexCoords.xy = ((vec2(1.0-inTexCoords.x,inTexCoords.y)/textureDivisor)+textureOffset);
	}else{
    	outTexCoords.xy = ((inTexCoords.xy/textureDivisor)+textureOffset);
	}
	outTexCoords.z = inTexCoords.z;
    gl_Position = vec4(x*screenCorrection,y-heightOffset,newPosition.z,1);

}

