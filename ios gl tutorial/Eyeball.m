#import "Eyeball.h"
#import "GameEntityProtectedMethods.h"
#import "OpenGLViewController.h"
#import "Player.h"
#import "AIHelper.h"
#define MOVE_SPEED 0.1
@interface Eyeball(){
	
}
@end
@implementation Eyeball


const Vertex eyeballVertices[] = {
	{{0, 0, 0}, {0,1}},
	{{0, .2, 0}, {1,1}},
	{{.22, .2, 0}, {1,0}},
	{{.22, 0, 0}, {0,0}}
};

const GLushort eyeballIndices[] = {
	0, 1, 2,
	2, 3, 0
};

-(id)initRadius:(float)r theta:(float)t{
	self = [super initRadius:r+.11 theta:t+0.1];
	
	self.rotation = -1;
	[super loadToBuffers:&eyeballVertices[0] vSize:sizeof(eyeballVertices) indices:&eyeballIndices[0] iSize:sizeof(eyeballIndices)objectName:@"eyeball"];
	[super loadToTexture:@"eyeball.png" mipmapsEnabled:true];
	return self;
}
-(CGRect)getCollisionBox{
	return CGRectMake(0+self.radius, 0+self.theta, .05, .2*(1/self.radius));
}
-(void)update:(NSArray<GameEntity *> *)gameObjects{
	float frameTime = [OpenGLViewController getController].frameTime;
	Player* player = [Player getPlayer];
	vec2 playerPos = (vec2) {player.radius,player.theta};
	vec2 myPos = (vec2){self.radius,self.theta};
	vec2 moveVec = [AIHelper calculateShortestMoveVectorFrom:myPos to:playerPos];
	self.theta += [MathHelper clamp:moveVec.y min:-MOVE_SPEED*frameTime max:MOVE_SPEED*frameTime];
	if(atanf(moveVec.x/ moveVec.y) > TWO_PI/4 && [MathHelper magnitudeOf:moveVec]>0.2){
		[super jump:JUMP_HEIGHT];
	}
	[super checkCollisions:gameObjects];
	
}
-(BOOL)playerShouldCollide{
	return NO;
}
-(void)onCollisionWith:(GameEntity *)player{
	
	
}
@end