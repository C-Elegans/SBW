varying mediump vec2 outTexCoords;
uniform sampler2D Texture;
void main(void){
    gl_FragColor = vec4(texture2D(Texture,outTexCoords).rgb, 0.1);
}