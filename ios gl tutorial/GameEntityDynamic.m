//
//  GameEntityDynamic.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/10/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameEntityDynamic.h"
#import "GameEntityProtectedMethods.h"
@implementation GameEntityDynamic
-(id)initRadius:(float)r theta:(float)t{
	self = [super initRadius:r theta:t];
	
	return self;
}
-(vec2)checkCollisions:(NSArray<GameEntity*>*)gameObjects{
	vec2 collision = (vec2){0,0};
	CGRect myCollisionBox = [self getCollisionBox];
	for (GameEntity* entity in gameObjects) {
		if(entity == self){
			continue;
		}
		if([MathHelper rect:myCollisionBox intersects:entity.getCollisionBox]){
			[entity onCollisionWith:self];
			if([entity playerShouldCollide]){
				vec2 moveVec = [MathHelper moveToUndoCollision:myCollisionBox withRect:entity.getCollisionBox];
				self.radius += moveVec.x;
				self.theta += moveVec.y;
				collision.x += moveVec.x;
				collision.y += moveVec.y;
			}
		}
	}
	return collision;
}
@end
