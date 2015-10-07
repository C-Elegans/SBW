//
//  HealthBar.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 10/5/15.
//  Copyright © 2015 Michael Nolan. All rights reserved.
//

#import "HealthBar.h"
#import "GameGuiProtectedMethods.h"
#import "BarShader.h"
#import "Player.h"
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
@interface HealthBar(){
	CGRect frameRect;
	UIView* parentView;
	BarShader* shader;
}
@end

@implementation HealthBar
const Vertex healthbarVertices[] = {
	0,0,0,              0,1,
	0,0.1,0,            0,0,
	0.5,0.1,0,          1,0,
	0.5,0.0f,0.0f,     1,1,
};
const GLushort healthbarIndices[] = {
	0, 1, 2,
	2, 3, 0
};
-(id)initWithPositionX:(float)x y:(float)y view:(nonnull UIView *)view{
	self = [super initWithPositionX:x y:y view:view];
	[super loadToBuffers:&healthbarVertices[0] vSize:sizeof(healthbarVertices) indices:&healthbarIndices[0] iSize:sizeof(healthbarIndices) objectName:@"healthbar"];
	[super loadToTexture:@"healthbar.png"];
	frameRect = view.frame;
	shader = [BarShader new];
	parentView = view;
	return self;
}
-(CGRect)getBoundingBox{
	return CGRectMake(0, 0, 0, 0);
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
	
}
-(void)render:(Player*)player {
	[shader start];

	glPushGroupMarkerEXT(0, "Rendering Char");
	glActiveTexture(GL_TEXTURE0);
	
	
	glBindVertexArrayOES(self.vaoID);
	[shader enableAttribs];
	
	[shader uploadObjectTransformation:self.x y:self.y];
	
	[shader uploadScreenCorrection:parentView.frame.size];
	[shader uploadAlpha:player.health/player.maxHealth];
	glBindTexture(GL_TEXTURE_2D, self.texture);
	glDrawElements(GL_TRIANGLES, self.numVertices, GL_UNSIGNED_SHORT, 0);
	[shader disableAttribs];
	glBindVertexArrayOES(0);
	
	
	
	
	glPopGroupMarkerEXT();

	[shader stop];
}
@end
