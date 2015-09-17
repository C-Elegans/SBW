//
//  PauseScreen.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/17/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "PauseScreen.h"

@implementation PauseScreen
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
	self = [super initPosition:pos view:view];
	return self;
}
@end
