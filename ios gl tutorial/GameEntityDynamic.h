//
//  GameEntityDynamic.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/10/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameEntity.h"

@interface GameEntityDynamic : GameEntity
typedef enum{WALKING, JUMPING, STANDING} EntityState;
@property EntityState entityState;
@property float rVelocity;
-(vec2)checkCollisions:(NSArray<GameEntity*>*)gameObjects;
-(void)jump:(float)speed;
@end
