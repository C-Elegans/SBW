//
//  TextShader.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/30/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "TextShader.h"


@interface TextShader(){
	GLuint position_location;
	GLuint uv_location;
	GLuint positionOffset_location;
	GLuint screenCorrection_location;
	GLuint color_location;
	GLuint texCoordOffset_location;
}
@end
@implementation TextShader
-(id)init{
	self = [super initFromVertexFile:@"textVertexShader" fragmentFile:@"textFragmentShader"];
	position_location = glGetAttribLocation(program, "position");
	uv_location = glGetAttribLocation(program, "inTexCoords");
	positionOffset_location = glGetUniformLocation(program, "positionOffset");
	screenCorrection_location = glGetUniformLocation(program, "screenCorrection");
	texCoordOffset_location = glGetUniformLocation(program, "texCoordOffset");
	color_location = glGetUniformLocation(program, "color");
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
-(void)uploadTexCoordOffset:(vec2)offset{
	glUniform2f(texCoordOffset_location, offset.x, offset.y);
}
-(void)uploadColor:(vec4)color{
	glUniform4f(color_location, color.x, color.y, color.z, color.r);
}

@end