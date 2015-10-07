#import "Eyeball.h"
#import "GameEntityProtectedMethods.h"
#import "OpenGLViewController.h"
@interface Eyeball(){
	float time;
	float timeToFire;
	int animationState;
	int firing;
	BOOL light;
}
@end
@implementation Eyeball
const Vertex3D eyeballVertices[] = {
	{{0, -.02, 0}, {0,1,1}},
	{{0, .22, 0}, {1,1,1}},
	{{.22, .2, 0}, {1,0,1}},
	{{.22, 0, 0}, {0,0,1}}
};

const GLushort eyeballIndices[] = {
	0, 1, 2,
	2, 3, 0
};

-(id)initRadius:(float)r theta:(float)t{
	self = [super initRadius:r theta:t];
	
	self.rotation = -1;
	[super loadToBuffers:&eyeballVertices[0] vSize:sizeof(eyeballVertices) indices:&eyeballIndices[0] iSize:sizeof(eyeballIndices)objectName:@"eyeball"];
	[super loadToTexture:@"eyeball.png" mipmapsEnabled:true];
	return self;
}
-(CGRect)getCollisionBox{
	return CGRectMake(0+self.radius, 0+self.theta, .05, .2*(1/self.radius));
}
-(void)update{
	
}
-(BOOL)playerShouldCollide{
	return NO;
}
-(void)onCollisionWith:(GameEntity *)player{
	
	
}
@end