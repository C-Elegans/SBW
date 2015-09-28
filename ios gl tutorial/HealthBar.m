//
//  HealthBar.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 9/28/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "HealthBar.h"
#import "GameGuiProtectedMethods.h"
@implementation HealthBar
#define WIDTH 0.3
#define HEIGHT 0.05
const Vertex healthBarVertices[] = {
	0,0,0,              0,0.5,
	0,HEIGHT,0,            0,0,
	WIDTH,HEIGHT,0,          1,0,
	WIDTH,0.0f,0.0f,     1,0.5,
	0,0,0,              0,1,
	0,HEIGHT,0,            0,0.5,
	WIDTH,HEIGHT,0,          1,0.5,
	WIDTH,0.0f,0.0f,     1,1,
};
const GLushort healthBarIndices[] = {
	0, 1, 2,
	2, 3, 0,
	4,5,6,
	6,7,4
};
-(id)initWithPositionX:(float)x y:(float)y view:(UIView *)view{
	self = [super initWithPositionX:x y:y view:view];
	[super loadToBuffers:&healthBarVertices[0] vSize:sizeof(healthBarVertices) indices:&healthBarIndices[0] iSize:sizeof(healthBarIndices) objectName:@"healthBar"];
	[super loadToTexture:@"healthBar.png"];
	return self;
}

@end
