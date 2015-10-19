attribute vec4 position;
attribute vec2 inTexCoords;

varying vec2 outTexCoords;
void main(void){
	
	outTexCoords = inTexCoords;
	gl_Position = position;
}