//
//  FXAAShader.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/19/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "FXAAShader.h"


@interface FXAAShader(){
	GLuint position_location;
	GLuint uv_location;

}
@end
@implementation FXAAShader
-(id)init{
	self = [super initFromVertexFile:@"fxaaVertexShader" fragmentFile:@"fxaaFragmentShader"];
	position_location = glGetAttribLocation(program, "position");
	uv_location = glGetAttribLocation(program, "inTexCoords");

	
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




@end
