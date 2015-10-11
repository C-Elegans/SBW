//
//  GameEntityDynamic.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/10/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "GameEntityDynamic.h"
#import "GameEntityProtectedMethods.h"
#import "OpenGLViewController.h"
@implementation GameEntityDynamic
-(id)initRadius:(float)r theta:(float)t{
	self = [super initRadius:r theta:t];
	
	return self;
}
-(vec2)checkCollisions:(NSArray<GameEntity*>*)gameObjects{
	self.rVelocity -= GRAVITY*([OpenGLViewController getController].frameTime);
	self.radius += self.rVelocity;
	vec2 collision = (vec2){0,0};
	if(self.radius < 1.06){
		collision.x = 1.06-self.radius;
		self.radius = 1.06;
	}
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
	if(collision.x){
		self.rVelocity = 0;
		if(self.entityState == JUMPING){
			self.entityState = STANDING;
		}
	}
	
	return collision;
}
-(void)jump:(float)speed{
	if(self.entityState == WALKING || self.entityState == STANDING){
		self.entityState = JUMPING;
		_rVelocity = speed;
	}
}
@end
