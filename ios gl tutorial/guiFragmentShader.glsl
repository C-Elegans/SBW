varying mediump vec2 outTexCoords;
uniform sampler2D Texture;
void main(void){
    gl_Fragcolor = texture2D(Texture,outTexCoords);
}