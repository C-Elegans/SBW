varying mediump vec2 outTexCoords;
uniform sampler2D Texture;
uniform mediump float alpha;
void main(void){
    gl_FragColor = vec4(texture2D(Texture,outTexCoords).rgb, alpha);
}