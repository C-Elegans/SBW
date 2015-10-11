//
//  GameEntityDynamic.h
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/10/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameEntity.h"

@interface GameEntityDynamic : GameEntity
-(vec2)checkCollisions:(NSArray<GameEntity*>*)gameObjects;
@end
