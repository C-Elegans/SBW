//
//  GameShader.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/4/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//
//
//  MainShader.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameShader.h"
#import "MathHelper.h"

@interface GameShader(){
    GLuint position_location;
    GLuint uv_location;
    GLuint transformation_location;
    GLuint heightOffset_location;
    GLuint screenCorrection_location;
	GLuint textureDivisor_location;
	GLuint textureOffset_location;
	GLuint rotation_location;
	GLuint objectRotation_location;
}
@end
@implementation GameShader
-(id)init{
    self = [super initFromVertexFile:@"gameVertexShader" fragmentFile:@"gameFragmentShader"];
    
    position_location = glGetAttribLocation(program, "position");
    uv_location = glGetAttribLocation(program, "inTexCoords");
    
    transformation_location = glGetUniformLocation(program, "transformationOffset");
    heightOffset_location = glGetUniformLocation(program, "heightOffset");
    screenCorrection_location = glGetUniformLocation(program, "screenCorrection");
	textureDivisor_location = glGetUniformLocation(program, "textureDivisor");
	textureOffset_location = glGetUniformLocation(program, "textureOffset");
	rotation_location = glGetUniformLocation(program, "rotation");
	objectRotation_location = glGetUniformLocation(program, "objectRotation");
    if(position_location == -1 || uv_location == -1 || transformation_location == -1 || heightOffset_location == -1||screenCorrection_location == -1){
        NSLog(@"Invalid Attrib Location!");
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
    //glVertexAttribPointer(position_location, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), 0);
    //glVertexAttribPointer(uv_location, 2, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid*) (sizeof(float) * 3));
}
-(void)disableAttribs{
    glDisableVertexAttribArray(position_location);
    glDisableVertexAttribArray(uv_location);
}
-(void)uploadObjectTransformation:(float)r theta:(float)t{
    glUniform2f(transformation_location, r, t);
}
-(void)uploadHeightOffset:(float)offset{
    glUniform1f(heightOffset_location, offset);
}
-(void)uploadScreenCorrection:(CGSize)size{
    float offset = size.height/size.width;
    glUniform1f(screenCorrection_location, offset);
}
-(void)loadAnimation:(float)divisor textureOffset:(vec2)offset rotation:(int)rotation{
	glUniform1f(textureDivisor_location, divisor);
	glUniform2f(textureOffset_location, offset.x/divisor, offset.y/divisor);
	glUniform1f(rotation_location, (float)rotation);
}
-(void)loadObjectRotation:(float)rotation{
	GLKMatrix4 mat = GLKMatrix4Identity;
	mat = GLKMatrix4RotateZ(mat, rotation);
	glUniformMatrix4fv(objectRotation_location, 1, 0, mat.m);
}

@end
