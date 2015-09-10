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
#define JUMP_HEIGHT GRAVITY/2
@interface Player(){
    float rVelocity;
    BOOL onGround;
}
@end
@implementation Player
const int playerWidth = 0.359375;
const Vertex playerVertices[] = {
    {{0, 0, 0}, {0.125,1}},
    {{0, .125, 0}, {0.640625,1}},
    {{.2, .125, 0}, {0.640625,0}},
    {{.2, 0, 0}, {0.125,0}}
};

const GLushort playerIndices[] = {
    0, 1, 2,
    2, 3, 0
};
-(id)initRadius:(float)r theta:(float)t{
    self = [super initRadius:r theta:t];
    
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
                    onGround = YES;
                }
                //NSLog(@"object intersected! object %@  index %lu",entity, [gameObjects indexOfObject:entity]);
			}else if (([entity class]==[Door class])){
				//[OpenGLViewController getController].gameState = PAUSED;
				[OpenGLViewController getController].currentLevel++;
			}
        }
    }
    if(self.radius < 1.06){
        rVelocity = 0;
        self.radius = 1.06;
        onGround = YES;
    }
}
-(void)jump{
    if(onGround){
        NSLog(@"Jump!");
        onGround = NO;
        rVelocity = JUMP_HEIGHT;
    }
}
@end
