//
//  Player.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/6/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameEntity.h"
#define JUMP_HEIGHT GRAVITY/3
@interface Player : GameEntity
@property float rVelocity;
@property float health;
@property float maxHealth;
-(void)updatePosition:(nullable NSArray* )gameObjects;
-(void)jump:(float)speed;
-(void)move:(int) moveVal;
-(void)die;
+(Player*)getPlayer;
@end
