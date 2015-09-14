//
//  Entity.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "LevelChangeScreen.h"
#import "OpenGLViewController.h"
#import "ChangeScreenNextButton.h"
#import "ChangeScreenMenuButton.h"
@interface LevelChangeScreen(){
	ChangeScreenNextButton* nextButton;
	ChangeScreenMenuButton* menuButton;
}
@end
const Vertex changeVertices[] = {
	{{1, -1, 0}, {1,1}},
	{{1, 1, 0}, {1,0}},
	{{-1, 1, 0}, {0,0}},
	{{-1, -1, 0}, {0,1}}
};

const GLushort changeIndices[] = {
	0, 1, 2,
	2, 3, 0
};

@implementation LevelChangeScreen
-(id)initPosition:(vec3)pos view:(UIView *)view{
	self = [super init];
	nextButton = [[ChangeScreenNextButton alloc]initWithPositionX:0.05 y:0 view:view];
	menuButton = [[ChangeScreenMenuButton alloc]initWithPositionX:-.95 y:0 view:view];
	position = pos;
	vaoID = [LoaderHelper loadToVBOS:&changeVertices[0] verticesSize:sizeof(changeVertices) indices:&changeIndices[0] indicesSize:sizeof(changeIndices) objectName:@"LevelChangeScreen"];
	numVertices = sizeof(changeIndices)/sizeof(changeIndices[0]);
	texture = [LoaderHelper loadTexture:@"levelScreen.png" enableMipmaps:false];
	return self;
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
	
	if(!ignoreTouch){
		[nextButton touchesEnded:touches withEvent:event];
		[menuButton touchesEnded:touches withEvent:event];
	}
	ignoreTouch = false;
}
-(NSArray*)getButtons{
	NSArray* array = [[NSArray alloc] initWithObjects:nextButton,menuButton, nil];
	return array;
}
@end
