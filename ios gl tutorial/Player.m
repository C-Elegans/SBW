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
#define JUMP_HEIGHT GRAVITY/2
#define MOVE_SPEED 0.02
typedef enum{WALKING, JUMPING, STANDING} PlayerState;

@interface Player(){
    float rVelocity;
	PlayerState playerState;
	int animationState;
	float time;
}

@end
@implementation Player
const int playerWidth = 0.359375;
const Vertex playerVertices[] = {
    {{0, 0, 0}, {0,1}},
    {{0, .23, 0}, {1,1}},
    {{.2, .23, 0}, {1,0}},
    {{.2, 0, 0}, {0,0}}
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
	_textureDivisor = 2;
	_textureOffset = (vec2){0,0};
	time = 0;
    [super loadToBuffers:&playerVertices[0] vSize:sizeof(playerVertices) indices:&playerIndices[0] iSize:sizeof(playerIndices) objectName:@"player"];
    [super loadToTexture:@"astronaut.png"];
    return self;
}
-(CGRect)getCollisionBox{
    return CGRectMake((0+self.radius), 0+self.theta, .2, .125 *(1/self.radius));
}
-(void)updatePosition:(nullable NSArray *)gameObjects{
    rVelocity -= GRAVITY*(1.0f/30.0f);
    self.radius += rVelocity;
    CGRect myCollisionBox = [self getCollisionBox];
    for(GameEntity* entity in gameObjects){
        if([MathHelper rect:myCollisionBox intersects:entity.getCollisionBox]){
			if(!([entity class]==[Planet class]) && !([entity class]==[Door class])){
                vec2 moveVec = [MathHelper moveToUndoCollision:myCollisionBox withRect:entity.getCollisionBox];
                self.radius += moveVec.x;
                self.theta += moveVec.y;
                if(moveVec.x){
                    rVelocity = 0;
					if(playerState == JUMPING){
						playerState = STANDING;
					}
                }
                //NSLog(@"object intersected! object %@  index %lu",entity, [gameObjects indexOfObject:entity]);
			}else if (([entity class]==[Door class])){
				[OpenGLViewController getController].gameState = LEVEL_CHANGE;
				
			}
        }
    }
    if(self.radius < 1.06){
        rVelocity = 0;
        self.radius = 1.06;
		if(playerState == JUMPING){
			playerState = STANDING;
		}
    }
	[self updateAnimation];
	
}
-(void)jump{
    if(playerState == WALKING || playerState == STANDING){
		playerState = JUMPING;
        rVelocity = JUMP_HEIGHT;
    }
}
-(void)move:(int) moveVal{
	self.theta+=moveVal * MOVE_SPEED;
	if(playerState != JUMPING){
		if(moveVal != 0){
			playerState = WALKING;
		}else{
			playerState = STANDING;
		}
	}
	if(moveVal !=0){
		_rotation = moveVal;
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
	_textureOffset = animationStates[animationState];
	
	
}

@end
