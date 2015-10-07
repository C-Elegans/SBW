varying highp vec3 outTexCoords;
uniform sampler2D Texture;

void main(void){
	highp vec2 texCoords = outTexCoords.xy / outTexCoords.z;
	lowp vec4 color =texture2D(Texture,texCoords);
	if(texCoords.x < 0.0 || texCoords.y <0.0){
		color = vec4(0,0,0,0);
	}
	
    
    //uncomment to see bounding boxes
    /*if(color.w<0.5){
        color = vec4(0.75,0,0,1);
     }// */
	
    gl_FragColor = color;
}