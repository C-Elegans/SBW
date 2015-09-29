//
//  Bullet.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/28/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameEntity.h"

@interface Bullet : GameEntity
-(void)checkCollisions:(NSArray<GameEntity*>*)gameObjects;
@end
