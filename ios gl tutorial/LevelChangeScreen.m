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

@implementation LevelChangeScreen
-(id)initPosition:(vec3)pos{
	self = [super init];
	position = pos;
	vaoID = [LoaderHelper loadToVBOS:&changeVertices[0] verticesSize:sizeof(changeVertices) indices:&changeIndices[0] indicesSize:sizeof(changeIndices) objectName:@"LevelChangeScreen"];
	numVertices = sizeof(changeIndices)/sizeof(changeIndices[0]);
	texture = [LoaderHelper loadTexture:@"levelScreen.png"];
	return self;
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
	
}
@end
