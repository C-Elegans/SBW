//
//  Entity.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/3/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "LevelChangeScreen.h"
#import "OpenGLViewController.h"

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
Rectangle nextButton = {0.5136,0.30859,0.4736,0.16601};
@implementation LevelChangeScreen
-(id)initPosition:(vec3)pos{
	self = [super init];
	position = pos;
	vaoID = [LoaderHelper loadToVBOS:&changeVertices[0] verticesSize:sizeof(changeVertices) indices:&changeIndices[0] indicesSize:sizeof(changeIndices) objectName:@"LevelChangeScreen"];
	numVertices = sizeof(changeIndices)/sizeof(changeIndices[0]);
	texture = [LoaderHelper loadTexture:@"levelScreen.png"];
	return self;
}
-(BOOL)touchEnded:(CGPoint)point{
	//NSLog(@"Touch x: %f, y: %f",point.x,point.y);
	if(point.x >nextButton.x && point.x <(nextButton.x + nextButton.width)){
		if(point.y >nextButton.y && point.y <(nextButton.y + nextButton.height)){
			NSLog(@"Next Button Pressed!");
			[OpenGLViewController getController].currentLevel++;
			[[OpenGLViewController getController] setGameState:RUNNING];
			[[OpenGLViewController getController] resetPlayerAndInput];
			return true;
		}
	}
	return false;
}
@end
