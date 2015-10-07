//
//  Bullet.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/28/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "Bullet.h"
#import "GameEntityProtectedMethods.h"
#import "OpenGLViewController.h"
#import "Player.h"
#define SPEED 0.5
#define MAXDISTANCE (TWO_PI/2)
@interface Bullet(){
	float distanceTraveled;
}
@end
@implementation Bullet
const Vertex bulletVertices[] = {
	{{0, 0, 0}, {0,1}},
	{{0, 0.05, 0}, {1,1}},
	{{.05, .05, 0}, {1,0}},
	{{.05, 0, 0}, {0,0}}
};

const GLushort bulletIndices[] = {
	0, 1, 2,
	2, 3, 0
};
-(id)initRadius:(float)r theta:(float)t{
	self = [super initRadius:r theta:t];
	self.textureDivisor = 2;
	self.textureOffset =(vec2) {1,0};
	[super loadToBuffers:&bulletVertices[0] vSize:sizeof(bulletVertices) indices:&bulletIndices[0] iSize:sizeof(bulletIndices)objectName:@"bullet"];
	[super loadToTexture:@"bullet.png" mipmapsEnabled:true];
	distanceTraveled = 0;
	return self;
}
-(CGRect)getCollisionBox{
	return CGRectMake(self.radius, self.theta, 0.05, .1*(1/self.radius));
}
-(void)update{
	float move = SPEED * [[OpenGLViewController getController] frameTime]*(1/self.radius);
	self.theta += move * self.rotation;
	distanceTraveled += move;
	if(distanceTraveled > MAXDISTANCE){
		[[OpenGLViewController getController] deleteBullet:self];
	}
	if(distanceTraveled > MAXDISTANCE/2){
		self.radius -=[[OpenGLViewController getController] frameTime]*0.05;
		if(self.radius <1.06){
			[[OpenGLViewController getController] deleteBullet:self];
		}
	}
}
-(void)onCollisionWith:(Player *)player{
	[[OpenGLViewController getController] deleteBullet:self];
	player.health -= 1;
	NSLog(@"Bullet Collided");
}
-(void)checkCollisions:(NSArray<GameEntity*>*)gameObjects{
	for(GameEntity* entity in gameObjects){
		if([MathHelper rect:self.getCollisionBox intersects:entity.getCollisionBox]){
			if(entity.playerShouldCollide){
				if([entity class]!= [Player class]){
					[[OpenGLViewController getController] deleteBullet:self];
				}else{
					[self onCollisionWith:entity];
				}
			}
		}
	}
}
-(BOOL)playerShouldCollide{
	return NO;
}
@end
