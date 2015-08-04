varying mediump vec2 outTexCoords;
uniform sampler2D Texture;
void main(void){
    gl_FragColor = texture2D(Texture,outTexCoords);
}