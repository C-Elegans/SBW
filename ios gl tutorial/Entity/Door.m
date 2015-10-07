//
//  Door.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/10/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "Door.h"
#import "GameEntityProtectedMethods.h"
#import "OpenGLViewController.h"
@interface Door(){
	float time;
}
@end
@implementation Door
const Vertex doorVertices[] = {
	{{0, -0.01, 0}, {0,1}},
	{{0, .21, 0}, {1,1}},
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
	[super loadToTexture:@"door.png" mipmapsEnabled:true];
	return self;
}
-(CGRect)getCollisionBox{
	return CGRectMake(0+self.radius, (-0.05*(1/self.radius))+self.theta, .2, .15*(1/self.radius));
}
-(void)onCollisionWith:(GameEntity *)player{
	time += [OpenGLViewController getController].frameTime;
	if(time > .3){
		[OpenGLViewController getController].gameState = LEVEL_CHANGE;
		time = 0;
	}
}
-(BOOL)playerShouldCollide{
	return NO;
}
@end
