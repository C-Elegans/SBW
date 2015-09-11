varying mediump vec2 outTexCoords;
uniform sampler2D Texture;
uniform mediump float alpha;
void main(void){
	mediump vec4 pixel = texture2D(Texture,outTexCoords);
    gl_FragColor = vec4(pixel.rgb, pixel.a * alpha);
}