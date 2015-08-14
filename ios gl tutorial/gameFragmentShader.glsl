varying mediump vec2 outTexCoords;
uniform sampler2D Texture;

void main(void){
    lowp vec4 color =texture2D(Texture,outTexCoords);
    
    //uncomment to see bounding boxes
    /*if(color.w<0.5){
        color = vec4(0.75,0,0,1);
     }// */
    gl_FragColor = color;
}