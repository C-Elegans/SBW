varying mediump vec2 outTexCoords;
uniform sampler2D Texture;
uniform lowp vec4 color;
void main(void){
	mediump vec4 pixel = texture2D(Texture,outTexCoords);
	gl_FragColor = pixel;
}