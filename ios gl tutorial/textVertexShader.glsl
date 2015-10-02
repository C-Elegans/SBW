attribute vec4 position;
attribute vec2 inTexCoords;
uniform vec2 positionOffset;
uniform float screenCorrection;
uniform vec2 texCoordOffset;
varying vec2 outTexCoords;

void main(){
	
	outTexCoords = vec2(inTexCoords.x/14.0,inTexCoords.y/8.0) +texCoordOffset;
	gl_Position = vec4(position.x * screenCorrection,position.yzw) + vec4(positionOffset,0,0);
}