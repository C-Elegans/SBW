//
//  Player.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/6/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "Player.h"
#import "GameEntityProtectedMethods.h"
#import "Planet.h"
#import "Door.h"
#import "OpenGLViewController.h"
#import "MathHelper.h"

#define MOVE_SPEED 0.6


@interface Player(){

	int animationState;
	float time;
	
}

@end
@implementation Player
static Player* thePlayer = nil;
static dispatch_once_t token;
const int playerWidth = 0.359375;
@synthesize health = _health;
const Vertex playerVertices[] = {
    {{0, -0.115, 0}, {0,1}},
    {{0, .115, 0}, {1,1}},
    {{.2, .115, 0}, {1,0}},
    {{.2, -0.115, 0}, {0,0}}
};

const GLushort playerIndices[] = {
    0, 1, 2,
    2, 3, 0
};
const vec2 animationStates[] = {
	{0,0},{1,0},{0,0},{1,1}
};
-(id)initRadius:(float)r theta:(float)t{
	dispatch_once(&token, ^{
		thePlayer = [super initRadius:r theta:t];
	});
    self = thePlayer;
	self.textureDivisor = 2;
	self.textureOffset = (vec2){0,0};
	self.maxHealth = 2;
	self.health = self.maxHealth;
	time = 0;
    [super loadToBuffers:&playerVertices[0] vSize:sizeof(playerVertices) indices:&playerIndices[0] iSize:sizeof(playerIndices) objectName:@"player"];
    [super loadToTexture:@"astronaut.png" mipmapsEnabled:true];
    return self;
}
-(CGRect)getCollisionBox{
    return CGRectMake((+self.radius), -0.04+self.theta, .2, (0.125-0.04) *(1/self.radius));
}
-(void)update:(NSArray<GameEntity *> *)gameObjects{
	
	[super checkCollisions:gameObjects];
	
	

	
	[self updateAnimation];
	
}

-(void)move:(int) moveVal{
	self.theta+=moveVal * MOVE_SPEED * [OpenGLViewController getController].frameTime;
	if(self.entityState != JUMPING){
		if(moveVal != 0){
			self.entityState = WALKING;
		}else{
			self.entityState = STANDING;
		}
	}
	if(moveVal !=0){
		self.rotation = moveVal;
	}
}
-(void)updateAnimation{
	time +=[OpenGLViewController getController].frameTime;
	if(self.entityState == WALKING){
		if(time >0.1){
			animationState++;
			animationState &=3;
			time =0;
		}
		
	}
	else{
		animationState = 0;
	}
	self.textureOffset = animationStates[animationState];
	
	
}
-(BOOL)playerShouldCollide{
	return YES;
}
-(void)setHealth:(float)health{
	@synchronized(self) {
		_health = health;
		if(health <= 0){
			[self die];
		}
	}
}
-(float)health{
	@synchronized(self) {
		return _health;
	}
}
-(void)die{
	[OpenGLViewController getController].gameState = DEAD;
	_health = _maxHealth;
	self.radius = 2;
	self.theta =0;
}
+(Player*)getPlayer{
	return thePlayer;
}


@end
