//
//  Turret.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/28/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "Turret.h"
#import "GameEntityProtectedMethods.h"
#import "OpenGLViewController.h"
@interface Turret(){
	float time;
	float timeToFire;
	int animationState;
	int firing;
	BOOL light;
}
@end
@implementation Turret
const Vertex turretVertices[] = {
	{{0, 0, 0}, {0,1}},
	{{0, .2, 0}, {1,1}},
	{{.2, .2, 0}, {1,0}},
	{{.2, 0, 0}, {0,0}}
};

const GLushort turretIndices[] = {
	0, 1, 2,
	2, 3, 0
};

-(id)initRadius:(float)r theta:(float)t{
	self = [super initRadius:r theta:t];
	self.textureDivisor = 2;
	self.textureOffset = (vec2){0,0};
	self.rotation = -1;
	[super loadToBuffers:&turretVertices[0] vSize:sizeof(turretVertices) indices:&turretIndices[0] iSize:sizeof(turretIndices)objectName:@"turret"];
	[super loadToTexture:@"turret.png" mipmapsEnabled:true];
	return self;
}
-(CGRect)getCollisionBox{
	return CGRectMake(0+self.radius, 0+self.theta, .05, .2*(1/self.radius));
}
-(void)update{
	time +=[OpenGLViewController getController].frameTime;
	timeToFire +=[OpenGLViewController getController].frameTime;
	firing--;
	if(firing<0)firing =0;
	if(time >0.5){
		light = ~light;
		time = 0;
	}
	if(timeToFire >2){
		firing = 5;
		Bullet* theBullet = [[Bullet alloc]initRadius:self.radius+0.1 theta:self.theta];
		theBullet.rotation = self.rotation;
		[[OpenGLViewController getController]addBullet:theBullet];
		timeToFire = 0;
	}
	self.textureOffset = (vec2){(float)(firing>0),(float)light};
}
-(BOOL)playerShouldCollide{
	return NO;
}
-(void)onCollisionWith:(GameEntity *)player{
	
	
}
@end