//
//  Door.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/10/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "Door.h"
#import "GameEntityProtectedMethods.h"
@implementation Door
const Vertex doorVertices[] = {
	{{0, 0, 0}, {0,1}},
	{{0, .2, 0}, {1,1}},
	{{.2, .2, 0}, {1,0}},
	{{.2, 0, 0}, {0,0}}
};

const GLushort doorIndices[] = {
	0, 1, 2,
	2, 3, 0
};
-(id)initRadius:(float)r theta:(float)t{
	self = [super initRadius:r theta:t];
	
	[super loadToBuffers:&doorVertices[0] vSize:sizeof(doorVertices) indices:&doorIndices[0] iSize:sizeof(doorIndices)objectName:@"door"];
	[super loadToTexture:@"door.png"];
	return self;
}
-(CGRect)getCollisionBox{
	return CGRectMake(0+self.radius, 0.09+self.theta, .2, .11*(1/self.radius));
}
@end
