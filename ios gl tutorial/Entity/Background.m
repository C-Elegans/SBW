//
//  Background.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/14/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "Background.h"
#import "GameEntityProtectedMethods.h"
@implementation Background
const Vertex backgroundVertices[] = {
	{{20, 0, 0}, {0,1}},
	{{20, TWO_PI/4, 0}, {1,1}},
	{{20, TWO_PI/2, 0}, {1,0}},
	{{20, 3*TWO_PI/4, 0}, {0,0}}
};

const GLushort backgroundIndices[] = {
	0, 1, 2,
	2, 3, 0
};
-(id)initRadius:(float)r theta:(float)t{
	self = [super initRadius:r theta:t];
	self.textureDivisor = 0.1;
	[super loadToBuffers:&backgroundVertices[0] vSize:sizeof(backgroundVertices) indices:&backgroundIndices[0] iSize:sizeof(backgroundIndices)objectName:@"background"];
	
	[super loadToTexture:@"Background.png" mipmapsEnabled:true];
	return self;
}
-(CGRect)getCollisionBox{
	//return CGRectMake(0, 0, .5+[super radius], TWO_PI);
	return CGRectMake(0, 0, 0, 0);
}
-(BOOL)playerShouldCollide{
	return NO;
}
@end
