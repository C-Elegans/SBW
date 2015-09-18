//
//  pausepauseButton.m
//  ios gl tutorial
//
//  Created by Michael Nolan on 8/7/15.
//  Copypause © 2015 Michael Nolan. All pauses reserved.
//

#import "PauseButton.h"
#import "OpenGLViewController.h"
#import "GameGuiProtectedMethods.h"
@interface PauseButton (){
	CGRect frameRect;
	UIView* parentView;
}
@end
@implementation PauseButton
const Vertex pauseButtonVertices[] = {
	0,0,0,              0,1,
	0,0.1,0,            0,0,
	0.1,0.1,0,          1,0,
	0.1,0.0f,0.0f,     1,1,
};
const GLushort pauseButtonIndices[] = {
	0, 1, 2,
	2, 3, 0
};
-(id)initWithPositionX:(float)x y:(float)y view:(nonnull UIView *)view{
	self = [super initWithPositionX:x y:y view:view];
	[super loadToBuffers:&pauseButtonVertices[0] vSize:sizeof(pauseButtonVertices) indices:&pauseButtonIndices[0] iSize:sizeof(pauseButtonIndices) objectName:@"pauseButton"];
	[super loadToTexture:@"pauseButton.png"];
	frameRect = view.frame;
	
	parentView = view;
	return self;
}
-(CGRect)getBoundingBox{
	CGSize size = frameRect.size;
	float xDim = size.width;
	float yDim = size.height;
	float x = (self.x +1) *0.5;
	float y = (1-self.y) *0.5;
	//float offset = size.height/size.width;
	
	return CGRectMake(x*xDim, y*yDim, 0.3*0.5*yDim, 0.3*0.5*yDim);
}
-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
	
	for(UITouch* touch in touches){
		if ([MathHelper point:[touch locationInView:parentView] insideBox:[self getBoundingBox]]) {
			[OpenGLViewController getController].gameState = PAUSED;
			
		}
	}
	
}


@end
