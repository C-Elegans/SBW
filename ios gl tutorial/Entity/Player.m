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
typedef enum{WALKING, JUMPING, STANDING} PlayerState;

@interface Player(){

	PlayerState playerState;
	int animationState;
	float time;
}

@end
@implementation Player
const int playerWidth = 0.359375;
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
    self = [super initRadius:r theta:t];
	self.textureDivisor = 2;
	self.textureOffset = (vec2){0,0};
	time = 0;
    [super loadToBuffers:&playerVertices[0] vSize:sizeof(playerVertices) indices:&playerIndices[0] iSize:sizeof(playerIndices) objectName:@"player"];
    [super loadToTexture:@"astronaut.png" mipmapsEnabled:true];
    return self;
}
-(CGRect)getCollisionBox{
    return CGRectMake((+self.radius), -0.04+self.theta, .2, (0.125-0.04) *(1/self.radius));
}
-(void)updatePosition:(nullable NSArray *)gameObjects{
    _rVelocity -= GRAVITY*([OpenGLViewController getController].frameTime);
    self.radius += _rVelocity;
	if(self.radius < 1.06){
		_rVelocity = 0;
		self.radius = 1.06;
		if(playerState == JUMPING){
			playerState = STANDING;
		}
	}
    CGRect myCollisionBox = [self getCollisionBox];
	
    for(GameEntity* entity in gameObjects){
        if([MathHelper rect:myCollisionBox intersects:entity.getCollisionBox]){
			[entity onCollisionWith:self];
			if([entity playerShouldCollide]){
                vec2 moveVec = [MathHelper moveToUndoCollision:myCollisionBox withRect:entity.getCollisionBox];
                self.radius += moveVec.x;
                self.theta += moveVec.y;
                if(moveVec.x){
                    _rVelocity = 0;
					if(playerState == JUMPING){
						playerState = STANDING;
					}
                }
                //NSLog(@"object intersected! object %@  index %lu",entity, [gameObjects indexOfObject:entity]);
			}
        }
    }
	

	
	[self updateAnimation];
	
}
-(void)jump:(float)speed{
    if(playerState == WALKING || playerState == STANDING){
		playerState = JUMPING;
        _rVelocity = speed;
    }
}
-(void)move:(int) moveVal{
	self.theta+=moveVal * MOVE_SPEED * [OpenGLViewController getController].frameTime;
	if(playerState != JUMPING){
		if(moveVal != 0){
			playerState = WALKING;
		}else{
			playerState = STANDING;
		}
	}
	if(moveVal !=0){
		self.rotation = moveVal;
	}
}
-(void)updateAnimation{
	time +=[OpenGLViewController getController].frameTime;
	if(playerState == WALKING){
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

@end
