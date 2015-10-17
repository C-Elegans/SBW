attribute vec4 position;
attribute vec2 inTexCoords;
uniform vec2 positionOffset;
uniform float screenCorrection;
uniform vec2 texCoordOffset;
varying vec2 outTexCoords;
uniform float sizeCorrection;
void main(){
	
	outTexCoords = vec2(inTexCoords.x/14.0,inTexCoords.y/8.0) +texCoordOffset;
	gl_Position = vec4((position.x),(position.yzw * sizeCorrection))*sizeCorrection + vec4(positionOffset,0,0);
	gl_Position.w = 1.0;
}