//
//  Tree.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/21/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//
#import "Tree.h"
#import "GameEntityProtectedMethods.h"
#import "OpenGLViewController.h"
@interface Tree(){
	float time;
}
@end
@implementation Tree
const Vertex treeVertices[] = {
	{{0, -0.01, 0}, {0,1}},
	{{0, .21, 0}, {1,1}},
	{{.2, .2, 0}, {1,0}},
	{{.2, 0, 0}, {0,0}}
};

const GLushort treeIndices[] = {
	0, 1, 2,
	2, 3, 0
};
-(id)initRadius:(float)r theta:(float)t{
	self = [super initRadius:r theta:t];
	self.textureDivisor = 2;
	self.textureOffset =(vec2) {1,0};
	[super loadToBuffers:&treeVertices[0] vSize:sizeof(treeVertices) indices:&treeIndices[0] iSize:sizeof(treeIndices)objectName:@"tree"];
	[super loadToTexture:@"tree.png" mipmapsEnabled:true];
	return self;
}
-(CGRect)getCollisionBox{
	return CGRectMake(-0.01+self.radius, self.theta, .21, .2*(1/self.radius));
}
-(void)onCollisionWith:(GameEntity *)player{
	[[OpenGLViewController getController] deleteObject:self];
	NSLog(@"Tree Collided");
}
-(BOOL)playerShouldCollide{
	return NO;
}
@end