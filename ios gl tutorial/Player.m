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
#define JUMP_HEIGHT GRAVITY/2
@interface Player(){
    float yVelocity;
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
    return CGRectMake((0+self.radius), 0+self.theta, .125 *(1/self.radius), .2);
}
-(void)updatePosition:(nullable NSArray *)gameObjects{
    yVelocity -= GRAVITY*(1.0f/30.0f);
    self.radius += yVelocity;
    CGRect myCollisionBox = [self getCollisionBox];
    for(GameEntity* entity in gameObjects){
        if([MathHelper rect:myCollisionBox intersects:entity.getCollisionBox]){
            if(!([entity class]==[Planet class])){
                vec2 moveVec = [MathHelper moveToUndoCollision:myCollisionBox withRect:entity.getCollisionBox];
                self.radius += moveVec.x;
                self.theta += moveVec.y;
                if(moveVec.y){
                    yVelocity = moveVec.y;
                    onGround = YES;
                }
                NSLog(@"object intersected! object %@  index %u",entity, [gameObjects indexOfObject:entity]);
            }
        }
    }
    if(self.radius < 1.1){
        yVelocity = 0;
        self.radius = 1.1;
        onGround = YES;
    }
}
-(void)jump{
    if(onGround){
        NSLog(@"Jump!");
        onGround = NO;
        yVelocity = JUMP_HEIGHT;
    }
}
@end
