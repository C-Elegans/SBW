//
//  GuiShader.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/7/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "BarShader.h"
#import "MathHelper.h"
@interface BarShader(){
	GLuint position_location;
	GLuint uv_location;
	GLuint positionOffset_location;
	GLuint screenCorrection_location;
	GLuint alpha_location;
	
}
@end
@implementation BarShader
-(id)init{
	self = [super initFromVertexFile:@"barVertexShader" fragmentFile:@"barFragmentShader"];
	position_location = glGetAttribLocation(program, "position");
	uv_location = glGetAttribLocation(program, "inTexCoords");
	positionOffset_location = glGetUniformLocation(program, "positionOffset");
	screenCorrection_location = glGetUniformLocation(program, "screenCorrection");
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
-(void)uploadObjectTransformation:(float)x y:(float)y{
	glUniform2f(positionOffset_location, x, y);
}
-(void)uploadScreenCorrection:(CGSize)size{
	float offset = size.height/size.width;
	glUniform1f(screenCorrection_location, offset);
}
-(void)uploadAlpha:(float)alpha{
	alpha = [MathHelper clamp:1-alpha min:0 max:0.99];
	glUniform1f(alpha_location, alpha);
}


@end
