//
//  Player.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/6/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameEntity.h"

@interface Player : GameEntity
-(void)updatePosition:(nullable NSArray* )gameObjects;
-(void)jump;
-(void)move:(int) moveVal;
@end