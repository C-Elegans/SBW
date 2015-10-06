varying mediump vec2 outTexCoords;
uniform sampler2D Texture;
uniform mediump float alpha;
void main(void){
	mediump vec4 pixel = texture2D(Texture,outTexCoords);
	if(pixel.a < alpha){
		gl_FragColor = vec4(0,0,0,0);
	}else{
		gl_FragColor = vec4(pixel.rgb * (1.0/pixel.a), 1);
	}
}