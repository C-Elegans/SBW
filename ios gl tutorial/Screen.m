//
//  Screen.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/17/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "Screen.h"
#import "LoaderHelper.h"
@implementation Screen
const Vertex Vertices[] = {
	{{1, -1, 0}, {1,1}},
	{{1, 1, 0}, {1,0}},
	{{-1, 1, 0}, {0,0}},
	{{-1, -1, 0}, {0,1}}
};

const GLushort Indices[] = {
	0, 1, 2,
	2, 3, 0
};
-(id)initPosition:(vec3)pos view:(nonnull UIView *)view{
	self = [super init ];
	vaoID = [LoaderHelper loadToVBOS:&Vertices[0] verticesSize:sizeof(Vertices) indices:&Indices[0] indicesSize:sizeof(Indices) objectName:@"screen"];;
	numVertices = sizeof(Indices)/sizeof(Indices[0]);
	position = pos;
	return self;
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	
}
-(NSArray*)getButtons{
	return nil;
}
-(NSArray *)getText{
	return nil;
}
-(void)update{
	
}

@end
