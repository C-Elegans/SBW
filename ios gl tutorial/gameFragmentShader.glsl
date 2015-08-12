varying mediump vec2 outTexCoords;
uniform sampler2D Texture;

void main(void){
    lowp vec4 color =texture2D(Texture,outTexCoords);
    
    //if(color.w<0.5){
    //    discard;
    //}
    gl_FragColor = color;
}