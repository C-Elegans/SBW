//
//  GuiShader.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/7/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GuiShader.h"
@interface GuiShader(){
    GLuint position_location;
    GLuint uv_location;
	GLuint transformation_location;
	GLuint alpha_location;
}
@end
@implementation GuiShader
-(id)init{
    self = [super initFromVertexFile:@"guiVertexShader" fragmentFile:@"guiFragmentShader"];
    position_location = glGetAttribLocation(program, "position");
    uv_location = glGetAttribLocation(program, "inTexCoords");
	transformation_location = glGetUniformLocation(program, "transformation");
	alpha_location = glGetUniformLocation(program, "alpha");
    
    if(position_location == -1 || uv_location == -1){
        NSLog(@"Invalid Attrib Location");
        exit(1);
    }
    
    return self;
}
-(void)start{
    glUseProgram(program);
}
-(void)stop{
    glUseProgram(0);
}
-(void)enableAttribs{
    glEnableVertexAttribArray(position_location);
    glEnableVertexAttribArray(uv_location);
}
-(void)disableAttribs{
    glDisableVertexAttribArray(position_location);
    glDisableVertexAttribArray(uv_location);
}

-(void)uploadAlpha:(float)alpha{
	glUniform1f(alpha_location, alpha);
}
-(void)uploadTransformation:(float)x y:(float)y width:(float)width height:(float)height correction:(CGSize)correction{
	float offset = correction.height/correction.width;
	GLKMatrix4 mat = GLKMatrix4Identity;
	mat = GLKMatrix4Scale(mat, width*offset, height, 1);
	mat = GLKMatrix4Translate(mat, x, y, 0);
	glUniformMatrix4fv(transformation_location, 1, NO, mat.m);
	
	
}


@end
