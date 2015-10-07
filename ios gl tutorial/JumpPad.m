//
//  jumpPad.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/5/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "JumpPad.h"
#import "OpenGLViewController.h"
#import "Player.h"
#import "GameEntityProtectedMethods.h"
@interface JumpPad(){
	float time;
	int animationState;
}
@end
@implementation JumpPad
const Vertex jumpPadVertices[] = {
	{{0, 0, 0}, {0,1}},
	{{0, .2, 0}, {1,1}},
	{{.2, .2, 0}, {1,0}},
	{{.2, 0, 0}, {0,0}}
};

const GLushort jumpPadIndices[] = {
	0, 1, 2,
	2, 3, 0
};
const vec2 jumpAnimationStates[] = {
	{0,0},{1,0},{0,1},{1,1}
};
-(id)initRadius:(float)r theta:(float)t{
	self = [super initRadius:r theta:t];
	self.textureDivisor = 2;
	self.textureOffset = (vec2){0,0};
	[super loadToBuffers:&jumpPadVertices[0] vSize:sizeof(jumpPadVertices) indices:&jumpPadIndices[0] iSize:sizeof(jumpPadIndices)objectName:@"jumpPad"];
	[super loadToTexture:@"jumpPad.png" mipmapsEnabled:true];
	return self;
}
-(CGRect)getCollisionBox{
	return CGRectMake(0+self.radius, 0+self.theta, .05, .2*(1/self.radius));
}
-(void)update{
	time +=[OpenGLViewController getController].frameTime;

	if(time >0.1){
		animationState++;
		animationState &=3;
		time =0;
	}
		
	
	
	self.textureOffset = jumpAnimationStates[animationState];
}
-(BOOL)playerShouldCollide{
	return NO;
}
-(void)onCollisionWith:(GameEntity *)player{
	Player* p = (Player*)player;
	[p jump:GRAVITY/1.5];
	
}
@end
