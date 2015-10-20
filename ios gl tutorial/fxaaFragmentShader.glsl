varying mediump vec2 outTexCoords;
uniform sampler2D Texture;
void main(void){
	lowp vec4 color= texture2D(Texture,outTexCoords);
	gl_FragColor = color;
	
}